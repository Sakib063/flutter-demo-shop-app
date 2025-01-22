import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/classes/Language.dart';
import 'package:shop/pages/cart.dart';
import 'package:shop/pages/product_list.dart';
import 'package:shop/providers/locale_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int current_page=0;
  List<Widget> pages=const[
    ProductList(),
    Cart(),
  ];
  LocaleProvider local_provider=LocaleProvider();

  void _changeLanguage(Language language, BuildContext context){
    Locale _temp;
    switch(language.lang_code){
      case 'en':
        _temp=Locale(language.lang_code,'US');
        Provider.of<LocaleProvider>(context,listen:false).set_locale(_temp);
        break;
      case 'bn':
        _temp=Locale(language.lang_code,'BD');
        Provider.of<LocaleProvider>(context,listen:false).set_locale(_temp);
        break;
      default:
        _temp = Locale('en', 'US');
        Provider.of<LocaleProvider>(context, listen: false).set_locale(_temp);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding:EdgeInsets.all(8.0),
            child: DropdownButton(
              icon: Icon(Icons.language),
              underline: SizedBox(),
              items: Language.lang_list()
              .map<DropdownMenuItem<Language>>((lang)=>DropdownMenuItem(
                value: lang,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:[Text(lang.name),Text(lang.flag)],
                ),
              )).toList(),
              onChanged:(Language? language){
                _changeLanguage(language!,context);
              },
            ),
          )
        ],
      ),
      body: IndexedStack(
        index: current_page,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        onTap: (value){
          setState(() {
            current_page=value;
          });
        },
        currentIndex: current_page,
        items:const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'cart',
          ),
        ],
      ),
    );
  }
}
