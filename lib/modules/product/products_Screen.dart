import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/categories%20model.dart';
import 'package:shop_app/cuibt/shaared%20sshop/cubit.dart';
import 'package:shop_app/cuibt/shaared%20sshop/states.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/styles/icon_broken.dart';

class products_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future refresh()async{

      Shopcubit.get(context).getHomeData();
      Shopcubit.get(context).getGategories();
      Shopcubit.get(context).getUserData();
      await Future.delayed(Duration(seconds:5,),);


    }
    return BlocConsumer<Shopcubit,ShopStates>(
      listener: (context, state) {
           if(state is ShopSuccessChangeFavoritesState)
             {
               if(!state.model.status!)
                 {
                   Fluttertoast.showToast(
                       msg: state.model.message.toString(),
                       toastLength: Toast.LENGTH_LONG,
                       gravity: ToastGravity.BOTTOM,
                       timeInSecForIosWeb: 5,
                       backgroundColor: Colors.red,
                       textColor: Colors.white,
                       fontSize: 16.0
                   );

                 }
             }
      },
      builder: (context, state) {
        return RefreshIndicator(
          color: Colors.blue,

          onRefresh: refresh,
          child: ConditionalBuilderRec(condition: Shopcubit.get(context).homeModel!=null&&Shopcubit.get(context).categoriesModel!=null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
            builder: (context) =>productsBuilder(Shopcubit.get(context).homeModel!,Shopcubit.get(context).categoriesModel!,context),

          ),
        );
      },

    );
  }
  Widget productsBuilder( HomeModel model,CategoriesModel categoriesModel,context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        SizedBox(
          height: 5,
        ),
        CarouselSlider(items:model.data!.banners.map((e) => Image(image: NetworkImage('${e.image}'),width: double.infinity,fit: BoxFit.cover,)
        ).toList(), options:  CarouselOptions(
           height: 250,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(
            seconds: 3,
          ),
          autoPlayAnimationDuration:  Duration(
            seconds: 3,
          ),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        )),
        SizedBox(
          height: 10,
        ),
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,

           children: [
             Text('Categories',
               style: TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.w800,
               ),
             ),

             Container(
               height: 100,
               child: ListView.separated(itemBuilder:(context, index) => buildCategoriesItems(categoriesModel.data!.data[index]) , separatorBuilder: (context, index) => SizedBox(
                 width: 10.0,
               ), itemCount: categoriesModel.data!.data.length,
               scrollDirection: Axis.horizontal,
                 physics: BouncingScrollPhysics(),
               ),
             ) ,
              SizedBox(
                height: 10,
              ),

              Text('New Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
           ],
         ),
       ),
        SizedBox(
          height: 10,
        ),

        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
             mainAxisSpacing: 1,
             crossAxisSpacing: 1,
             childAspectRatio: 1/1.7,
             children:List.generate(model.data!.products.length, (index) => buildGridProduct(model.data!.products[index],context),
             ),

          ),
        ),

      ],
    ),
  );

  Widget buildGridProduct(ProductModel model,context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children:
          [
            Image(
            image: NetworkImage(model.image!),
              width: double.infinity,
              height: 200,
            ),
            if(model.discount!=0)
            Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Text(
                'Discount',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Row(
                children:
                [
                  Text(
                    '${model.price.round()}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 5,),
                  if(model.discount!=0)
                    Text(
                    '${model.oldPrice.round()}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough
                    ),
                  ),
                  Spacer(),
                  IconButton(onPressed: (){
                    Shopcubit.get(context).changeFavourites(model.id!);

                    print(model.id);
                    }, icon: CircleAvatar(
                      radius: 13,
                      backgroundColor: Shopcubit.get(context).favourites[model.id!]!?Colors.blue:Colors.grey,
                      child: Icon(IconBroken.Heart,color: Colors.white,size: 13,),),iconSize: 12,),

                ],
              ),
            ],
          ),
        ),

      ],
    ),
  );
  Widget buildCategoriesItems(DataModel model)=>  Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children:
    [
      Image(image: NetworkImage(model.image!),
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
      Container(
        width: 100,
        color: Colors.black.withOpacity(0.8),
        child: Text(
          model.name!,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
    ],
  );
}
