
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cuibt/shaared%20sshop/cubit.dart';
import 'package:shop_app/cuibt/shaared%20sshop/states.dart';
import 'package:shop_app/network/endpoint.dart';
import 'package:shop_app/styles/icon_broken.dart';

import '../../network/local/cachHelper.dart';
import 'change password.dart';
import '../login/shop_login_screen.dart';

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
        Shopcubit cubit=Shopcubit.get(context);


        return ConditionalBuilderRec(
          condition:Shopcubit.get(context).userModel!=null ,
          builder:(context)=>Scaffold(
            appBar:  AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(onPressed: (){
                Navigator.pop(context);
              },icon: Icon(IconBroken.Arrow___Left_2,color: Colors.black,)),
              backgroundColor: Colors.white.withOpacity(0.3),
              elevation: 0.0,
              title: Text('Shop App',style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.black,

              ),

              ),

            ),
            body: SafeArea(
              child: SingleChildScrollView(
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
                    if(state is ShopLoadingUpdateUserDataState)
                    LinearProgressIndicator(
                      color: Colors.lightBlue,
                    ),
                    Container(
                     width: double.infinity,
                     height: 25,
                      color: Colors.grey[400],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('PERSONAL INFORMATION',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                          Spacer(),
                          TextButton(onPressed: (){
                            Shopcubit.get(context).updateUserData(name: nameController.text, email: emailController.text, phone: phoneController.text);

                          }, child: Text('Update'))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(

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

                        labelText: 'Phone',
                        prefixIcon: Icon(IconBroken.Call),
                      ),

                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      width: double.infinity,
                      height: 25,
                      color: Colors.grey[400],
                    ),
                    SizedBox(
                      height: 20,
                    ),


                    Container(
                      color: Colors.white,
                      width: double.infinity,

                      padding: EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('SECURITY INFORMATION',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          OutlinedButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => changePassword(),));
                              },
                              child: Text('Change Password')
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ),
          ) ,
          fallback: (context)=>Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }
}
