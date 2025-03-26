import 'package:cart_interface/features/products/data/product_model.dart';

abstract class CartState {}

class CartLoaded extends CartState {
  final List<Product> cart;
  CartLoaded(this.cart);
}
