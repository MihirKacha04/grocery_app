part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductInitState extends ProductInitial{
  Product? product;
  ProductInitState(this.product);
}