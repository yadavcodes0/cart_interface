import 'package:flutter_bloc/flutter_bloc.dart';

import '../../products/data/product_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoaded([])) {
    on<AddToCart>((event, emit) {
      if (state is CartLoaded) {
        final cartItems = (state as CartLoaded).cart;
        final existingProductIndex =
            cartItems.indexWhere((p) => p.id == event.product.id);

        List<Product> updatedCart;
        if (existingProductIndex != -1) {
          // Product already exists, increase its quantity
          updatedCart = List<Product>.from(cartItems);
          updatedCart[existingProductIndex] = updatedCart[existingProductIndex]
              .copyWith(
                  quantity: updatedCart[existingProductIndex].quantity + 1);
        } else {
          // New product, set quantity to 1
          updatedCart = List<Product>.from(cartItems)
            ..add(event.product.copyWith(quantity: 1));
        }

        emit(CartLoaded(updatedCart));
      }
    });

    on<RemoveFromCart>((event, emit) {
      if (state is CartLoaded) {
        final updatedCart = (state as CartLoaded)
            .cart
            .where((product) => product.id != event.productId)
            .toList();
        emit(CartLoaded(updatedCart));
      }
    });

    on<UpdateQuantity>((event, emit) {
      if (state is CartLoaded) {
        final updatedCart = (state as CartLoaded).cart.map((product) {
          if (product.id == event.productId) {
            int newQuantity = product.quantity + event.change;
            if (newQuantity > 0) {
              return product.copyWith(quantity: newQuantity);
            }
          }
          return product;
        }).toList();
        emit(CartLoaded(updatedCart));
      }
    });
  }
}
