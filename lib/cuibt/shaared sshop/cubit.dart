import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cuibt/shaared%20sshop/states.dart';
import 'package:shop_app/network/remote/dio.dart';
import 'package:shop_app/modules/cateogries/cateogries_Screen.dart';
import 'package:shop_app/modules/favourite/favourite_Screen.dart';
import 'package:shop_app/modules/product/products_Screen.dart';
import 'package:shop_app/modules/settings/settings_Screen.dart';

import '../../models/categories model.dart';
import '../../network/endpoint.dart';
import '../../models/changefavorites model.dart';
import '../../models/favModels.dart';
import '../../models/home_model.dart';
import '../../models/loginmodel.dart';

class Shopcubit extends Cubit<ShopStates>
{
  Shopcubit() : super(Shopintial());
  static Shopcubit get(context)=>BlocProvider.of(context);
  var currentIndex=0;
  List<Widget>screens=[
    products_Screen(),
    cateogries_Screen(),
    favourite_Screen(),
    settings_Screen(),
  ];
void ShopChangeBottomNavigationbar(index)
{
  currentIndex=index;
  emit(ShopChangeBottomNavigationbarState());
}
/*void getHomeData()
{
  emit(ShopLoadingHomeState());
  DioHelper.getData(url: 'home',token: token).then((value) {
    homeModel=HomeModel.fromJson(value.data);
    print('aaaaaaaaaa');
    printFullText( homeModel.toString());
    printFullText( homeModel!.status);
   // printFullText(homeModel!.data!.banners[0].image);

    emit(ShopSuccessHomeState());

  }).catchError((error){
    print(error.toString());
    emit(ShopErrorHomeState());

  });
}
*/
  HomeModel ?homeModel;
  Map<int,bool>favourites={};


  void getHomeData(){
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
       favourites.addAll({
         element.id!:element.inFavourites!,

       });
      });
       print(favourites.toString());
      emit(ShopSuccessProductState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorProductState(error.toString()));
    });
  }
  ////////////////////////////////////////////////////////////////////////
  CategoriesModel ?categoriesModel;

  void getGategories(){
    emit(ShopProductLoadingHomeState());

    DioHelper.getData(
      url: GET_GATEGORIES,
      token: token,
    ).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value.data);
         print(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorCategoriesState(error.toString()));
    });
  }
  //////////////////////////////////////////////////////////////////////////////
  ChangeFavouritesModel ?changeFavouritesModel;
  void changeFavourites(int productId)
  {
    favourites[productId]=!favourites[productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(url: FAVORITES,data:
    {
      'product_id':productId,
    },
      token: token,

    ).then((value) {
      changeFavouritesModel=ChangeFavouritesModel.fromjson(value.data);
      print(value.data);
      if(!changeFavouritesModel!.status!)
        {
          favourites[productId]=!favourites[productId]!;

        }else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavouritesModel!));
    }).catchError((error){
   emit(ShopErrorChangeFavoritesState(error));
    });
  }
  //////////////////////////////////////////////////////////////////////////
  FavoritesModel ?favoritesModel;

  void getFavorites(){
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value.data
      );
      print(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorGetFavoritesState(error.toString()));
    });
  }
  ///////////////////////////////////////////////////////////////////////////
  LoginModel ?userModel;

  void getUserData(){
    emit(ShopLoadingGetUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value)
    {
      userModel = LoginModel.fromJ4son(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorGetUserDataState(error.toString()));
    });
  }
  /////////////////////////////////////////////////////////////////////////////

  void updateUserData(
  {
  required String name,
    required String email,
    required String phone,


  }
      ){
    emit(ShopLoadingUpdateUserDataState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'phone':phone,
        'email':email,

      }
    ).then((value)
    {
      userModel = LoginModel.fromJ4son(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccessUpdateUserDataState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorUpdateUserDataState(error.toString()));
    });
  }




}