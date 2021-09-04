import 'package:abdullah_mansour/models/shop_app/shop_login_model.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialState extends ShopLoginStates{}
// it's not that complex ig I will set it stful and remove this:
class ShopLoginChangePasswordVisibilityState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}
class ShopLoginSuccessState extends ShopLoginStates{
  final ShopLoginModel shopModel;

  ShopLoginSuccessState(this.shopModel);
}
class ShopLoginErrorState extends ShopLoginStates{
  final String error;
  ShopLoginErrorState(this.error);
}

