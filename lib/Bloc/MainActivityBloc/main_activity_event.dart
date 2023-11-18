part of 'main_activity_bloc.dart';

@immutable
abstract class MainActivityEvent {}

class Changetab extends MainActivityEvent{
  int index;
  Changetab(this.index);
}