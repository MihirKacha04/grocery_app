part of 'homescreen_bloc.dart';

@immutable
abstract class HomeScreenEvent {}

class HomeScreenInitEvent extends HomeScreenEvent{
  Category? exclusive;
  Category? bestselling;
  HomeScreenInitEvent({this.exclusive, this.bestselling});
}

class SearchTapEvent extends HomeScreenEvent{
  Category? exclusive;
  Category? bestselling;
  SearchTapEvent(this.exclusive,this.bestselling);
}

class SearchOnChangeEvent extends HomeScreenEvent{
  Category? exclusive;
  Category? bestselling;
  List<Product>? allproducts;
  String? text;
  SearchOnChangeEvent(this.exclusive,this.bestselling,this.allproducts,this.text);
}
