import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hefish_finalproject/class/color_palette.dart';
import 'package:hefish_finalproject/page/loginPage.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Palette.background,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color.fromARGB(223, 204, 210, 210),
      systemNavigationBarIconBrightness: Brightness.dark));

  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Segoe UI',
        ),
        home: const LoginPage());
  }
}
