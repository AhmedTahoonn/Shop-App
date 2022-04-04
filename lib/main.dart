import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_layout.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'cuibt/bloc_observe.dart';
import 'cuibt/shaared sshop/cubit.dart';
import 'cuibt/shared Login/cubit.dart';
import 'cuibt/shared Login/states.dart';
import 'cuibt/shared register/cubit-register.dart';
import 'network/local/cachHelper.dart';
import 'network/remote/dio.dart';
import 'network/endpoint.dart';
import 'modules/on boarding/onboarding_layout.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  DioHelper.init();
 await CacheHelper.init();
 Widget widget;
  var onBoarding=CacheHelper.getData(key: 'onBoarding');
  token=CacheHelper.getData(key: 'token');

  print(token);
if(onBoarding!=null)
  {
    if(token != null)
      {
        widget=shop_layout();
      }
    else
      {
        widget =LogIn();
      }
  }else{
  widget=OnBoardingScreen();
}
  runApp( MyApp(widget));
}

class MyApp extends StatelessWidget {
final Widget startWidget;
MyApp(this.startWidget);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
      BlocProvider( create: (context) => Logincubit(),
    ),
        BlocProvider( create: (context) => Shopcubit()..getHomeData()..getCategories()..getFavorites()..getUserData()..getAddresses()..getCartData(),
        ),
        BlocProvider( create: (context) => Registerncubit(),
        ),

      ],
      child: BlocConsumer<Logincubit,LoginStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.grey,
            ),
            home:startWidget                                                                   //onBoarding?LogIn(): OnBoardingScreen(),
          );
        },
      ),
    );
  }
}


