import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cuibt/shaared%20sshop/states.dart';
import 'package:shop_app/network/remote/dio.dart';
import 'package:shop_app/modules/cateogries/cateogries_Screen.dart';
import 'package:shop_app/modules/favourite/favourite_Screen.dart';
import 'package:shop_app/modules/product/products_Screen.dart';
import '../../models/addAddressModel.dart';
import '../../models/addCartModel.dart';
import '../../models/addressModel.dart';
import '../../models/cartModel.dart';
import '../../models/categories model.dart';
import '../../models/categoriesDetailsModel.dart';
import '../../models/productModel.dart';
import '../../models/update&Delete.dart';
import '../../models/updateCartModel.dart';
import '../../modules/cartScreen.dart';
import '../../network/endpoint.dart';
import '../../models/changefavorites model.dart';
import '../../models/favModels.dart';
import '../../models/home_model.dart';
import '../../models/loginmodel.dart';
import '../../modules/settings/personal.dart';

class Shopcubit extends Cubit<ShopStates>
{
  Shopcubit() : super(Shopintial());
  static Shopcubit get(context)=>BlocProvider.of(context);
  var currentIndex=0;
  List<Widget>screens=[
    products_Screen(),
    cateogries_Screen(),
    personal(),
    CartScreen(),
  ];
  //////////////////////////////////////////////////////////////////////////////
  /// Change BottomNavigationBar
void ShopChangeBottomNavigationbar(index)
{
  currentIndex=index;
  emit(ShopChangeBottomNavigationBarState());
}

  Map<int,bool>favourites={};
  Map <dynamic ,dynamic> cart = {};

  /////////////////////////////////////////////////////////////////////////////
  /// Get Product Data
  HomeModel ?homeModel;
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
      homeModel!.data!.products.forEach((element)
      {
        cart.addAll({
          element.id : element.inCart
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
  /////////////////////////////////////////////////////////////////////////////
  ProductDetailsModel? productDetailsModel;
  void getProductDataDetails( productId ) {
    productDetailsModel = null;
    emit(productDetailsLoadingState());
    DioHelper.getData(
        url: 'products/$productId',
        token: token
    ).then((value){
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      print('Product Detail '+productDetailsModel!.status.toString());
      emit(productDetailsSuccessState());
    }).catchError((error){
      emit(pproductDetailsErrorState(error.toString()));
      print(error.toString());
    });
  }
  //////////////////////////////////////////////////////////////////////////////
  /// Get Categories
  CategoriesModel ?categoriesModel;
  void getCategories(){
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
  /// Get CategoriesDetails
  CategoryDetailModel? categoriesDetailModel;
  void getCategoriesDetailData( int? categoryID ) {
    emit(CategoryDetailsLoadingState());
    DioHelper.getData(
        url: CATEGORIES_DETAIL,
        query: {
          'category_id':'$categoryID',
        }
    ).then((value){
      categoriesDetailModel = CategoryDetailModel.fromJson(value.data);
      print('categories Detail '+categoriesDetailModel!.status.toString());
      emit(CategoryDetailsSuccessState());
    }).catchError((error){
      emit(CategoryDetailsErrorState(error.toString()));
      print(error.toString());
    });
  }
  //////////////////////////////////////////////////////////////////////////////
  /// Add To Favourites And Remove
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
          getFavorites();

        }else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavouritesModel!));
    }).catchError((error){
   emit(ShopErrorChangeFavoritesState(error));
    });
  }
  //////////////////////////////////////////////////////////////////////////
  /// Get Favourites
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
  /// Get Profile Data
  LoginModel ?userModel;
  void getUserData(){
    emit(ShopLoadingGetUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value)
    {
      userModel = LoginModel.fromJ4son(value.data);
      print('get profile'+userModel!.data!.name!);
      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorGetUserDataState(error.toString()));
    });
  }
  /////////////////////////////////////////////////////////////////////////////
/// Update Profile Data
  LoginModel ?updateUserModel;
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
      updateUserModel = LoginModel.fromJ4son(value.data);
      print('update success'+ updateUserModel!.data!.name!);
      emit(ShopSuccessUpdateUserDataState());
      getUserData();
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorUpdateUserDataState(error.toString()));
    });
  }
  LoginModel ?password;
