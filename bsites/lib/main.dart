import 'package:bsites/screen/auth/login_.dart';
import 'package:flutter/material.dart';

void main()  {
  runApp( const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    // todo: border style
  OutlineInputBorder primaryBorder = const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),borderSide: BorderSide(color:  Color.fromARGB(255,237, 237, 237),));
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'bsites',
      theme: ThemeData(
        // todo ########## Appbar
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 250, 250, 250),
          elevation: 2,
          titleTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 27,fontFamily: 'serif',color: Colors.black),
          iconTheme: IconThemeData(color: Colors.grey)
        ),
        // todo ########## TabBar
        tabBarTheme: const  TabBarTheme(
          labelColor: Color.fromARGB(255, 255, 255, 255),
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: 'serif'),
        ),
        // todo ########## primary color
        colorScheme: ThemeData().colorScheme.copyWith(
          primary: const Color.fromARGB(250, 250, 121, 44),
        ),
        focusColor: const Color.fromARGB(250, 250, 121, 44),
        // todo ########## card
        cardTheme:const CardTheme(
          color:  Color.fromARGB(255,250,250,250),
          elevation: 2,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        ),
        inputDecorationTheme: InputDecorationTheme(
          counterStyle: const TextStyle(height:0.3, color: Colors.black),
          errorStyle: const TextStyle(
            height: 0.8,
            letterSpacing: 0.7,
            color: Colors.red
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          filled: true,
          fillColor: const Color.fromARGB(255,237, 237, 237),
          enabledBorder:  primaryBorder,
          focusedBorder: primaryBorder,
          errorBorder:primaryBorder,
          focusedErrorBorder:primaryBorder,
          disabledBorder:primaryBorder,
        ),
        brightness: Brightness.light,
        fontFamily: 'Cairo',
        iconTheme: const IconThemeData(
          size: 30,
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 22,
            fontFamily: 'serif',
            fontWeight: FontWeight.w700
          ),
          headline2: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'serif',
          )
        ),
        // todo ########## Elevated button
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 38),
            elevation: 2,
            textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 22),
            shape: const RoundedRectangleBorder(
              side:  BorderSide(
                color: Colors.transparent,
                width: 1
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))
            )
          ),
        ),
      ),
      home:  const Login(),
    );
  }
}
