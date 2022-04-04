import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/styles/icon_broken.dart';

import '../../cuibt/shaared sshop/cubit.dart';
import '../../cuibt/shaared sshop/states.dart';
import '../address/address screen.dart';
import '../favourite/favourite_Screen.dart';
import 'settings_Screen.dart';
import '../login/shop_login_screen.dart';
import '../../network/local/cachHelper.dart';

class personal extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit,ShopStates>(
      builder: (context, state) {
        Shopcubit cubit=Shopcubit.get(context);
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            color: Colors.grey[300],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome ${cubit.userModel!.data!.name!.split(' ').elementAt(0)}',
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                      Text('${cubit.userModel!.data!.email}',style: TextStyle(fontSize: 15),),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(15),
                    child: Text('MY ACCOUNT',style: TextStyle(color: Colors.grey,fontSize: 15),)),
                Card(
                  child: Column(
                    children:
                    [
                      ListTile(
                        title: Text('WishList',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontStyle: FontStyle.italic),),
                        leading:Icon(IconBroken.Heart,color: Colors.green,),
                        trailing:  Icon(IconBroken.Arrow___Right_2),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => favourite_Screen(),));
                        },
                      ),
                      ListTile(
                        title: Text('Address',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontStyle: FontStyle.italic),),
                        leading:Icon(IconBroken.Location,color: Colors.green,),
                        trailing:  Icon(IconBroken.Arrow___Right_2),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddressesScreen(),));
                        },
                      ),
                      ListTile(
                        title: Text('Profile',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontStyle: FontStyle.italic),),
                        leading:Icon(IconBroken.Profile,color: Colors.green,),
                        trailing:  Icon(IconBroken.Arrow___Right_2),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => settings_Screen(),));

                        },
                      ),



                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(15),
                    child: Text('SETTINGS',style: TextStyle(color: Colors.grey,fontSize: 15),)),
                Card(
                  child: Column(
                    children:
                    [
                      ListTile(
                        title: Text('Dark Mode',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontStyle: FontStyle.italic),),
                        leading:Icon(Icons.dark_mode_outlined,color: Colors.green,),
                        trailing:  Icon(IconBroken.Arrow___Right_2),
                        onTap: (){},
                      ),
                      ListTile(
                        title: Text('Country',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontStyle: FontStyle.italic),),
                        leading:Icon(Icons.map_outlined,color: Colors.green,),
                        trailing:  Icon(IconBroken.Arrow___Right_2),
                        onTap: (){},
                      ),
                      ListTile(
                        title: Text('Language',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontStyle: FontStyle.italic),),
                        leading:Icon(Icons.map_outlined,color: Colors.green,),
                        trailing:  Icon(IconBroken.Arrow___Right_2),
                        onTap: (){},
                      ),




                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(15),
                    child: Text('REACH OUT TO US',style: TextStyle(color: Colors.grey,fontSize: 15),)),
                Card(
                  child: Column(
                    children:
                    [
                      ListTile(
                        title: Text('FAQs Mode',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontStyle: FontStyle.italic),),
                        leading:Icon(IconBroken.Info_Circle,color: Colors.green,),
                        trailing:  Icon(IconBroken.Arrow___Right_2),
                        onTap: (){},
                      ),
                      ListTile(
                        title: Text('Contact Us',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontStyle: FontStyle.italic),),
                        leading:Icon(IconBroken.Calling,color: Colors.green,),
                        trailing:  Icon(IconBroken.Arrow___Right_2),
                        onTap: (){},
                      ),



                    ],
                  ),
                ),

                SizedBox(height: 15,),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  height: 60,
                  child: InkWell(
                    onTap: (){
                      CacheHelper.removerData(key:'token').then((value) {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LogIn(),), (route) => true);
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        Icon(IconBroken.Logout),
                        SizedBox(width: 10,),
                        Text('SignOut',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontStyle: FontStyle.italic),)
                      ],
                    ),
                  ),
                ),






              ],
            ),
          ),
        );
      },
      listener: (context,state){},
    );

  }
  Widget Size()=>SizedBox(
    width: 10,
  );
}
