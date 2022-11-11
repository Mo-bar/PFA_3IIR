import 'package:bsites/view/binding.dart';
import 'package:bsites/view/screen/auth/login_.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // border style
  OutlineInputBorder primaryBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(3)),
      borderSide: BorderSide(
        color: Color.fromARGB(255, 237, 237, 237),
      ));
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      initialBinding: LoginBinding(),
      debugShowCheckedModeBanner: false,
      title: 'bsites',
      theme: ThemeData(
        //_______________ Appbar
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 250, 250, 250),
          elevation: 1,
          titleTextStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 24, fontFamily: 'Poppins', color: Colors.black),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        //_______________  TabBar
        tabBarTheme: const TabBarTheme(
          labelStyle: TextStyle(fontSize: 15, letterSpacing: 1, fontWeight: FontWeight.w700),
          unselectedLabelStyle: TextStyle(fontSize: 15, fontFamily: 'Cairo', letterSpacing: 1, fontWeight: FontWeight.w700),
        ),
        //_______________  primary color
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: const Color.fromARGB(255, 243, 201, 87),
              secondary: const Color.fromARGB(255, 203, 202, 204),
            ),
        cardTheme: const CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(
              color: Color.fromARGB(255, 211, 211, 211),
            ),
          ),
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          //____________counter style
          counterStyle: const TextStyle(height: 0.3, color: Colors.black),
          //error style
          errorStyle: const TextStyle(height: 0.8, letterSpacing: 0.7, color: Colors.red),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          filled: true,
          fillColor: const Color.fromARGB(255, 237, 237, 237),
          enabledBorder: primaryBorder,
          focusedBorder: primaryBorder,
          errorBorder: primaryBorder,
          focusedErrorBorder: primaryBorder,
          disabledBorder: primaryBorder,
        ),

        //_______________  icon theme
        brightness: Brightness.light,
        fontFamily: 'Poppins',
        //_______________  Elevated button
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 45), elevation: 1, textStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 24, color: Color.fromARGB(255, 0, 0, 0)), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3)))),
        ),
      ),
      home: const Login(),
    );
  }
}
