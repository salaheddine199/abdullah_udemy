import 'package:abdullah_mansour/models/shop_app/shop_login_model.dart';
import 'package:abdullah_mansour/modules/shop_app/register/cubit/register_states.dart';
import 'package:abdullah_mansour/shared/network/end_points.dart';
import 'package:abdullah_mansour/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get (context) => BlocProvider.of(context);

  // password :
  bool isPasswordVisible = true;
  void changePasswordVisibility(){
    isPasswordVisible = !isPasswordVisible;
    emit(ShopRegisterChangePasswordVisibilityState());
  }

  // Register:
  ShopLoginModel registerModel;

  void userRegister({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
  }){

    emit(ShopRegisterLoadingState());

    DioHelper.postData(
      url: REGISTER,
      data: {
        'email':email,
        'password':password,
        'name':name,
        'phone':phone,
      },
    ).then((value) {

      registerModel = ShopLoginModel.fromJson(json: value.data);
      emit(ShopRegisterSuccessState(registerModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

}
