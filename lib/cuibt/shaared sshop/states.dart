
import '../../models/changefavorites model.dart';
import '../../models/loginmodel.dart';

abstract class ShopStates
{

}

class Shopintial extends ShopStates{}
///////////////////////////////////////////////////////////////////////////////
class ShopChangeBottomNavigationbarState extends ShopStates{}
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
//updateeeeee user
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