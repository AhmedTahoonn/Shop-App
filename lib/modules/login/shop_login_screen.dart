import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/network/endpoint.dart';
import 'package:shop_app/network/local/cachHelper.dart';
import 'package:shop_app/modules/register/regiester%20screen.dart';
import 'package:shop_app/modules/shop_layout.dart';
import 'package:shop_app/styles/icon_broken.dart';

import '../../cuibt/shared Login/cubit.dart';
import '../../cuibt/shared Login/states.dart';


class LogIn extends StatelessWidget {
  var emailcontroller = TextEditingController();

  var passwordcontroller = TextEditingController();

  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Logincubit(),
      child: BlocConsumer<Logincubit,LoginStates>(
        builder:(context, state) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10,),
                        AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              'login now to browse our hot offers',
                              textStyle: const TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                              speed: const Duration(milliseconds: 30),
                            ),
                          ],
                          isRepeatingAnimation: false,
                          totalRepeatCount: 4,
                          pause: const Duration(milliseconds: 1000),
                          displayFullTextOnTap: false,
                          stopPauseOnTap: false,
                        ),


                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'wrong email address';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            print(value);
                          },
                          onChanged: (value) {
                            print(value);
                          },
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email Address',
                            prefixIcon: Icon(IconBroken.Message),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password can\'t be empty';
                            }
                            return null;
                          },
                          obscureText: !Logincubit.get(context).obscuretext,
                          onFieldSubmitted: (value) {
                            if (formkey.currentState!.validate()) {
                              Logincubit.get(context).userLogin(email: emailcontroller.text, password: passwordcontroller.text);
                            }
                          },
                          onChanged: (value) {
                            print(value);
                          },
                          controller: passwordcontroller,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            prefixIcon: Icon(IconBroken.Lock),
                            suffixIcon: IconButton(
                              icon: Logincubit.get(context).obscuretext
                                  ? Icon(IconBroken.Show): Icon(IconBroken.Hide),
                              onPressed: () {

                                Logincubit.get(context).change_eye() ;

                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilderRec(
                          builder: (context) => Container(
                              width: double.infinity,
                              color: Colors.blue,
                              child: MaterialButton(
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    Logincubit.get(context).userLogin(email: emailcontroller.text, password: passwordcontroller.text);
                                  }

                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(IconBroken.Login,color: Colors.white,),
                                    SizedBox(width: 5,),
                                    Text(
                                      'LOGIN',
                                      style: TextStyle(color: Colors.white,
                                      fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          condition: state is !ShopLoginLoading,
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Text('I don\'t have an account ?',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            TextButton(onPressed: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => Register(),));
                            }, child: Text('REGISTER NOW')),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );

        } ,
        listener:(context, state) {

 if(state is Shoploginscuess)
   {
     if(state.model.status!)
       {
         print(state.model.message);
         print(state.model.data!.token);
         Fluttertoast.showToast(
             msg: state.model.message.toString(),
             toastLength: Toast.LENGTH_LONG,
             gravity: ToastGravity.BOTTOM,
             timeInSecForIosWeb: 5,
             backgroundColor: Colors.green,
             textColor: Colors.white,
             fontSize: 16.0
         );
         CacheHelper.saveData(key: 'token', value: state.model.data!.token).then((value) {
           token=state.model.data!.token!;
           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => shop_layout(),), (route) => true);
         });

       }
     else
       {
         print(state.model.message);
         Fluttertoast.showToast(
             msg: state.model.message.toString(),
             toastLength: Toast.LENGTH_LONG,
             gravity: ToastGravity.BOTTOM,
             timeInSecForIosWeb: 5,
             backgroundColor: Colors.red,
             textColor: Colors.white,
             fontSize: 16.0
         );
       }
   }
        } ,
      ),
    );
  }
}
