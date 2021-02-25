import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return Container(child: GradientAppBar(),);
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
