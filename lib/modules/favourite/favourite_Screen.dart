import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favModels.dart';
import 'package:shop_app/styles/icon_broken.dart';

import '../../cuibt/shaared sshop/cubit.dart';
import '../../cuibt/shaared sshop/states.dart';

class favourite_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future refresh()async{

      Shopcubit.get(context).getFavorites();
      Shopcubit.get(context).getHomeData();
      await Future.delayed(Duration(seconds:2,),);


    }
    return BlocConsumer<Shopcubit,ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          body:RefreshIndicator(
            onRefresh: refresh,
            child: ConditionalBuilderRec(
              condition: state is !ShopLoadingGetFavoritesState,
              builder: (context)=>ListView.separated(
                itemBuilder: (context, index) => buildFavoritesItem(Shopcubit.get(context).favoritesModel!.data!.data![index],context),
                separatorBuilder:(context, index) =>Container(
                  height: 1,
                  color: Colors.grey,
                ),
                itemCount: Shopcubit.get(context).favoritesModel!.data!.data!.length,
              ),
              fallback: (context)=> Center(child: CircularProgressIndicator()) ,
            ),
          ),

        );
      },
    );
  }
  Widget buildFavoritesItem(FavoritesData model,context)=> Padding(
    padding: const EdgeInsets.only(left: 10.0,top: 10,bottom: 10),
    child: Column(
      children:
      [
        Row(
          children:
          [
            Container(
              height: 120,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children:
                [
                  Image(
                    image: NetworkImage(model.product!.image!),
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                  if(model.product!.discount!=0)
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
            ),
            SizedBox(width: 20,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    model.product!.name!,
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
                        model.product!.price.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(width: 5,),
                      if(model.product!.discount!=0)
                        Text(
                          model.product!.oldPrice.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough
                          ),
                        ),
                      Spacer(),
                      IconButton(onPressed: (){
                         Shopcubit.get(context).changeFavourites(model.product!.id!);

                      }, icon: CircleAvatar(
                        radius: 13,
                        backgroundColor:  Shopcubit.get(context).favourites[model.product!.id]!?Colors.blue:Colors.grey,
                        child: Icon(IconBroken.Heart,color: Colors.white,size: 13,),),iconSize: 12,),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
