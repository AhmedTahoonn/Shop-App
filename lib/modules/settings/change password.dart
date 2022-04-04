import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cuibt/shaared sshop/cubit.dart';
import '../../cuibt/shaared sshop/states.dart';
import '../../styles/icon_broken.dart';

class changePassword extends StatelessWidget {
  TextEditingController currentPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  var changePasskey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit,ShopStates>(
      builder: (context, state) {
       return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            titleSpacing: 0,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title:Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('ShopApp',style: TextStyle(
                color: Colors.black
              ),),
            ),
            actions:
            [
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text('CANCEL',style: TextStyle(color: Colors.grey),),
              ),
            ],
          ),
          body: Container(
              color: Colors.white,
              width: double.infinity,
              //height: 280,
              padding: EdgeInsets.all(20),
              child: Form(
                key:changePasskey ,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children :
                    [
                      if(state is ShopLoadingUpdatePasswordState)
                        Column(
                          children: [
                            LinearProgressIndicator(),
                            SizedBox(height: 20,),
                          ],
                        ),
                      Text('Current Password',style: TextStyle(fontSize: 16,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                      TextFormField(
                          controller: currentPass,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                              contentPadding:EdgeInsets.all(15) ,
                              hintText : 'Current password',
                              hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                              border: UnderlineInputBorder(),
                              suffixIcon: IconButton(
                                  onPressed: (){
                                  },
                                  icon: Icon(Icons.remove_red_eye)
                              )
                          ),
                          validator: (value){
                            if(value!.isEmpty)
                              return 'This field cant be Empty';
                          }
                      ),
                      SizedBox(height: 40,),
                      Text('New Password',style: TextStyle(fontSize: 16,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                      TextFormField(
                          controller: newPass,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                              contentPadding:EdgeInsets.all(15) ,
                              hintText : ' New Password',
                              hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                              border: UnderlineInputBorder(),
                              suffixIcon: IconButton(
                                  onPressed: (){
                                  },
                                  icon: Icon (Icons.remove_red_eye)
                              )
                          ),
                          validator: (value){
                            if(value!.isEmpty)
                              return 'This field cant be Empty';
                          }),
                      Spacer(),
                      Container(
                        height: 40,
                        width: double.infinity,

                        child: ElevatedButton(
                            onPressed: (){
                              if(changePasskey.currentState!.validate())
                              {
                                Shopcubit.get(context).changePassword(newPassword: newPass.text, currentPassword:currentPass.text );
                              }
                            },
                            child: Text('Change Password')
                        ),
                      ),

                    ]),
              )
          ),
        );
      },
      listener: (context,state){

      },
    );
  }
}
