import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier{
  final List<Map<String,dynamic>> _cart=[];

  get cart=>_cart;

  void add_product(Map<String,dynamic> product){
    _cart.add(product);
    notifyListeners();
  }

  void remove_product(Map<String,dynamic> product){
    _cart.remove(product);
    notifyListeners();
  }

  void clear_cart(){
    _cart.clear();
    notifyListeners();
  }
}