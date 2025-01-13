import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier{
  final List<Map<String,dynamic>> cart=[];

  void add_product(Map<String,dynamic> product){
    cart.add(product);
    notifyListeners();
  }

  void remove_product(Map<String,dynamic> product){
    cart.remove(product);
    notifyListeners();
  }
}