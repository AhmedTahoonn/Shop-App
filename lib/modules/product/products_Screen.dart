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

import '../cateogries/categoryProductsScreen.dart';
import 'productScreen.dart';

class products_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future refresh()async{

      Shopcubit.get(context).getHomeData();
      Shopcubit.get(context).getCategories();
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
          autoPlay: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          height: 200,
          initialPage: 0,
          reverse: false,
          scrollDirection: Axis.horizontal,
          viewportFraction: 1,
          autoPlayInterval: Duration(
            seconds: 5,
          ),
          autoPlayAnimationDuration:  Duration(
            seconds: 5,
          ),
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
             SizedBox(
               height: 10,
             ),

             Container(
               height: 100,
               child: ListView.separated(itemBuilder:(context, index) => categoriesAvatar(categoriesModel.data!.data[index],context) , separatorBuilder: (context, index) => SizedBox(
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
             children:List.generate(model.data!.products.length, (index) => productItemBuilder(model.data!.products[index],context),
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
              height: 180,
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
          child: Expanded(
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
                    Text('EGP',style: TextStyle(color: Colors.grey[800],fontSize: 12,),),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${model.price.round()}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(width: 5,),
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
              ],
            ),
          ),
        ),

      ],
    ),
  );
  Widget productItemBuilder (ProductModel model,context) {
    return InkWell(
      onTap: (){
        Shopcubit.get(context).getProductDataDetails(model.id);
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen(),));
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsetsDirectional.only(start: 8,bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Stack(
                alignment:AlignmentDirectional.bottomStart,
                children:[
                  Image(image: NetworkImage('${model.image}'),height: 180,),
                  if(model.discount != 0 )
                    Container(
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text('Discount',style: TextStyle(fontSize: 14,color: Colors.white),),
                        )
                    )
                ]),
            Text('${model.name}',maxLines: 3, overflow: TextOverflow.ellipsis,),
            Spacer(),
            Row(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('EGP',style: TextStyle(color: Colors.black,fontSize: 12,),),
                          SizedBox(
                            width: 5,
                          ),
                          Text('${model.price}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),),
                        ],
                      ),
                      if(model.discount != 0 )
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('EGP',style: TextStyle(color: Colors.grey,fontSize: 10,decoration: TextDecoration.lineThrough,),),
                            Text('${model.oldPrice}',
                              style: TextStyle(
                                  fontSize: 12,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey),
                            ),
                            SizedBox(width: 5,),
                            Text('${model.discount}'+'% OFF',style: TextStyle(color: Colors.red,fontSize: 11),)
                          ],
                        ),
                    ]
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
            )
          ],
        ),
      ),
    );
  }

  Widget categoriesAvatar(DataModel model,context) {
    return InkWell(
      onTap: (){
        Shopcubit.get(context).getCategoriesDetailData(model.id);
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  CategoryProductsScreen(model.name),));
      },
      child: Column(
        children:
        [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.red,
                radius:36 ,
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 35,
                child: Image(
                  image: NetworkImage('${model.image}'),
                  width: 50,
                  height: 50,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Text('${model.name}'),
        ],
      ),
    );
  }
}
