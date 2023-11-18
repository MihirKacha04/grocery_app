import '../demo json.dart';
import 'Model.dart';

class Singleton {
  static final Singleton _singleton = Singleton._internal();
  ResponseModel? finalresponse;
  List<Product> allproducts = [];

  adddata(){
    finalresponse = responseModelFromJson(Response11.res);

    for(int i=0;i<finalresponse!.categories!.length;i++){
      for(int j=0;j<finalresponse!.categories![i].products!.length;j++){
        allproducts.add(finalresponse!.categories![i].products![j]);
      }
    }
  }

  factory Singleton() {
    return _singleton;
  }


  Singleton._internal();
}