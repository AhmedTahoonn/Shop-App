import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cuibt/shaared%20sshop/states.dart';
import 'package:shop_app/styles/icon_broken.dart';

import '../../cuibt/shaared sshop/cubit.dart';
import '../../models/categoriesDetailsModel.dart';


class CategoryProductsScreen extends StatelessWidget {
  final String? categoryName;
  CategoryProductsScreen(this.categoryName);
  @override
  Widget build(BuildContext context) {


     return BlocConsumer<Shopcubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              titleSpacing: 0,
              title:Text('ShopApp',style: TextStyle(
                color: Colors.black
              ),),

              actions: [
                IconButton(
                    onPressed: () {
                    },
                    icon: Icon(IconBroken.Search)),


              ],
            ),
            body: state is CategoryDetailsLoadingState ?
            Center(child: CircularProgressIndicator(),) :  Shopcubit.get(context).categoriesDetailModel!.data.productData.length == 0 ?
            Center(child: Text('Coming Soon',style: TextStyle(fontSize: 50),),) :
            SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  color: Colors.grey[300],
                  child: Column(
                    children: [
                      Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: EdgeInsets.all(15),
                          child: Text('$categoryName',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: List.generate(
                          Shopcubit.get(context).categoriesDetailModel!.data.productData.length,
                              (index) => Shopcubit.get(context).categoriesDetailModel!.data.productData.length == 0 ?
                                 Center(child: Text('Coming Soon',style: TextStyle(fontSize: 50),),) :
                                 productItemBuilder(Shopcubit.get(context).categoriesDetailModel!.data.productData[index],context)
                              ),
                      crossAxisSpacing: 2,
                      childAspectRatio: 0.6,
                      mainAxisSpacing: 2,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
  }

  Widget productItemBuilder (ProductData model,context) {
    return InkWell(
      onTap: (){

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
                  Image(image: NetworkImage('${model.image}'),height: 150,width: 150,),
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
                          Text('EGP',style: TextStyle(color: Colors.grey[800],fontSize: 12,),),
                          Text('${model.price}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
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
                            Text('${model.discount}'+'% OFF',style: TextStyle(color: Colors.red,fontSize: 11),)
                          ],
                        ),
                    ]
                ),
                Spacer(),
                // IconButton(
                //   onPressed: ()
                //   {
                //     Shopcubit.get(context).changeToFavorite(model.id);
                //     print(model.id);
                //   },
                //   icon: Conditional.single(
                //     context: context,
                //     conditionBuilder:(context) => Shopcubit.get(context).favorites[model.id],
                //     widgetBuilder:(context) => Shopcubit.get(context).favoriteIcon,
                //     fallbackBuilder: (context) => Shopcubit.get(context).unFavoriteIcon,
                //   ),
                //   padding: EdgeInsets.all(0),
                //   iconSize: 20,
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }

}
