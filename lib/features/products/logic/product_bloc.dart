import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/product_repositery.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductLoading()) {
    on<FetchProducts>(_onFetchProducts);
    on<FetchMoreProducts>(_onFetchMoreProducts);
  }

  void _onFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    try {
      final products = await repository.fetchProducts(page: 1);
      emit(ProductLoaded(
        products: products,
        page: 1,
        hasReachedMax: products.length < 10,
      ));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onFetchMoreProducts(
      FetchMoreProducts event, Emitter<ProductState> emit) async {
    if (state is! ProductLoaded) return;
    final currentState = state as ProductLoaded;

    if (currentState.isLoadingMore || currentState.hasReachedMax) return;

    emit(currentState.copyWith(isLoadingMore: true));

    try {
      final newProducts =
          await repository.fetchProducts(page: currentState.page + 1);
      emit(ProductLoaded(
        products: [...currentState.products, ...newProducts],
        page: currentState.page + 1,
        hasReachedMax: newProducts.length < 10,
        isLoadingMore: false,
      ));
    } catch (e) {
      emit(currentState.copyWith(isLoadingMore: false));
    }
  }
}
