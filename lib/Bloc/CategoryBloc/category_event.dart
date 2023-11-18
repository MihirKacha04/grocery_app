part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class CategoryInitEvent extends CategoryEvent{
  List<Product>? products;
  CategoryInitEvent(this.products);
}
