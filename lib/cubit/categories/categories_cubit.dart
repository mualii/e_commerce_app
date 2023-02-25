import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/categories_model.dart';
import '../../network/dio_manager.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());
  static CategoriesCubit get(context) => BlocProvider.of(context);
  DioManager dioManager = DioManager();

  CategoriesModel categoriesModel = CategoriesModel();

  Future<void> getCategoriesImpl() async {
    emit(GetCategoriesLoadingState());

    Either<String, CategoriesModel> respond =
        await dioManager.getCategoriesAsync();
    respond.fold((left) {
      emit(GetCategoriesErrorState());
      debugPrint("Get Categories Impl Failed");
    }, (right) {
      categoriesModel = right;
      emit(GetCategoriesSuccessState());
      debugPrint(categoriesModel.results![0].name.toString());
    });
  }
}
