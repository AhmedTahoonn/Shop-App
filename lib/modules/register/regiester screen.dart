import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/styles/icon_broken.dart';

import '../../cuibt/shared register/cubit-register.dart';
import '../../cuibt/shared register/states_register.dart';

class Register extends StatelessWidget {
  var emailcontroller = TextEditingController();
  var uernamecontroller= TextEditingController();
  var passwordcontroller = TextEditingController();
  var confirmpasswordcontroller = TextEditingController();
  var phonecontroller=TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Registerncubit,RegisterStates>(
      builder:(context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black
            ),
            backgroundColor: Colors.white.withOpacity(0.1),
            elevation: 0.0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(' Register',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10,),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Register now to browse our hot offers',
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
                          return 'username can\'t be empty';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        print(value);
                      },
                      onChanged: (value) {
                        print(value);
                      },
                      controller: uernamecontroller,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'username',
                        prefixIcon: Icon(IconBroken.Profile),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'email address can\'t be empty';
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
                      height: 25.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'password can\'t be empty';
                        }
                        return null;
                      },
                      obscureText: !Registerncubit.get(context).obscuretext,
                      onFieldSubmitted: (value) {},
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
                          icon: Registerncubit.get(context).obscuretext
                              ? Icon(IconBroken.Show): Icon(IconBroken.Hide),
                          onPressed: () {

                            Registerncubit.get(context).change_eye() ;

                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'password can\'t be empty';
                        }
                        else if(value!=passwordcontroller.text)
                        {
                          return'not the same password';
                        }
                        return null;
                      },
                      obscureText: !Registerncubit.get(context).obscuretext,
                      onFieldSubmitted: (value) {},
                      onChanged: (value) {
                        print(value);
                      },
                      controller: confirmpasswordcontroller,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'confirm Password',
                        prefixIcon: Icon(IconBroken.Lock),
                        suffixIcon: IconButton(
                          icon: Registerncubit.get(context).obscuretext
                              ? Icon(IconBroken.Show): Icon(IconBroken.Hide),
                          onPressed: () {

                            Registerncubit.get(context).change_eye() ;

                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'phone number can\'t be empty';
                        }

                        return null;
                      },
                      obscureText: Registerncubit.get(context).obscuretext,
                      onFieldSubmitted: (value) {},
                      onChanged: (value) {
                        print(value);
                      },
                      controller: phonecontroller,

                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        helperText: 'must contain 11 numbers',
                        helperStyle: TextStyle(
                          color: Colors.grey.withOpacity(.7),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,

                        ),
                        labelText: 'phone',
                        prefixIcon: Icon(IconBroken.Call),
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    ConditionalBuilderRec(
                      condition: state is !SocialRegisterLoading,
                      builder: (context) => Container(
                          width: double.infinity,
                          color: Colors.blue,
                          child: MaterialButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                Registerncubit.get(context).userRegister(name: uernamecontroller.text,
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text,
                                    phone: phonecontroller.text
                                );
                              }
                            },
                            child: Text(
                              'REGISTER',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
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
                        Text('I have an account ?',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn(),));
                        }, child: Text('LOGIN NOW')),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      } ,
      listener:(context, state)
      {
        if(state is SocialRegisterscuess)
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn(),));
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
    );
  }
}
