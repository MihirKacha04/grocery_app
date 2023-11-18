import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/Model.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(ExploreInitial()) {
    on<ExploreEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ExploreInitEvent>((event, emit) {
      emit(ExploreInitState(event.categories, 75,20,20,12,15,true,false,[]));
    });

    on<SearchTapEvent>((event, emit) {
      emit(ExploreInitState(event.categories, 0,0,0,0,0,false,true,[]));
    });

    on<SearchonChangeEvent>((event, emit) {
      List<Product> searchproduct = [];
      event.allproducts.forEach((element) {
        if(element.name!.toUpperCase().contains(event.text.toString().toUpperCase())){
          searchproduct.add(element);
        }
      });
      emit(ExploreInitState(event.categories, 0,0,0,0,0,false,true,searchproduct));
    });

  }
}
