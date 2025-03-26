import 'package:cart_interface/features/products/data/product_model.dart';

abstract class ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final int page;
  final bool hasReachedMax;
  final bool isLoadingMore;

  ProductLoaded({
    required this.products,
    required this.page,
    required this.hasReachedMax,
    this.isLoadingMore = false,
  });

  ProductLoaded copyWith({
    List<Product>? products,
    int? page,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}
