import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_activity_event.dart';
part 'main_activity_state.dart';

class MainActivityBloc extends Bloc<MainActivityEvent, MainActivityState> {
  MainActivityBloc() : super(MainActivityInitial()) {

    on<Changetab>((event, emit) {
      print("123");
      emit(ChangeTabState(event.index));
      print("456");
    });
  }
}
