import 'package:shopapp/models/login_model/login_model.dart';

abstract class ShopLoginState{}

class ShopLoginInitialState extends ShopLoginState{}

class ShopLoginLoadingState extends ShopLoginState{}

class ShopLoginSuccessState extends ShopLoginState{
  final ShopLoginModel shopLoginModel;
  ShopLoginSuccessState(this.shopLoginModel);
}

class ShopLoginErrorState extends ShopLoginState
{
  final String error;

  ShopLoginErrorState(this.error);
}

class ShopLoginVisibilityState extends ShopLoginState{}