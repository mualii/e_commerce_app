import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_muhammed_ali/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import '../../models/products_model.dart';
import '../../network/dio_manager.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  DioManager dioManager = DioManager();

  CategoriesModel categoriesModel = CategoriesModel();
  ProductsModel productsModel = ProductsModel();

  Future<void> getCategoriesImpl() async {
    emit(CategoriesLoadingState());

    Either<String, CategoriesModel> respond =
        await dioManager.getCategoriesAsync();
    respond.fold((left) {
      emit(CategoriesErrorState());
      debugPrint("Get Categories Impl Failed");
    }, (right) {
      categoriesModel = right;
      getProductsImpl();
      debugPrint(categoriesModel.results![0].name.toString());
    });
  }

  Future<void> getProductsImpl() async {
    emit(ProductLoadingState());
    Either<String, ProductsModel> respond = await dioManager.getProductsAsync();
    respond.fold((left) {
      emit(ProductErrorState());
      debugPrint("Get Categories Impl Failed");
    }, (right) {
      productsModel = right;

      emit(ProductSuccessState());
      debugPrint(productsModel.results![0].name.toString());
    });
  }

  void putAndRemoveInFavBoxForAllProd(
      {required int index, required bool isFav, required int id}) async {
    if (isFav) {
      for (var item in productsModel.results!) {
        if (item.id == id) {
          item.isFav = false;
        }
      }
      Hive.box("fav").delete(productsModel.results![index].id);
      debugPrint(Hive.box("fav").length.toString());
      emit(RemoveFavState());
    } else {
      productsModel.results![index].isFav = true;
      ProductResults productResults = productsModel.results![index];
      Hive.box("fav").put(productsModel.results![index].id, productResults);
      emit(FavState());
    }
    debugPrint(productsModel.results![index].isFav.toString());
  }

  int quantity = 1;
  double amunt = 0;
  void addOneQuantity({required double price, required int index}) {
    quantity++;
    amunt = quantity * price;
    productsModel.results![index].quantity = quantity;
    emit(AddOneQuantityState());
  }

  void removeOneQuantity({required double price, required int index}) {
    if (quantity > 1) quantity--;
    amunt = quantity * price;
    productsModel.results![index].quantity = quantity;
    emit(RemoveOneQuantityState());
  }
}
