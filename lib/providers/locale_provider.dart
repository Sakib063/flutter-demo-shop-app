import 'package:flutter/cupertino.dart';

class LocaleProvider extends ChangeNotifier{
  late Locale _locale=Locale('en','US');
  Locale get locale=>_locale;

  void set_locale(Locale locale){
    _locale=locale;
    notifyListeners();
  }
}