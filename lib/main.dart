import 'package:crousel_assignment/view/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SportsTechApp());
}

class SportsTechApp extends StatelessWidget {
  const SportsTechApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sports Tech',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Arial',
      ),
      home: const SplashScreen(),
    );
  }
}
