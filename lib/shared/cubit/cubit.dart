import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/constants/constants.dart';
import 'package:shopapp/shared/cubit/states.dart';
import 'package:shopapp/shared/network/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

import '../../models/cart_model/cart_model.dart';
import '../../models/categories_model/categories_model.dart';
import '../../models/category_details/category_details_model.dart';
import '../../models/change_favorites_model/change_favorites_model.dart';
import '../../models/favorites_model/favorites_model.dart';
import '../../models/home_model/home_model.dart';
import '../../models/login_model/login_model.dart';
import '../../modules/categories/categories_screen.dart';
import '../../modules/favorites/favorite_screen.dart';
import '../../modules/products/products_screen.dart';
import '../../modules/settings/settings_screen.dart';


class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreen = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoriteScreen(),
     SettingsScreen(),
  ];



  void changeIndex(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int,bool> favorites={};
  Map<int,bool> carts={};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME,token: token).then((value)
    {
       homeModel=HomeModel.fromJson(value.data);
      // homeModel?.data?.products?.forEach((element) {print(element.name);});
      // print(homeModel?.status);

       //هنا بنملو لستة المفضلة بالقيم true and false علي حسب ال id
       homeModel?.data?.products.forEach((element) {
        favorites.addAll({
          element.id! : element.inFavorites!,
        });
       });

       // 1. هنا بنملو لستة التسوق بالقيم true and false علي حسب ال id
       //2. create post method to add or delete from the cart
       homeModel?.data?.products.forEach((element) {
         carts.addAll({
           element.id! : element.inCart!,
         });
       });
       //print(favorites.toString());
       print(carts.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoryDetailsModel? categoryDetailModel;
  void getCategoryDetails({required int id}) {
    emit(ShopLoadingGetCategoryDetailsState());
    DioHelper.getData(url:'categories/$id',token: token).then((value)
    {

      categoryDetailModel=CategoryDetailsModel.fromJson(value.data);
      print( categoryDetailModel!.status!);
      categoryDetailModel!.data!.data!.forEach((element) {print(element.name);});
      emit(ShopSuccessGetCategoryDetailsState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetCategoryDetailsState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories() {
    DioHelper.getData(url: Get_Categories,token: token).then((value)
    {
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(url: FAVORITES,token: token).then((value)
    {
      favoritesModel=FavoritesModel.fromJson(value.data);
      print(value.data.toString());
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId){
    favorites[productId]= !favorites[productId]!;
    emit(ShopSuccessChangeState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id' : productId,
      },
      token: token,
    ).then((value){
      changeFavoritesModel=ChangeFavoritesModel.fromjson(value.data);
      print(value.data);
      if(changeFavoritesModel?.status==false){
        favorites[productId]= !favorites[productId]!;
      }
      else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error){
      print(error.toString());
      favorites[productId]= !favorites[productId]!;
      emit(ShopErrorFavoritesState());
    });
  }


  ChangeFavoritesModel? changeAddDeleteToCart;
  void addDeleteCarts(int productId){
    carts[productId]=!carts[productId]!;
    emit(ShopSuccessChangeAddDeleteToCartState());
    DioHelper.postData(url: CARTS, data: {
      'product_id' : productId,
    },
      token: token,
    ).then((value) {
      changeAddDeleteToCart=ChangeFavoritesModel.fromjson(value.data);
      print(value.data);
      if(changeAddDeleteToCart!.status==false){
        carts[productId]=!carts[productId]!;
      }
      else{
        getCarts();
      }
      emit(ShopSuccessAddDeleteToCartState(changeAddDeleteToCart!));
    }).catchError((error){
      carts[productId]=!carts[productId]!;
      print(error.toString());
      emit(ShopErrorAddDeleteToCartState());
    });
  }

  CartModel? cartModel;
  void getCarts() {
    emit(ShopLoadingGetCartsState());
    DioHelper.getData(url: CARTS,token: token).then((value)
    {
      cartModel=CartModel.fromJson(value.data);
      print(cartModel!.data!.cartItems![0].product!.name!);
      print(cartModel!.data!.subTotal!);

      emit(ShopSuccessGetCartsState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetCartsState());
    });
  }


  ShopLoginModel? profileModel;
  void getProfile() {
    emit(ShopLoadingGetProfileState());
    DioHelper.getData(url: PROFILE,token: token).then((value)
    {
      profileModel=ShopLoginModel.fromJson(value.data);
      print(profileModel!.data!.name!);
      emit(ShopSuccessGetProfileState(profileModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetProfileState());
    });
  }
  
  void updateProfile({
  required String name,
  required String email,
  required String phone,
}) {
    emit(ShopLoadingUpdateProfileState());
    DioHelper.putData(url: UPDATE_PROFILE,token: token, data: {
      'name' : name,
      'email' : email,
      'phone' : phone,
    }).then((value)
    {
      profileModel=ShopLoginModel.fromJson(value.data);
      print(profileModel!.data!.name!);
      emit(ShopSuccessUpdateProfileState(profileModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateProfileState());
    });
  }
  int incQuant=1;
  void increaseQuantity(){
    incQuant++;
    emit(IncreaseQuantityState());
  }

  void decreseQuantity(){
    if(incQuant>1) {
      incQuant--;
    }
    emit(IncreaseQuantityState());
  }
  
  void updateCart({
    required int cartProdId,
  required int quantity,
})
  {
    emit(ShopLoadingUpdateCartState());
    DioHelper.putData(url: 'carts/$cartProdId',token: token ,data: {
      'quantity': quantity,
    }).then((value){
      cartModel=CartModel.fromJson(value.data);
      getCarts();
      emit(ShopSuccessUpdateCartState());
    }).catchError((error){
      print(error.toString());
      getCarts();
      emit(ShopErrorUpdateCartState());
    });
  }

  // void increseQuantity(){
  //   cartModel.data.cart
  // }

}
