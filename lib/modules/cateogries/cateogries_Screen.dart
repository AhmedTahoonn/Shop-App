import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories%20model.dart';
import 'package:shop_app/cuibt/shaared%20sshop/cubit.dart';
import 'package:shop_app/cuibt/shaared%20sshop/states.dart';
import 'package:shop_app/styles/icon_broken.dart';

import 'categoryProductsScreen.dart';

class cateogries_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future refresh()async{

      Shopcubit.get(context).getCategories();
      await Future.delayed(Duration(seconds:2,),);


    }
    return BlocConsumer<Shopcubit,ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
            body: RefreshIndicator(
              onRefresh: refresh,
              child: ListView.separated(itemBuilder: (context, index) =>buildCatItem(Shopcubit.get(context).categoriesModel!.data!.data[index],context) , separatorBuilder: (context, index) => SizedBox(
                height: 20,
              ), itemCount: Shopcubit.get(context).categoriesModel!.data!.data.length
              ),
            ),
        );
      },
    );
  }

 Widget buildCatItem(DataModel model,context)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: InkWell(
      onTap: (){
        Shopcubit.get(context).getCategoriesDetailData(model.id);
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  CategoryProductsScreen(model.name),));
      },
      child: Row(
        children:
        [
          Stack(
            children: [
              CircleAvatar(
                radius: 31,
                backgroundColor: Colors.red,
              ),
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(model.image!),

              ),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(model.name!,
              maxLines: 1,

              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                fontStyle: FontStyle.italic

              ),
            ),
          ),
          Spacer(),
          Icon(IconBroken.Arrow___Right_2),
        ],
      ),
    ),
  );


}
