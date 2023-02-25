class Endpoints {
  Endpoints._();

  static const String baseUrl = "https://flutterapi.kortobaa.net/";
  static const int receiveTimeout = 15000;
  static const int connectionTimeout = 15000;
  static const String LOGIN = "users/login/";
  static const String REGISTER = "users/register/";
  static const String PRODUCTS = "api/v1/products/";
  static const String CATEGORIES = "api/v1/categories";
  static const String PRODUCTSBY_BY_CATEGORIES_ID = "api/v1/products/category/";
}
