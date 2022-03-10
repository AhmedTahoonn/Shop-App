
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cuibt/shaared%20sshop/cubit.dart';
import 'package:shop_app/cuibt/shaared%20sshop/states.dart';
import 'package:shop_app/network/endpoint.dart';
import 'package:shop_app/styles/icon_broken.dart';

import '../../network/local/cachHelper.dart';
import '../shop_login_screen.dart';

class settings_Screen extends StatelessWidget {
 var nameController=TextEditingController();
 var emailController=TextEditingController();
 var phoneController=TextEditingController();

 @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit,ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessGetUserDataState)
          {

          }
      },
      builder: (context,state){
        var model=Shopcubit.get(context).userModel;
        nameController.text=model!.data!.name!;
        emailController.text=model.data!.email!;
        phoneController.text=model.data!.phone!;


        return ConditionalBuilderRec(
          condition:Shopcubit.get(context).userModel!=null ,
          builder:(context)=>Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children:
                [if(state is ShopLoadingUpdateUserDataState)
                  LinearProgressIndicator(
                    color: Colors.lightBlue,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),

                      labelText: 'Name',
                      prefixIcon: Icon(IconBroken.Profile),
                    ),

                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      prefixIcon: Icon(IconBroken.Message),
                    ),

                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),

                      labelText: 'Phone',
                      prefixIcon: Icon(IconBroken.Call),
                    ),

                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    child: MaterialButton(color: Colors.blue,
                      onPressed: (){
                      Shopcubit.get(context).updateUserData(name: nameController.text, email: emailController.text, phone: phoneController.text);

                      },child: Text('UPDATE',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),),
                  ),
                  SizedBox(
                    height: 20,
                  ),


                  Container(
                    width: double.infinity,
                    height: 40,
                    child: MaterialButton(color: Colors.blue,
                      onPressed: (){
                        CacheHelper.removerData(key:'token').then((value) {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LogIn(),), (route) => true);
                        });

                      },child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(IconBroken.Logout,color: Colors.white,),
                          SizedBox(width: 5,),
                          Text('LOGOUT',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          ),
                        ],
                      ),),
                  )

                ],
              ),
            ),
          ) ,
          fallback: (context)=>Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }
}
