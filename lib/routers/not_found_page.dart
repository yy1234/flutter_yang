import 'package:flutter/material.dart';
// import 'package:flutter_deer/widgets/state_layout.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class NotFoundPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: GradientAppBar(
        title: Text('页面不存在')
      ),
      body: Container(),
      // StateLayout(
      //   type: StateType.account,
      //   hintText: '页面不存在',
      // ),
    );
  }
}
