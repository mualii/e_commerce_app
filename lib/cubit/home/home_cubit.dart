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
  // ProductsModel productsModel = ProductsModel();
  ProductsModel productsMostPopularModel = ProductsModel();
  ProductsModel productsMostRecentModel = ProductsModel();
  Future<void> getCategoriesImpl() async {
    emit(CategoriesLoadingState());

    Either<String, CategoriesModel> respond =
        await dioManager.getCategoriesAsync();
    respond.fold((left) {
      emit(CategoriesErrorState());
    }, (right) {
      categoriesModel = right;
      // getProductsImpl();
      getMostPopulerProductsImpl();
      getMostRecentProductsImpl();
    });
  }

  // Future<void> getProductsImpl() async {
  //   emit(ProductLoadingState());
  //   Either<String, ProductsModel> respond = await dioManager.getProductsAsync();
  //   respond.fold((left) {
  //     emit(ProductErrorState());
  //   }, (right) {
  //     productsModel = right;
  //     emit(ProductSuccessState());
  //   });
  // }

  Future<void> getMostPopulerProductsImpl() async {
    emit(PMPLoadingState());
    Either<String, ProductsModel> respond =
        await dioManager.getProductsByCatAsync(catId: "1");
    respond.fold((left) {
      emit(PMPErrorState());
    }, (right) {
      productsMostPopularModel = right;

      emit(PMPSuccessState());
    });
  }

  Future<void> getMostRecentProductsImpl() async {
    emit(PMRLoadingState());
    Either<String, ProductsModel> respond =
        await dioManager.getProductsByCatAsync(catId: "5");
    respond.fold((left) {
      emit(PMRErrorState());
    }, (right) {
      productsMostRecentModel = right;

      emit(PMRSuccessState());
    });
  }

  void putAndRemoveInFavBoxForProducts(
      {required int index, required bool isFav, required int id}) async {
    if (isFav) {
      // for (var item in productsModel.results!) {
      //   if (item.id == id) {
      //     item.isFav = false;
      //     Hive.box("fav").delete(item.id);
      //   }
      // }
      for (var item in productsMostRecentModel.results!) {
        if (item.id == id) {
          item.isFav = false;
          Hive.box("fav").delete(item.id);
        }
      }
      for (var item in productsMostPopularModel.results!) {
        if (item.id == id) {
          item.isFav = false;
          Hive.box("fav").delete(item.id);
        }
      }

      emit(RemoveFavState());
    } else {
      // for (var item in productsModel.results!) {
      //   if (item.id == id) {
      //     item.isFav = true;
      //     Hive.box("fav").put(item.id, item);
      //   }
      // }
      for (var item in productsMostPopularModel.results!) {
        if (item.id == id) {
          item.isFav = true;
          Hive.box("fav").put(item.id, item);
        }
      }
      for (var item in productsMostRecentModel.results!) {
        if (item.id == id) {
          item.isFav = true;
          Hive.box("fav").put(item.id, item);
        }
      }
      emit(FavState());
    }
  }

  int quantity = 1;
  double amunt = 0;
  void addOneQuantity({
    required double price,
    required int id,
  }) {
    quantity++;
    amunt = quantity * price;
    for (var item in productsMostRecentModel.results!) {
      if (item.id == id) {
        item.quantity = quantity;
      }
    }
    for (var item in productsMostPopularModel.results!) {
      if (item.id == id) {
        item.quantity = quantity;
      }
    }
    emit(AddOneQuantityState());
  }

  void removeOneQuantity({
    required double price,
    required int id,
  }) {
    if (quantity > 1) quantity--;
    amunt = quantity * price;
    for (var item in productsMostRecentModel.results!) {
      if (item.id == id) {
        item.quantity = quantity;
      }
    }
    for (var item in productsMostPopularModel.results!) {
      if (item.id == id) {
        item.quantity = quantity;
      }
    }
    emit(RemoveOneQuantityState());
  }

  void addToCart({required int id}) {
    for (var item in productsMostRecentModel.results!) {
      if (item.id == id) {
        item.inCart = true;
      }
    }
    for (var item in productsMostPopularModel.results!) {
      if (item.id == id) {
        item.inCart = true;
      }
    }
    emit(AddToCartState());
  }

  void removeFromCart({required int id}) {
    for (var item in productsMostRecentModel.results!) {
      if (item.id == id) {
        item.inCart = false;
      }
    }
    for (var item in productsMostPopularModel.results!) {
      if (item.id == id) {
        item.inCart = false;
      }
    }
    emit(RemoveFromCartState());
  }
}
