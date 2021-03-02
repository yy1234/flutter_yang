import 'package:flutter/material.dart';
import 'package:flutter_yang/home/splash_page.dart';
import 'package:flutter_yang/login/page/login_page.dart';
import 'package:flutter_yang/routers/routers.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  MyApp({this.home,this.theme}){
    Routes.initRoutes();
  }
  final Widget home;
  final ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
        home: SplashPage(),
      ),
      backgroundColor: Colors.black54,
      textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      radius: 20.0,
      position: ToastPosition.bottom,
    );
  }
}
