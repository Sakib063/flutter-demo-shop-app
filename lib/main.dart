import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop/localization/demo_localization.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/pages/home_page.dart';
import 'package:shop/providers/locale_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers:[
        ChangeNotifierProvider(create:(context)=>CartProvider()),
        ChangeNotifierProvider(create:(context)=>LocaleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context,locale_provider,child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shop App',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 26,
              )
            ),
            textTheme: TextTheme(
              titleLarge: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              titleMedium: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              bodySmall: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              prefixIconColor: Colors.grey,
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(135,206,250,1), primary: Color.fromRGBO(135,206,250,1)),
          ),
          localizationsDelegates: [
            DemoLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: [
            Locale('en','US'),
            Locale('bn','BD'),
          ],
          localeResolutionCallback: (device_locale,supportedLocales){
            for(var locale in supportedLocales){
              if(locale.languageCode==device_locale?.languageCode){
                return device_locale;
              }
            }
            return supportedLocales.first;
          },
          locale: locale_provider.locale,
          home: const HomePage(),
          // home: HomePage(),
        );
      }
    );
  }
}
