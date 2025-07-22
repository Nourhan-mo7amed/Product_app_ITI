// lib/cubits/products_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task5_iti/controller/cubit/products_cubit.dart';
import '../../api_provider.dart';


class ProductsCubit extends Cubit<ProductsState> {
  final ApiProvider api;

  ProductsCubit(this.api) : super(ProductsInitial());

  void fetchProducts() async {
    emit(ProductsLoading());
    try {
      final products = await api.getAllProducts();
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
