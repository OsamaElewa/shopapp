import 'package:shopapp/models/change_favorites_model/change_favorites_model.dart';
import 'package:shopapp/models/login_model/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{}

class ShopSuccessChangeFavoritesState extends ShopStates{
  final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}
class ShopSuccessChangeState extends ShopStates{}
class ShopErrorFavoritesState extends ShopStates{}


class ShopLoadingGetFavoritesState extends ShopStates{}
class ShopSuccessGetFavoritesState extends ShopStates{}
class ShopErrorGetFavoritesState extends ShopStates{}


class ShopSuccessAddDeleteToCartState extends ShopStates{
  final ChangeFavoritesModel model;
  ShopSuccessAddDeleteToCartState(this.model);
}
class ShopSuccessChangeAddDeleteToCartState extends ShopStates{}
class ShopErrorAddDeleteToCartState extends ShopStates{}


class ShopLoadingGetCartsState extends ShopStates{}
class ShopSuccessGetCartsState extends ShopStates{}
class ShopErrorGetCartsState extends ShopStates{}



class ShopLoadingGetProfileState extends ShopStates{}
class ShopSuccessGetProfileState extends ShopStates{
  final ShopLoginModel profileModel;
  ShopSuccessGetProfileState(this.profileModel);

}
class ShopErrorGetProfileState extends ShopStates{}



class ShopLoadingUpdateProfileState extends ShopStates{}
class ShopSuccessUpdateProfileState extends ShopStates{
  final ShopLoginModel profileModel;
  ShopSuccessUpdateProfileState(this.profileModel);

}
class ShopErrorUpdateProfileState extends ShopStates{}



class ShopLoadingGetCategoryDetailsState extends ShopStates{}
class ShopSuccessGetCategoryDetailsState extends ShopStates{}
class ShopErrorGetCategoryDetailsState extends ShopStates{}



class ShopLoadingUpdateCartState extends ShopStates{}
class ShopSuccessUpdateCartState extends ShopStates{}
class ShopErrorUpdateCartState extends ShopStates{}


class CategoryLoadingState extends ShopStates{}
class CategorySuccessState extends ShopStates{}
class CategoryErrorState extends ShopStates{}


class IncreaseQuantityState extends ShopStates{}
class DecreaseQuantityState extends ShopStates{}

