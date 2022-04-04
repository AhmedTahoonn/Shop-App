import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cuibt/search%20cubit/searchstates.dart';
import 'package:shop_app/models/search%20model.dart';
import 'package:shop_app/network/endpoint.dart';
import 'package:shop_app/network/remote/dio.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context)=>BlocProvider.of(context);
  SearchModel ?model;
  void search(String text)
  {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH,token: token, data: {
      'text':'$text',
    }).then((value) {
      model=SearchModel.fromJson(value.data);
      print(value.data.toString());
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}