import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoLocalization{
  final Locale locale;
  Map<String,String> _localizedValues={};

  DemoLocalization(this.locale);

  static DemoLocalization? of(BuildContext context) {
    return Localizations.of<DemoLocalization>(context, DemoLocalization);
  }

  Future<void> load() async{
    String json_values=await rootBundle.loadString('assets/languages/${locale.languageCode}.json');
    Map<String,dynamic> mapped_json=json.decode(json_values);

    _localizedValues=mapped_json.map((key,value)=>MapEntry(key, value));
  }

  String? translated_value(String key){
    return _localizedValues[key];
  }
  static const LocalizationsDelegate<DemoLocalization> delegate=_demoLocalizationDelegate();
}

class _demoLocalizationDelegate extends LocalizationsDelegate<DemoLocalization>{
  const _demoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en','bn'].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalization> load(Locale locale) async{
    DemoLocalization localization=DemoLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<DemoLocalization> old)=>false;
}