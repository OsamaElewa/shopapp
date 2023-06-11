

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/category_details/category_details_model.dart';
import '../../../models/change_favorites_model/change_favorites_model.dart';
import '../../../models/favorites_model/favorites_model.dart';
import '../../../shared/constants/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryStates>{
  CategoryCubit() : super(CategoryInitialState());

  static CategoryCubit get(context)=> BlocProvider.of(context);

  CategoryDetailsModel? categoryDetailModel;
  void getCategoryDetails({required int id}) {
    emit(CategoryLoadingState());
    DioHelper.getData(url:'categories/$id',token: token).then((value)
    {
      categoryDetailModel=CategoryDetailsModel.fromJson(value.data);
      print( categoryDetailModel!.status!);
      categoryDetailModel!.data!.data!.forEach((element) {print(element.name);});
      emit(CategorySuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CategoryErrorState());
    });
  }

  // Map<int,bool> favorites={};
  // ChangeFavoritesModel? changeFavoritesModel;
  // void changeFavorites(int productId){
  //   favorites[productId]= !favorites[productId]!;
  //   emit(CategorySuccessChangeState());
  //   DioHelper.postData(
  //     url: FAVORITES,
  //     data: {
  //       'product_id' : productId,
  //     },
  //     token: token,
  //   ).then((value){
  //     changeFavoritesModel=ChangeFavoritesModel.fromjson(value.data);
  //     print(value.data);
  //     if(changeFavoritesModel?.status==false){
  //       favorites[productId]= !favorites[productId]!;
  //     }
  //     else{
  //       getFavorites();
  //     }
  //     emit(CategorySuccessChangeFavoritesState(changeFavoritesModel!));
  //   }).catchError((error){
  //     print(error.toString());
  //     favorites[productId]= !favorites[productId]!;
  //     emit(CategoryErrorFavoritesState());
  //   });
  // }

  // FavoritesModel? favoritesModel;
  // void getFavorites() {
  //   emit(CategoryLoadingGetFavoritesState());
  //   DioHelper.getData(url: FAVORITES,token: token).then((value)
  //   {
  //     favoritesModel=FavoritesModel.fromJson(value.data);
  //     print(value.data.toString());
  //     emit(CategorySuccessGetFavoritesState());
  //   }).catchError((error){
  //     print(error.toString());
  //     emit(CategoryErrorGetFavoritesState());
  //   });
  // }
}