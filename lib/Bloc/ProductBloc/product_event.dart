part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class ProductInitEvent extends ProductEvent {
  Product? product;
  ProductInitEvent(this.product);
}
