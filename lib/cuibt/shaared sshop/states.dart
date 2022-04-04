
import '../../models/changefavorites model.dart';
import '../../models/loginmodel.dart';
/// Abstract
abstract class ShopStates {

}
////////////////////////////////////////////////////////////////////////////////
/// Start
class Shopintial extends ShopStates{}
///////////////////////////////////////////////////////////////////////////////
/// BottomNavigation
class ShopChangeBottomNavigationBarState extends ShopStates{}
////////////////////////////////////////////////////////////////////////////////

class ShopLoadingHomeState extends ShopStates{}
class ShopSuccessHomeState extends ShopStates{}
class ShopErrorHomeState extends ShopStates{}
//////////////////////////////////////////////////////////////////////////////
class ShopProductLoadingHomeState extends ShopStates{}
class ShopSuccessProductState extends ShopStates{}
class ShopErrorProductState extends ShopStates
{
  final String error;
  ShopErrorProductState(this.error);
}
//////////////////////////////////////////////////////////////////////////////
class ShopCategoriesLoadingHomeState extends ShopStates{}
class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates {
  final String error;

  ShopErrorCategoriesState(this.error);
}
///////////////////////////////////////////////////////////////////////////////
class ShopChangeFavoritesLoadingHomeState extends ShopStates{}
class ShopSuccessChangeFavoritesState extends ShopStates {
final ChangeFavouritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErrorChangeFavoritesState extends ShopStates {
  final String error;
  ShopErrorChangeFavoritesState(this.error);
}
//////////////////////////////////////////////////////////////////////////////
class ShopChangeFavoritesState extends ShopStates
{

}
///////////////////////////////////////////////////////////////////////////////
//   get fav
class ShopSuccessGetFavoritesState extends ShopStates {

}
class ShopErrorGetFavoritesState extends ShopStates {
  final String error;

  ShopErrorGetFavoritesState(this.error);
}
class ShopLoadingGetFavoritesState extends ShopStates
{

}
////////////////////////////////////////////////////////////////////////////////
// get userrr data
class ShopSuccessGetUserDataState extends ShopStates
{
final LoginModel loginModel;
ShopSuccessGetUserDataState(this.loginModel);

}
class ShopErrorGetUserDataState extends ShopStates {
  final String error;

  ShopErrorGetUserDataState(this.error);
}
class ShopLoadingGetUserDataState extends ShopStates
{

}
/////////////////////////////////////////////////////////////////////////////
//updateeeeee user name , phone ,email
class ShopErrorUpdateUserDataState extends ShopStates {
  final String error;

  ShopErrorUpdateUserDataState(this.error);
}
class ShopLoadingUpdateUserDataState extends ShopStates
{

}
class ShopSuccessUpdateUserDataState extends ShopStates
{

}
////////////////////////////////////////////////////////////////////////////////
// upsateeee passwword
class ShopErrorUpdatePasswordState extends ShopStates {
  final String error;

  ShopErrorUpdatePasswordState(this.error);
}
class ShopLoadingUpdatePasswordState extends ShopStates
{

}
class ShopSuccessUpdatePasswordState extends ShopStates {
}
////////////////////////////////////////////////////////////////////////////////
// addressss
class ShopErrorAddressState extends ShopStates {
  final String error;

  ShopErrorAddressState(this.error);
}
class ShopLoadingAddressState extends ShopStates
{

}
class ShopSuccessAddressState extends ShopStates {
}
/////////////////////////////////////////////////////////////////////////////////
class ShopErrorGetAddressState extends ShopStates {
  final String error;

  ShopErrorGetAddressState(this.error);
}
class ShopLoadingGetAddressState extends ShopStates
{

}
class ShopSuccessGetAddressState extends ShopStates {
}
///////////////////////////////////////////////////////////////////////////////
class ShopErrorUpdateAddressState extends ShopStates {
  final String error;

  ShopErrorUpdateAddressState(this.error);
}
class ShopLoadingUpdateAddressState extends ShopStates
{

}
class ShopSuccessUpdateAddressState extends ShopStates {
}
////////////////////////////////////////////////////////////////////////////////
class ShopErrorDeleteAddressState extends ShopStates {
  final String error;

  ShopErrorDeleteAddressState(this.error);
}
class ShopLoadingDeleteAddressState extends ShopStates
{

}
class ShopSuccessDeleteAddressState extends ShopStates {
}
////////////////////////////////////////////////////////////////////////////////
class CategoryDetailsErrorState extends ShopStates {
  final String error;

  CategoryDetailsErrorState(this.error);
}
class CategoryDetailsLoadingState extends ShopStates
{

}
class CategoryDetailsSuccessState extends ShopStates {
}
//////////////////////////////////////////////////////////////////////////////
class pproductDetailsErrorState extends ShopStates {
  final String error;

  pproductDetailsErrorState(this.error);
}
class productDetailsLoadingState extends ShopStates
{

}
class productDetailsSuccessState extends ShopStates {
}
////////////////////////////////////////////////////////////////////////////////////
class AddCartErrorState extends ShopStates {
  final String error;

  AddCartErrorState(this.error);
}
class AddCartLoadingState extends ShopStates
{

}
class AddCartSuccessState extends ShopStates {
}
////////////////////////////////////////////////////////////////////////////////
class UpdateCartErrorState extends ShopStates {
  final String error;

  UpdateCartErrorState(this.error);
}
class UpdateCartLoadingState extends ShopStates
{

}
class UpdateCartSuccessState extends ShopStates {
}
///////////////////////////////////////////////////////////////////////////////
class GetCartErrorState extends ShopStates {
  final String error;

  GetCartErrorState(this.error);
}
class GetCartLoadingState extends ShopStates
{

}
class GetCartSuccessState extends ShopStates {
}