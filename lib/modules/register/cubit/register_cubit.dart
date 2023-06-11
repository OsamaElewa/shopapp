
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/login_model/login_model.dart';
import 'package:shopapp/modules/login/cubit/login_state.dart';
import 'package:shopapp/modules/register/cubit/register_state.dart';
import 'package:shopapp/shared/network/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState>{
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context)=>BlocProvider.of(context);

  IconData suffix=Icons.visibility_outlined;
  bool isPasswordShown=false;

  void changeVisibility(){
    suffix= isPasswordShown? Icons.visibility_outlined: Icons.visibility_off;
    isPasswordShown= !isPasswordShown;
    emit(ShopRegisterVisibilityState());
  }

  late ShopLoginModel shopLoginModel;

  void userRegister({
  required String name,
  required String email,
  required String phone,
  required String password,
}){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data:{
      'name' : name,
      'email' : email,
      'phone' : phone,
      'password' : password,
    },).then((value){
      print(value.data);
       shopLoginModel= ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(shopLoginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
}