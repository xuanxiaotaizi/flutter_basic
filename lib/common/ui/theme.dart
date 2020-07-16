import 'package:appdemo/common/ui/style.dart';
import 'package:flutter/material.dart';
class AppTheme{
  static final lightTheme = ThemeData(
    primaryColor: Colors.red,
    primaryColorBrightness: Brightness.light,

    ///大部分widget的颜色（悬浮按钮，进度条，开关）
    accentColor: Color(0xFFFEF9EB),
    ///accentColor亮度
    accentColorBrightness:Brightness.light,
    ///与主题色形成对比的图标主题
    accentIconTheme: IconThemeData(
      color: Colors.white
    ),

    ///与primaryColor形成对比的颜色
    backgroundColor: Colors.white30,
    buttonColor: Colors.blue,
    cardColor: Colors.white,

//    ///常用的13组颜色
//    colorScheme: ColorScheme(
//      primary: Colors.blue,
//      primaryVariant:Colors.blueAccent,
//      secondary: Colors.green,
//      secondaryVariant: Colors.greenAccent,
//      surface: Colors.orange,
//      background: Colors.white,
//      error: Colors.red,
//      onPrimary: Colors.blue[300],
//      onError: Colors.red[300],
//      onSecondary: Colors.green[300],
//      onSurface: Colors.orange[300],
//      brightness: Brightness.light
//    ),
    cursorColor: Colors.blue,
    dialogBackgroundColor: Colors.white,
    disabledColor: Colors.white30,
    dividerColor: Colors.white30,
    errorColor: RjStyle.danger,
    hintColor: Colors.white30,
    indicatorColor: Colors.white,
    textSelectionColor: Colors.blue,
    textSelectionHandleColor: Colors.blue[800]
  );
}