////////////////////////////////////////////////////////////////////////////////
  ///  Change Password
  void changePassword({
  required String newPassword,
    required String currentPassword,

  })
  {
    emit(ShopLoadingUpdatePasswordState());
    DioHelper.postData(url: CHANGE_PASSWORD,
        token: token,
        data: {
      'current_password':currentPassword,
      'new_password': newPassword,
    }).then((value) {
      password=LoginModel.fromJ4son(value.data);
      emit(ShopSuccessUpdatePasswordState());
      getUserData();

      print('changePassword'+password!.status.toString());
    }).catchError((error){
      printFullText(error.toString());
      emit(ShopErrorUpdatePasswordState(error.toString()));
    });
  }
  /////////////////////////////////////////////////////////////////////////////
  /// Add Address
  AddAddressModel? addAddressModel;
  void addAddress({
    required String name,
    required String city,
    required String region,
    required String details,
    required String notes,
    double latitude = 30.0616863,
    double longitude = 31.3260088,
  }){
    emit(ShopLoadingAddressState());
    DioHelper.postData(
        url: 'addresses',
        token: token,
        data: {
          'name': name,
          'city': city,
          'region': region,
          'details': details,
          'notes': notes,
          'latitude': latitude,
          'longitude': longitude,
        }
    ).then((value){
      addAddressModel = AddAddressModel.fromJson(value.data);
      emit(ShopSuccessAddressState());
      getAddresses();
      print('Add Address '+ addAddressModel!.status.toString());
    }).catchError((error){
      emit(ShopErrorAddressState(error.toString()));
      print(error.toString());
    });
  }
  ///////////////////////////////////////////////////////////////////////////////
  /// Get Address
   late GetAddressModel getAddressModel;
  void getAddresses() {
    emit(ShopLoadingGetAddressState());
    DioHelper.getData(
      url: 'addresses',
      token: token,
    ).then((value){
      getAddressModel = GetAddressModel.fromJson(value.data);
      print('Get Addresses '+ getAddressModel.status.toString());
      emit(ShopSuccessGetAddressState());
    }).catchError((error){
      emit(ShopErrorGetAddressState(error.toString()));
      print(error.toString());
    });
  }
  /////////////////////////////////////////////////////////////////////////////
  /// Update Address
  UpdateAddressModel ? updateAddressModel;
  void updateAddress({
    required int ?addressId,
    required String name,
    required String city,
    required String region,
    required String details,
    required String notes,
    double latitude = 30.0616863,
    double longitude = 31.3260088,
  }){
    emit(ShopLoadingUpdateAddressState());
    DioHelper.putData(
        url: 'addresses/$addressId',
        token: token,
        data: {
          'name': name,
          'city': city,
          'region': region,
          'details': details,
          'notes': notes,
          'latitude': latitude,
          'longitude': longitude,
        }
    ).then((value){
      updateAddressModel = UpdateAddressModel.fromJson(value.data);
      emit(ShopSuccessUpdateAddressState());
      getAddresses();
      print('Update Address '+ updateAddressModel!.status.toString());

    }).catchError((error){
      emit(ShopErrorUpdateAddressState(error.toString()));
      print(error.toString());
    });
  }
  ////////////////////////////////////////////////////////////////////////////
  /// Delete Address
  UpdateAddressModel ? deleteAddressModel;
  void deleteAddress({required addressId}){
    emit(ShopLoadingDeleteAddressState());
    DioHelper.deleteData(
      url: 'addresses/$addressId',
      token: token,
    ).then((value){
      deleteAddressModel = UpdateAddressModel.fromJson(value.data);
      emit(ShopSuccessDeleteAddressState());
      getAddresses();
      print('delete Address '+ deleteAddressModel!.status.toString());

    }).catchError((error){
      emit(ShopErrorDeleteAddressState(error.toString()));
      print(error.toString());
    });
  }

  //////////////////////////////////////////////////////////////////////////////
  /// Add To Cart
  late AddCartModel  addCartModel;
  void addToCart(int? productID) {
    emit(AddCartLoadingState());
    DioHelper.postData(
        url: CART,
        token: token,
        data: {
          'product_id': productID
        }
    ).then((value){
      addCartModel = AddCartModel.fromJson(value.data);
      print('AddCart '+ addCartModel.status.toString());
      getCartData();
      emit(AddCartSuccessState());
    }).catchError((error){
      emit(AddCartErrorState(error.toString()));
      print(error.toString());
    });
  }
  //////////////////////////////////////////////////////////////////////////////
  /// Update Cart
  late UpdateCartModel  updateCartModel;
  void updateCartData(int? cartId,int? quantity) {
    emit(UpdateCartLoadingState());
    DioHelper.putData(
      url: 'carts/$cartId',
      data: {
        'quantity':'$quantity',
      },
      token: token,
    ).then((value){
      updateCartModel = UpdateCartModel.fromJson(value.data);
      print('Update Cart '+ updateCartModel.status.toString());
      emit(UpdateCartSuccessState());
    }).catchError((error){
      emit(UpdateCartErrorState(error.toString()));
      print(error.toString());
    });
  }
  //////////////////////////////////////////////////////////////////////////////
  /// Get Cart Data
  late CartModel  cartModel;
  void getCartData() {
    emit(GetCartLoadingState());
    DioHelper.getData(
      url: CART,
      token: token,
    ).then((value){
      cartModel = CartModel.fromJson(value.data);
      print('Get Cart '+ cartModel.status.toString());
      emit(GetCartSuccessState());
    }).catchError((error){
      emit(GetCartErrorState(error.toString()));
      print(error.toString());
    });
  }
  ///////////////////////////////////////////////////////////////////////////////



}