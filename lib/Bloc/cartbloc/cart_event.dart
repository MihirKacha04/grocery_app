part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class Cartinitevent extends CartEvent{
  List<Product>? productsincart;
  Cartinitevent(this.productsincart);
}