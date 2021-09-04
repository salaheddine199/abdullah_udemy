
import 'package:abdullah_mansour/models/shop_app/search_model.dart';
import 'package:abdullah_mansour/modules/shop_app/search/cubit/search_states.dart';
import 'package:abdullah_mansour/shared/components/constants.dart';
import 'package:abdullah_mansour/shared/network/end_points.dart';
import 'package:abdullah_mansour/shared/network/local/cache_helper.dart';
import 'package:abdullah_mansour/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit(): super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel model;

  void search(String text){

    emit(SearchLoadingState());

    DioHelper.postData(
        url: SEARCH,
        data: {
          'text': text,
        },
      token: token,
    ).then((value) {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error){
      print('error while searching ${error.toString()}');
      emit(SearchErrorState());
    });
  }

}