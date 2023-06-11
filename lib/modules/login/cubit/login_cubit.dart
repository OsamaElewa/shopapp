
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/login_model/login_model.dart';
import 'package:shopapp/modules/login/cubit/login_state.dart';
import 'package:shopapp/shared/network/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginState>{
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context)=>BlocProvider.of(context);

  IconData suffix=Icons.visibility_outlined;
  bool isPasswordShown=false;

  void changeVisibility(){
    suffix= isPasswordShown? Icons.visibility_outlined: Icons.visibility_off;
    isPasswordShown= !isPasswordShown;
    emit(ShopLoginVisibilityState());
  }

  late ShopLoginModel shopLoginModel;

  void userLogin({
  required String email,
  required String password,
}){
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data:{
      'email' : email,
      'password' : password,
    },).then((value){
      print(value.data);
       shopLoginModel= ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(shopLoginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }
}