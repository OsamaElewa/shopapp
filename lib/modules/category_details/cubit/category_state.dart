import '../../../models/change_favorites_model/change_favorites_model.dart';

abstract class CategoryStates{}

class CategoryInitialState extends CategoryStates{}

class CategoryLoadingState extends CategoryStates{}
class CategorySuccessState extends CategoryStates{}
class CategoryErrorState extends CategoryStates{}


// class CategorySuccessChangeFavoritesState extends CategoryStates{
//   final ChangeFavoritesModel model;
//   CategorySuccessChangeFavoritesState(this.model);
// }
// class CategorySuccessChangeState extends CategoryStates{}
// class CategoryErrorFavoritesState extends CategoryStates{}
//
//
// class CategoryLoadingGetFavoritesState extends CategoryStates{}
// class CategorySuccessGetFavoritesState extends CategoryStates{}
// class CategoryErrorGetFavoritesState extends CategoryStates{}
