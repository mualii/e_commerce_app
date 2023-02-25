import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../models/products_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  static CartCubit get(context) => BlocProvider.of(context);

  int countOfItemInCart = 0;
  int quantity = 1;
  double total = 0;
  void addToCart({required ProductResults model}) {
    Hive.box("cart").add(model);
    countOfItemInCart++;
    emit(AddToCartState());
  }

  void addOneQuantity({required ProductResults model}) {
    quantity++;

    model.quantity = quantity;
    emit(AddOneQuantityState());
  }

  void removeOneQuantity({required ProductResults model}) {
    if (quantity > 1) quantity--;
    // amunt = quantity * price;
    model.quantity = quantity;
    emit(RemoveOneQuantityState());
  }

  void delete({required int index}) {
    Hive.box("cart").deleteAt(index);
    countOfItemInCart = Hive.box("cart").length;
    emit(DeleteItemState());
  }

  void getTotal() {
    for (int i = 0; i < Hive.box("cart").length; i++) {
      ProductResults results = Hive.box("cart").getAt(i);
      total = total + (results.quantity! * double.parse(results.price!));
    }
  }
}
