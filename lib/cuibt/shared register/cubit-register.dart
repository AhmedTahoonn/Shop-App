import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cuibt/shared%20register/states_register.dart';
import 'package:shop_app/network/remote/dio.dart';

import '../../network/endpoint.dart';
import '../../models/loginmodel.dart';

class Registerncubit extends Cubit<RegisterStates>
{
  Registerncubit() : super(Registerintial());
  static Registerncubit get(context)=>BlocProvider.of(context);
  var obscuretext = false;

 late LoginModel model;

  void change_eye()
  {
    obscuretext = !obscuretext;
    emit(Registerchange_eyee());
  }
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,

  })
  {
    emit(SocialRegisterLoading());
    DioHelper.postData(url: REGISTER, data: {

      'email':email,
      'password':password,
      'name':name,
      'phone':phone,
    },
    ).then((value) {
      print(value.data);
      model=LoginModel.fromJ4son(value.data);

      emit(SocialRegisterscuess(model));
    }).catchError((error){
      print(error.toString());

      emit(SocialRegistererror(error.toString()));
    });
  }

}
