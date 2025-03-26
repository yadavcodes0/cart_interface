import 'package:cart_interface/features/cart/logic/cart_bloc.dart';
import 'package:cart_interface/features/cart/logic/cart_event.dart';
import 'package:cart_interface/features/cart/logic/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/bottom_checkout_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        centerTitle: true,
        title: const Text(
          "Cart",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            final cartItems = state.cart;
            final totalPrice = cartItems.fold(0.0, (total, item) {
              return total + (item.discountedPrice * item.quantity);
            });
            final totalQuantity =
                cartItems.fold(0, (sum, item) => sum + item.quantity);

            return Column(
              children: [
                Expanded(
                  child: cartItems.isEmpty
                      ? const Center(
                          child: Text("Your cart is empty",
                              style: TextStyle(fontSize: 18)),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(8),
                          itemCount: cartItems.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final product = cartItems[index];
                            return Container(
                              padding:
                                  const EdgeInsets.all(8).copyWith(left: 0),
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    product.imageUrl,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  const SizedBox(width: 8),
                                  // Product Details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          product.brand,
                                          style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 12),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "₹${product.price.toStringAsFixed(2)}",
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Flexible(
                                              child: Text(
                                                "₹${product.discountedPrice.toStringAsFixed(2)}",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${product.discountPercentage.toStringAsFixed(2)}% OFF",
                                          style: const TextStyle(
                                              color: Color(0xfff292b4),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Quantity Counter
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: 120,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove,
                                                color: Colors.black, size: 14),
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(
                                              maxWidth:
                                                  20, // Tighter constraints
                                              maxHeight: 20,
                                            ),
                                            onPressed: () {
                                              if (product.quantity > 1) {
                                                context.read<CartBloc>().add(
                                                    UpdateQuantity(
                                                        product.id, -1));
                                              } else {
                                                context.read<CartBloc>().add(
                                                    RemoveFromCart(product.id));
                                              }
                                            },
                                          ),
                                          Text(
                                            product.quantity.toString(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xfff06091),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.add,
                                                color: Colors.black, size: 14),
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(
                                              maxWidth: 20,
                                              maxHeight: 20,
                                            ),
                                            onPressed: () {
                                              context.read<CartBloc>().add(
                                                  UpdateQuantity(
                                                      product.id, 1));
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
                if (cartItems.isNotEmpty)
                  BottomCheckoutCard(
                      totalPrice: totalPrice, totalQuantity: totalQuantity),
              ],
            );
          }
          return const Center(child: Text("Cart is empty"));
        },
      ),
    );
  }
}
