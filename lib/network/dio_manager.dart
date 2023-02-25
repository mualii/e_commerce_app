import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app_muhammed_ali/models/categories_model.dart';
import 'package:e_commerce_app_muhammed_ali/network/endpoints.dart';

import '../models/login_model.dart';
import '../models/products_model.dart';
import 'dio_client.dart';

class DioManager {
  DioClient dioClient = DioClient(Dio());
  Future<Either<String, LoginModel>> sendLoginAsync({
    required String username,
    required String password,
  }) async {
    try {
      Response response = await dioClient.post(
        Endpoints.LOGIN,
        data: {"username": username, "password": password},
      );

      return Right(LoginModel.fromJson(response.data));
    } on DioError catch (e) {
      return const Left("can not login");
    }
  }

  Future<Either<String, String>> sendRegisterAsync({
    required String username,
    required String password,
    required String email,
    required String first_name,
    required String last_name,
  }) async {
    try {
      await dioClient.post(
        Endpoints.REGISTER,
        data: {
          "username": username,
          "password": password,
          "email": email,
          "first_name": first_name,
          "last_name": last_name,
        },
      );
      return const Right(
          "User Created Successfully.  Now perform Login to Start App");
    } on DioError catch (e) {
      return const Left("can not register");
    }
  }

  Future<Either<String, CategoriesModel>> getCategoriesAsync() async {
    try {
      Response response = await dioClient.get(
        Endpoints.CATEGORIES,
      );
      return Right(CategoriesModel.fromJson(response.data));
    } on DioError catch (e) {
      return const Left("error");
    }
  }

  Future<Either<String, ProductsModel>> getProductsAsync() async {
    try {
      Response response = await dioClient.get(
        Endpoints.PRODUCTS,
      );
      return Right(ProductsModel.fromJson(response.data));
    } on DioError catch (e) {
      return const Left("error");
    }
  }

  Future<Either<String, ProductsModel>> getProductsByCatAsync(
      {required String catId}) async {
    try {
      Response response = await dioClient.get(
        Endpoints.PRODUCTSBY_BY_CATEGORIES_ID + catId,
      );
      return Right(ProductsModel.fromJson(response.data));
    } on DioError catch (e) {
      return const Left("error");
    }
  }
}
