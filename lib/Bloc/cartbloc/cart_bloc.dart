import 'package:bloc/bloc.dart';
import 'package:grocery_app/model/singleton.dart';
import 'package:meta/meta.dart';

import '../../model/Model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<Cartinitevent>((event, emit) {
      double totalprice = 0.0;
      List<Product> productsincart = [];
      Singleton data = Singleton();
      if(event.productsincart!.isEmpty){
        data.allproducts.forEach((element) {
          if (element.inCart! > 0) {
            productsincart.add(element);
            totalprice = totalprice + (element.price! * element.inCart!.toDouble());
          }
        });
      } else {
        event.productsincart!.forEach((element) {
          if (element.inCart! > 0) {
            productsincart.add(element);
            totalprice = totalprice + (element.price! * element.inCart!.toDouble());
          }
        });
      }
      emit(CartinitState(productsincart,totalprice));
    });
  }
}
