part of 'main_activity_bloc.dart';

@immutable
abstract class MainActivityState {}

class MainActivityInitial extends MainActivityState {}

class ChangeTabState extends MainActivityState {
  int index;
  ChangeTabState(this.index);
}
