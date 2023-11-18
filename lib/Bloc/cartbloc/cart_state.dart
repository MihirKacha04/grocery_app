part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartinitState extends CartState{
  List<Product>? productsincart;
  double totalprice;
  CartinitState(this.productsincart,this.totalprice);
}