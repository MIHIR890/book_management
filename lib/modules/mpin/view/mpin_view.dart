import 'package:book_management/modules/mpin/controller/mpin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MpinView extends StatefulWidget {
  const MpinView({super.key});

  @override
  State<MpinView> createState() => _MpinViewState();
}

class _MpinViewState extends State<MpinView> {
  MpinController mpinController = Get.put(MpinController());

  @override
  void initState() {
    // TODO: implement initState
    mpinController.checkPinIsExistOrNot();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MPIN",)),
      body: Center(
        child: Column(
          children: [
            Form(
              key: mpinController.formKey,
              child: TextFormField(
                maxLength: 4,
                onChanged: (value)=>{
                  mpinController.pin1 = value

                },
                decoration: InputDecoration(
                  label: Text( "Enter Pin 1")
                )),

              ),


          ],

        ),
      ),
    );
  }
}