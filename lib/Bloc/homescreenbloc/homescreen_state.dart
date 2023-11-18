part of 'homescreen_bloc.dart';

@immutable
abstract class HomescreenState {}

class HomescreenInitial extends HomescreenState {}

class HomescreenInitState extends HomescreenState {
  Category? exclusive;
  Category? bestselling;
  double? animatedtopcontainer;
  double? paddingsecondtopcontainerleft;
  double? paddingsecondtopcontainerright;
  double? paddingsecondtopcontainerbottom;
  double? secondcontainerradius;
  bool? bottomcontainer;
  bool? forcancelbutton;
  List<Product>? searchproducts;

  HomescreenInitState(this.exclusive, this.bestselling, this.animatedtopcontainer, this.paddingsecondtopcontainerleft, this.paddingsecondtopcontainerright,
      this.paddingsecondtopcontainerbottom, this.secondcontainerradius, this.bottomcontainer, this.forcancelbutton,this.searchproducts);
}
