import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories%20model.dart';
import 'package:shop_app/cuibt/shaared%20sshop/cubit.dart';
import 'package:shop_app/cuibt/shaared%20sshop/states.dart';

class cateogries_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future refresh()async{

      Shopcubit.get(context).getGategories();
      await Future.delayed(Duration(seconds:2,),);


    }
    return BlocConsumer<Shopcubit,ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
            body: RefreshIndicator(
              onRefresh: refresh,
              child: ListView.separated(itemBuilder: (context, index) =>buildCatItem(Shopcubit.get(context).categoriesModel!.data!.data[index]) , separatorBuilder: (context, index) => Container(
                height: 1,
                color: Colors.grey,
              ), itemCount: Shopcubit.get(context).categoriesModel!.data!.data.length
              ),
            ),
        );
      },
    );
  }
  Widget buildCatItem(DataModel model)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Image(image: NetworkImage(model.image!),
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(model.name!,
            maxLines: 1,

            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,

            ),
          ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}
