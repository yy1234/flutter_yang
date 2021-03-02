import 'dart:async';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_yang/login/login_router.dart';
import 'package:flutter_yang/routers/fluro_navigator.dart';
import 'package:flutter_yang/widgets/load_image.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yang/common/common.dart';
import 'package:flutter_yang/util/image_utils.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  //是否加载闪屏页
  int _status = 0;
  final List<String> _guideList = ['app_start_1', 'app_start_2', 'app_start_3'];

  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    //页面渲染完成最后一帧回调的页面
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await SpUtil.getInstance();
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)) {
        _guideList.forEach((image) {
          precacheImage(
              ImageUtils.getAssetImage(image, format: ImageFormat.webp),
              context);
        });
      }
      _initSplash();
    });
  }

  void _initGuide() {
    if (mounted) {
      setState(() {
        _status = 1;
      });
    }
  }

  void _goLogin() {
    NavigatorUtils.push(context, LoginRouter.loginPage,replace: true);
  }

  _initSplash() {
    _subscription = Stream.value(1)
        .delay(const Duration(milliseconds: 1500))
        .listen((event) {
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)) {
        SpUtil.putBool(Constant.keyGuide, false);
        _initGuide();
      } else {
        _goLogin();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: _status == 0
          ? FractionallyAlignedSizedBox(
              heightFactor: 0.3,
              widthFactor: 0.33,
              leftFactor: 0.33,
              bottomFactor: 0,
              child: const LoadAssetImage('logo'))
          : Swiper(
              itemCount: _guideList.length,
              loop: false,
              itemBuilder: (_, int index) {
                return LoadAssetImage(
                  _guideList[index],
                  key: Key(_guideList[index]),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  format: ImageFormat.webp,
                );
              },
            ),
    );
  }
}
