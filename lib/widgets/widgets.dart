import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Widgets{

  static void showLoader(title) {
      EasyLoading.show(status: title);
  }
  static void hideLoader() {
    EasyLoading.dismiss();
  }  static void showInfo(title) {
    EasyLoading.showInfo(title);
  }

}