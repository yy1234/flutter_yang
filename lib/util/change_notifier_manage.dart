import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//https://www.jianshu.com/p/18e8d285c81a
//mixin 定义功能模块
//extends 单继承
//
mixin ChangeNotifierMixin<T extends StatefulWidget> on State<T> {

  Map<ChangeNotifier, List<VoidCallback>> _map;

  //内部发的方法
  Map<ChangeNotifier, List<VoidCallback>> changeNotifier();

  @override
  void initState() {
    _map = changeNotifier();
    /// 遍历数据，如果callbacks不为空则添加监听
    _map?.forEach((changeNotifier, callbacks) {
      if (callbacks != null && callbacks.isNotEmpty) {
        callbacks.forEach((callback) {
          changeNotifier?.addListener(callback);
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _map?.forEach((changeNotifier, callbacks) {
      if (callbacks != null && callbacks.isNotEmpty) {
        callbacks.forEach((callback) {
          changeNotifier?.removeListener(callback);
        });
      }
      changeNotifier?.dispose();
    });
    super.dispose();
  }
}