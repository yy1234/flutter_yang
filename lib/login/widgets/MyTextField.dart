import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_yang/res/resources.dart';
import 'package:flutter_yang/widgets/load_image.dart';

///登录模块输入封装
class MyTextField extends StatefulWidget {
  const MyTextField(
      {Key key,
      this.controller,
      this.maxLength,
      this.autoFocus = false,
      this.keyboardType,
      this.hintText,
      this.focusNode,
      this.isInputPwd = false,
      this.getVCode,
      this.keyName,
      this.labelName,
      this.readOnly,this.tapAction})
      : super(key: key);

  final TextEditingController controller;
  final int maxLength;
  final bool autoFocus;
  final TextInputType keyboardType;
  final String hintText;
  final FocusNode focusNode;
  final bool isInputPwd;
  final Future<bool> Function() getVCode;
  final String labelName;
  final bool readOnly;
  final VoidCallback tapAction;
  /// 用于集成测试寻找widget
  final String keyName;

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isShowPwd = false;
  bool _isShowDelete = false;
  bool _clickable = true;

  /// 倒计时秒数
  final int _second = 30;

  /// 当前秒数
  int _currentSecond;
  StreamSubscription _subscription;

  @override
  void initState() {
    ///获取初始化值
    _isShowDelete = widget.controller.text.isEmpty;

    /// 监听输入改变
    widget.controller.addListener(isEmpty);
    super.initState();
  }

  void isEmpty() {
    final bool isEmpty = widget.controller.text.isEmpty;

    /// 状态不一样在刷新，避免重复不必要的setState
    if (isEmpty != _isShowDelete) {
      setState(() {
        _isShowDelete = isEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final bool isDark = themeData.brightness == Brightness.dark;
    final TextField textField = TextField(
      focusNode: widget.focusNode,
      maxLength: widget.maxLength,
      readOnly: widget.readOnly ?? false,
      onTap: ()=>widget.tapAction(),
      obscureText: widget.isInputPwd && !_isShowPwd,
      autofocus: widget.autoFocus,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
          isDense: true,
          // contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
          hintText: '${widget.hintText}\n',
          hintStyle: TextStyle(color: Colors.grey, fontSize: Dimens.font_sp14),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 0.8)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 0.8))),
    );

    Widget clearButton;
    if (!_isShowDelete) {
      //Semantics:主要用于在 Android TalkBack 或者 iOS VoiceOver 使用，例如视障人士的使用
      clearButton = Semantics(
        label: '清空',
        hint: '清空输入框',
        child: GestureDetector(
          child: LoadAssetImage(
            'login/qyg_shop_icon_delete',
            key: Key('${widget.keyName}_delete'),
            width: 18.0,
            height: 40.0,
          ),
          onTap: () => widget.controller.text = '',
        ),
      );
    }

    Widget pwdVisible;
    if (widget.isInputPwd) {
      pwdVisible = Semantics(
        label: '密码可见开关',
        hint: '密码是否可见',
        child: GestureDetector(
          child: LoadAssetImage(
            _isShowPwd
                ? 'login/qyg_shop_icon_display'
                : 'login/qyg_shop_icon_hide',
            key: Key('${widget.keyName}_showPwd'),
            width: 18.0,
            height: 40.0,
          ),
          onTap: (){
            setState(() {
              _isShowPwd = !_isShowPwd;
            });

          },
        ),
      );
    }

    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.labelName,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimens.font_sp16,
                  fontWeight: FontWeight.w600),
            ),
            textField
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isShowDelete) Gaps.empty else clearButton,
            if (!widget.isInputPwd) Gaps.empty else Gaps.hGap15,
            if (!widget.isInputPwd) Gaps.empty else pwdVisible,
          ],
        )
      ],
    );
  }
}
