import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cuibt/shared%20Login/states.dart';
import 'package:shop_app/network/remote/dio.dart';

import '../../network/endpoint.dart';
import '../../models/home_model.dart';
import '../../models/loginmodel.dart';

class Logincubit extends Cubit<LoginStates>
{
  Logincubit() : super(Loginintial());
  static Logincubit get(context)=>BlocProvider.of(context);
  LoginModel ?model;
  var obscuretext = false;
  HomeModel ?homeModel;

  void change_eye()
  {
    obscuretext = !obscuretext;
    emit(Loginchange_eyee());
  }
  
  void userLogin({
  required String email,
    required String password,
})
  {
    emit(ShopLoginLoading());
    DioHelper.postData(url: LOGIN, data: {

      'email':email,
      'password':password,

    },
    ).then((value) {
      print(value.data);
      model=LoginModel.fromJ4son(value.data);

      emit(Shoploginscuess(model!));
    }).catchError((error){
      print(error.toString());

      emit(Shoploginrerror(error.toString()));
    });
  }
 /* void getHomeData(){
    emit(ShopProductLoadingHomeState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);

       print(homeModel!.data!.banners[0].image!);
       print(homeModel!.status);

      homeModel!.data!.products.forEach((element)
      {

      });
      // print(favorites.toString());
      emit(ShopSuccessProductState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorProductState(error.toString()));
    });
  }

  */

}
