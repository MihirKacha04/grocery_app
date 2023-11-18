part of 'explore_bloc.dart';

@immutable
abstract class ExploreState {}

class ExploreInitial extends ExploreState {}

class ExploreInitState extends ExploreInitial {
  List<Category> categories = [];
  double? animatedtopcontainer;
  double? paddingsecondtopcontainerleft;
  double? paddingsecondtopcontainerright;
  double? paddingsecondtopcontainerbottom;
  double? secondcontainerradius;
  bool? bottomcontainer;
  bool? forcancelbutton;
  List<Product>? searchproducts;

  ExploreInitState(this.categories, this.animatedtopcontainer, this.paddingsecondtopcontainerleft, this.paddingsecondtopcontainerright,
      this.paddingsecondtopcontainerbottom, this.secondcontainerradius, this.bottomcontainer, this.forcancelbutton,this.searchproducts);
}