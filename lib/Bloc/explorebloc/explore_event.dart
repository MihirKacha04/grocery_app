part of 'explore_bloc.dart';

@immutable
abstract class ExploreEvent {}

class ExploreInitEvent extends ExploreEvent{
  List<Category> categories = [];
  ExploreInitEvent({required this.categories});
}

class SearchTapEvent extends ExploreEvent{
  List<Category> categories = [];
  SearchTapEvent(this.categories);
}

class SearchonChangeEvent extends ExploreEvent{
  List<Category> categories = [];
  List<Product> allproducts = [];
  String? text;
  SearchonChangeEvent(this.categories,this.allproducts,this.text);
}