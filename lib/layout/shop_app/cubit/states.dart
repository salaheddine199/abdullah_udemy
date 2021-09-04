import 'package:abdullah_mansour/models/shop_app/change_fav_model.dart';
import 'package:abdullah_mansour/models/shop_app/shop_login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavBarState extends ShopStates{}
// home data:
class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}

// categories:
class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{}

// change favorites:
class ShopSuccessChangeFavState extends ShopStates{
  final ChangeFavoriteModel model;
  ShopSuccessChangeFavState(this.model);
}
class ShopErrorChangeFavState extends ShopStates{}

class ShopBoolFavState extends ShopStates{}

// get favorites:
class ShopLoadingGetFavState extends ShopStates{}
class ShopSuccessGetFavState extends ShopStates{}
class ShopErrorGetFavState extends ShopStates{}

// profile:
class ShopLoadingProfileState extends ShopStates{}
class ShopSuccessProfileState extends ShopStates{
  final ShopLoginModel model;

  ShopSuccessProfileState(this.model);
}
class ShopErrorProfileState extends ShopStates{}

// update profile:
class ShopLoadingUpdateProfileState extends ShopStates{}
class ShopSuccessUpdateProfileState extends ShopStates{
  final ShopLoginModel model;

  ShopSuccessUpdateProfileState(this.model);
}
class ShopErrorUpdateProfileState extends ShopStates{}