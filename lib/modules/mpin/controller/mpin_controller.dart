import 'dart:developer';

import 'package:book_management/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MpinController extends GetxController {
  bool isPinSaved = false;
  String pin1 = '';
  String pin2 = '';
  String savedPin = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> storePin(String pin) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('savePin', pin);
    isPinSaved = true;
    update();
  }
  
  Future<void> getPin() async {
    var prefs = await SharedPreferences.getInstance();
    savedPin = prefs.getString('savePin')!;
    print(savedPin);
    isPinSaved = true;

  }


  Future<void> checkPinIsExistOrNot() async {
    var prefs = await SharedPreferences.getInstance();
    try {
      savedPin = prefs.getString('loginPin') ?? '';
      if (savedPin!.isNotEmpty) {
        log(savedPin!);
        isPinSaved = true;
      }
    } catch (e) {
      savedPin = '';
      isPinSaved = false;
    }
    update();
  }

  Future<void> comparePin(String pin) async {
   if(pin == savedPin);
   Widgets.showInfo('You are authenticated');





  }
}