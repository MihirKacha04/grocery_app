import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/model/Model.dart';

part 'homescreen_event.dart';
part 'homescreen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomescreenState> {
  HomeScreenBloc() : super(HomescreenInitial()) {
    on<HomeScreenEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<HomeScreenInitEvent>((event, emit) {
      emit(HomescreenInitState(event.exclusive, event.bestselling, 75, 20, 20, 12, 15, true, false, []));
    });

    on<SearchTapEvent>((event, emit) {
      emit(HomescreenInitState(event.exclusive, event.bestselling, 0, 0, 0, 0, 0, false, true, []));
    });

    on<SearchOnChangeEvent>((event, emit) {
      List<Product> searchproduct = [];
      event.allproducts!.forEach((element) {
        if (element.name!.toUpperCase().contains(event.text.toString().toUpperCase())) {
          searchproduct.add(element);
        }
      });
      emit(HomescreenInitState(event.exclusive, event.bestselling, 0, 0, 0, 0, 0, false, true, searchproduct));
    });
  }
}
