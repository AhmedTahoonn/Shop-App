import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/styles/icon_broken.dart';

import '../cuibt/shaared sshop/cubit.dart';
import '../cuibt/shaared sshop/states.dart';
import 'search/search_Screen.dart';

class shop_layout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<Shopcubit,ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: Shopcubit.get(context).currentIndex,
            onTap: (index){
              Shopcubit.get(context).ShopChangeBottomNavigationbar(index);
            },
            type: BottomNavigationBarType.fixed,
            items:
            [
              BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Category),label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Profile),label: 'MY Account'),
              BottomNavigationBarItem(icon: Icon(Icons.card_travel),label: 'Cart'),



            ],
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white.withOpacity(0.3),
            elevation: 0.0,
            title: Text('Shop App',style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.black,

            ),

            ),
            actions: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => search_Screen(),));
              }, icon: Icon(IconBroken.Search,color: Colors.black,)),
            ],
          ),
          body: Shopcubit.get(context).screens[Shopcubit.get(context).currentIndex],
        );
      },
    );
  }
}
