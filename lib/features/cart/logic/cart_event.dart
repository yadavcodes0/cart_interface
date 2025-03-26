import 'package:cart_interface/features/products/data/product_model.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final Product product;
  AddToCart(this.product);
}

class RemoveFromCart extends CartEvent {
  final int productId; // Remove by ID instead of object
  RemoveFromCart(this.productId);
}

class UpdateQuantity extends CartEvent {
  final int productId; // Update quantity by ID
  final int change; // +1 for increase, -1 for decrease

  UpdateQuantity(this.productId, this.change);
}
