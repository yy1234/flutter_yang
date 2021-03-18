import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_yang/common/common.dart';
import 'package:flutter_yang/util/theme_utils.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sp_util/sp_util.dart';

class Utils {
  static KeyboardActionsConfig getKeyboardActionsConfig(BuildContext context, List<FocusNode> list) {
    return KeyboardActionsConfig(
      keyboardBarColor: ThemeUtils.getKeyboardActionsColor(context),
      nextFocus: true,
      actions: List.generate(list.length, (i) => KeyboardActionsItem(
        focusNode: list[i],
        toolbarButtons: [
              (node) {
            return GestureDetector(
              onTap: () => node.unfocus(),
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(getCurrLocale() == 'zh' ? '关闭' : 'Close'),
              ),
            );
          },
        ],
      )),
    );
  }


  static String getCurrLocale() {
    final String locale = SpUtil.getString(Constant.locale);
    if (locale == '') {
      return window.locale.languageCode;
    }
    return locale;
  }
}