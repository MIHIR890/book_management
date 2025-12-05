import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  static Future<bool?> showConfirmationDialog(BuildContext context) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete"),
          content: const Text("Are you sure you want to save this item?"),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true), // Return true
              child: const Text("Yes"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false), // Return false
              child: const Text("No"),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      // Show the success message as a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Color(0xFF00BAAB)),
          ),
          content: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline_rounded,
                  color: Color(0xFF00BAAB)),
              SizedBox(width: 10),
              Text(
                'Success! ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
              ),
              Text(
                'Item successfully saved.',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      );
    }

    return confirmed; // Return the dialog result
  }

  static Future<bool?> showRejectionDialog(BuildContext context) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true), // Return true
              child: const Text("Yes"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false), // Return false
              child: const Text("No"),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      // Show the success message as a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Color(0xFF00BAAB)),
          ),
          content: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline_rounded,
                  color: Color(0xFF00BAAB)),
              SizedBox(width: 10),
              Text(
                'Success! ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
              ),
              Text(
                'Item successfully Deleted.',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      );
    }

    return confirmed; // Return the dialog result
  }

}