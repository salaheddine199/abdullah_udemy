import 'package:abdullah_mansour/layout/shop_app/cubit/states.dart';
import 'package:abdullah_mansour/models/shop_app/categories_model.dart';
import 'package:abdullah_mansour/models/shop_app/change_fav_model.dart';
import 'package:abdullah_mansour/models/shop_app/get_fav_model.dart';
import 'package:abdullah_mansour/models/shop_app/home_model.dart';
import 'package:abdullah_mansour/models/shop_app/shop_login_model.dart';
import 'package:abdullah_mansour/modules/shop_app/app_screens/categories_screen.dart';
import 'package:abdullah_mansour/modules/shop_app/app_screens/favorites_screen.dart';
import 'package:abdullah_mansour/modules/shop_app/app_screens/products_screen.dart';
import 'package:abdullah_mansour/modules/shop_app/app_screens/settings_screen.dart';
import 'package:abdullah_mansour/shared/components/components.dart';
import 'package:abdullah_mansour/shared/components/constants.dart';
import 'package:abdullah_mansour/shared/network/end_points.dart';
import 'package:abdullah_mansour/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bodyScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    if (index != currentIndex) {
      currentIndex = index;
      emit(ShopChangeBottomNavBarState());
    }
  }

  // our body screens logic:

  HomeModel homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {

    if( token.isNotEmpty ){
      emit(ShopLoadingHomeDataState());

      DioHelper.getData(
        url: HOME,
        token: token,
      ).then((value) {
        homeModel = HomeModel.fromJson(value.data);
        //printFullText(homeModel.data.banners[1].image.toString());
        //print(homeModel.status);
        homeModel.data.products.forEach((ProductModel element) {
          favorites.addAll({
            element.id: element.inFavorites,
          });
        });

        //print(favorites.toString());

        emit(ShopSuccessHomeDataState());
      }).catchError((error) {
        print('error while getting home data : ${error.toString()}');
        emit(ShopErrorHomeDataState());
      });
    }
    else{
      print('No Login yet, the get home data method won\'t execute');
    }

  }

  CategoryModel categoryModel;

  void getCategories(){
    // no loading cuz it's in the same page with products so we used ProductLoadingState

    if( token.isNotEmpty ){
      DioHelper.getData(
        url: GET_CATEGORIES,
        token: token,
      ).then((value) {
        categoryModel = CategoryModel.fromJson(value.data);
        //print('category data : ${value.data}');

        emit(ShopSuccessCategoriesState());
      }).catchError((error) {
        print('error while getting categories data : ${error.toString()}');
        emit(ShopErrorCategoriesState());
      });
    }
    else{
      print('No Login yet, the get categories method won\'t execute');
    }

  }

  ChangeFavoriteModel changeFavoriteModel;

  void changeFavorites(int productId){

    favorites[productId] = !favorites[productId];
    emit(ShopBoolFavState());
    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id': productId,
        },
      token: token,
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      // print('changingFav method: ${value.data}');
      // print(changeFavoriteModel.message);
      // print(token);


      if(!changeFavoriteModel.status){
        //showToast(text: changeFavoriteModel.message, color: Colors.red);
        // we'll show this toast in the productScreen with listen method just to practice
        favorites[productId] = !favorites[productId];
      }else{
        getFavorites();
      }


      emit(ShopSuccessChangeFavState(changeFavoriteModel));
    }).catchError((error){
      showToast(text: changeFavoriteModel.message, color: Colors.red);
      favorites[productId] = !favorites[productId];
      emit(ShopErrorChangeFavState());
    });
  }

  // get favorites:
  GetFavoriteModel favModel;

  void getFavorites(){

    if( token.isNotEmpty ){
      emit(ShopLoadingGetFavState());

      DioHelper.getData(
        url: FAVORITES,
        token: token,
      ).then((value) {
        favModel = GetFavoriteModel.fromJson(value.data);
        //printFullText('favorites data : ${value.data}');

        emit(ShopSuccessGetFavState());
      }).catchError((error) {
        print('error while getting favorites data : ${error.toString()}');
        emit(ShopErrorGetFavState());
      });
    }
    else{
      print('No Login yet, the get favorites method won\'t execute');
    }

  }

  // profile:
  ShopLoginModel userModel;

  void getProfile(){
    if( token.isNotEmpty ){
      emit(ShopLoadingProfileState());

      DioHelper.getData(
        url: PROFILE,
        token: token,
      ).then((value) {
        userModel = ShopLoginModel.fromJson(json: value.data);
        print(userModel.data.name);
        print(userModel.data.email);

        emit(ShopSuccessProfileState(userModel));
      }).catchError((error) {
        print('error while getting profile data : ${error.toString()}');
        emit(ShopErrorProfileState());
      });
    }
    else{
      print('No Login yet, the get profile method won\'t execute');
    }
  }

  // Update profile:
  void updateProfile({
  @required String name,
  @required String email,
  @required String phone,
}){
      emit(ShopLoadingUpdateProfileState());

      DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
        },
      ).then((value) {
        userModel = ShopLoginModel.fromJson(json: value.data);
        // print(userModel.data.name);
        // print(userModel.data.email);

        emit(ShopSuccessUpdateProfileState(userModel));
      }).catchError((error) {
        print('error while updating profile data : ${error.toString()}');
        emit(ShopErrorUpdateProfileState());
      });
  }

}
