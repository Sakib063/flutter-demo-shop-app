import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop/cart_provider.dart';
import 'package:shop/global_variables.dart';
import 'package:shop/home_page.dart';
import 'package:shop/product_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>CartProvider(),
      child: MaterialApp(
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
        home: const HomePage(),
        // home: HomePage(),
      ),
    );
  }
}
