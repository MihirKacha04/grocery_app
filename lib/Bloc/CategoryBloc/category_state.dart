part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryInitState extends CategoryState{
  List<Product>? products;
  CategoryInitState(this.products);
}