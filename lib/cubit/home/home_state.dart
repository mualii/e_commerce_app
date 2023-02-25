part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class CategoriesLoadingState extends HomeState {}

class CategoriesSuccessState extends HomeState {}

class CategoriesErrorState extends HomeState {}

class ProductLoadingState extends HomeState {}

class ProductSuccessState extends HomeState {}

class ProductErrorState extends HomeState {}

class ProductByIdLoadingState extends HomeState {}

class ProductByIdSuccessState extends HomeState {}

class ProductByIdErrorState extends HomeState {}

class AddOneQuantityState extends HomeState {}

class RemoveOneQuantityState extends HomeState {}

class RemoveFavState extends HomeState {}

class FavState extends HomeState {}
