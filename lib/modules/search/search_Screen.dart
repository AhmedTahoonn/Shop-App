import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cuibt/search%20shared/search%20cuibt.dart';
import 'package:shop_app/cuibt/search%20shared/searchstates.dart';
import 'package:shop_app/models/search%20model.dart';
import 'package:shop_app/styles/icon_broken.dart';

import '../../cuibt/shaared sshop/cubit.dart';

class search_Screen extends StatelessWidget {
var formKey=GlobalKey<FormState>();
var sreachController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:  (context) =>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
          listener: (context, state) {

          },
        builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white.withOpacity(0.4),
                elevation: 0.0,
                automaticallyImplyLeading: false,
                title: Text(
                  'Search',style: TextStyle(
                  color: Colors.black,
                      fontWeight: FontWeight.w500,
                ),
                ),
              ),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children:
                    [
                      TextFormField(
                        onFieldSubmitted: (text){
                          SearchCubit.get(context).search(text);
                        },
                        validator: (value)
                        {
                          if(value!.isEmpty)
                            {
                              return 'enter text';

                            }
                          else
                            {
                              return null;
                            }
                        },
                        controller: sreachController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Search',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(IconBroken.Search),

                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.builder(itemBuilder: (context, index) => buildSearchItem(SearchCubit.get(context).model!.data!.data![index], context,isOldPrice: false),
                            itemCount:SearchCubit.get(context).model!.data!.data!.length,

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
        },
      ),
    );
  }
Widget buildSearchItem(Product model,context,{bool isOldPrice=true,})=> Padding(
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
                  image: NetworkImage(model.image!),
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                if(model.discount!=0&&isOldPrice)
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
                      model.price.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(width: 5,),
                    if(model.discount!=0&&isOldPrice)
                      Text(
                        model.oldPrice.toString(),
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

                    }, icon: CircleAvatar(
                      radius: 13,
                      backgroundColor:  Shopcubit.get(context).favourites[model.id]!?Colors.blue:Colors.grey,
                      child: Icon(Icons.favorite_border_sharp,color: Colors.white,size: 13,),),iconSize: 12,),

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
