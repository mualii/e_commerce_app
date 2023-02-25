part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class AddToCartState extends CartState {}

class StartTotalState extends CartState {}

class EndTotalCartState extends CartState {}

class AddOneQuantityState extends CartState {}

class RemoveOneQuantityState extends CartState {}

class DeleteItemState extends CartState {}
