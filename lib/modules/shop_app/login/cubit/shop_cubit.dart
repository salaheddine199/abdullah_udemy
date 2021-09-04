import 'package:abdullah_mansour/models/shop_app/shop_login_model.dart';
import 'package:abdullah_mansour/modules/shop_app/login/cubit/shop_states.dart';
import 'package:abdullah_mansour/shared/network/end_points.dart';
import 'package:abdullah_mansour/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get (context) => BlocProvider.of(context);

  // password :
  bool isPasswordVisible = true;
  void changePasswordVisibility(){
    isPasswordVisible = !isPasswordVisible;
    emit(ShopLoginChangePasswordVisibilityState());
  }

  // login:
  ShopLoginModel loginModel;

  void userLogin({
    @required String email,
    @required String password,
}){

    emit(ShopLoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data: {
      'email':email,
      'password':password,
    },
    ).then((value) {

      loginModel = ShopLoginModel.fromJson(json: value.data);
      // print(loginModel.data.email);
      // print(loginModel.message);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

}
