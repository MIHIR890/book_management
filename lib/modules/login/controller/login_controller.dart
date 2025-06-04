// login_controller.dart

import 'dart:convert';
import 'package:book_management/modules/login/model/user_model.dart';
import 'package:book_management/modules/mpin/view/mpin_view.dart';
import 'package:book_management/repository/api_client.dart';
import 'package:book_management/repository/api_endpoints.dart';
import 'package:book_management/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:book_management/modules/dashboard/view/dashboard.dart';
import 'package:book_management/modules/login/model/login_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  LoginModel? loginModel;
  UserModel? userModel;
  RxBool isDataStored = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    getDataFromPreference();
    super.onInit();
  }
  Future <void> getDataFromPreference() async{
    final prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('userData');
    print(userData);
    if(userData != null){
      isDataStored.value = true;
     userModel =UserModel.fromJson( json.decode(userData!));
     print(userModel?.fullName);
     }
    else{
      isDataStored.value = false;
      print("No data Stored");

    }





  }  Future <void> saveDataTOPreference(UserModel? userData) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userData', json.encode(userData?.toJson()));
    print('Saved Successfully');
    getDataFromPreference();
    isDataStored.value = true;




  }
  // Sign In with Google and Firebase
  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      print(googleUser);

      if (googleUser == null) {
        return {'success': false, 'message': 'Google Sign-In canceled'};
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print("Access Token :${googleAuth.accessToken}");
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final user = userCredential.user;
      if (user == null) {
        return {'success': false, 'message': 'Failed to retrieve user details'};
      }

      // Prepare the user data to send to backend
      Map<String, dynamic> userData = {
        'userId': user.uid,
        'email': user.email,
        'fullName': user.displayName,
        'profilePicUrl': user.photoURL,
      };

      // Send the user data to the backend
      await _sendUserDataToBackend(userData);

      return {
        'success': true,
        'data': {
          'user': userData,
        },
      };
    } catch (e) {
      print('Error during Google sign-in: $e'); // Additional logging for errors

      return {'success': false, 'message': e.toString()};
    }
  }

  // Send user data to backend
  Future<Map<String, dynamic>> _sendUserDataToBackend(
      Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse(
            '${ApiEndpoints.baseUrl}/api/auth/signup'), // Your Express endpoint
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userData),
      );

      if (response.statusCode == 200) {
        return {'success': true};
      } else {
        print(
            "Error in saving data. Status Code: ${response.statusCode}, Response Body: ${response.body}");
        return {'success': false, 'message': 'Error saving user data'};
      }
    } catch (e) {
      print("Error in sending data: $e, Type: ${e.runtimeType}");

      return {'success': false, 'message': e.toString()};
    }
  }

  // Sign out from both Firebase and Google
  Future<void> signOut() async {
    await _auth.signOut(); // Sign out from Firebase
    await _googleSignIn.signOut(); // Sign out from Google
  }

  Future<void> login(BuildContext context) async {
    Widgets.showLoader("Loading");
    try {
      const String endPoint = ApiEndpoints.loginApi;
      final body = {
        'email': emailController.text,
        'password': passwordController.text,
      };
      print(body);

      final result = await ApiHelper.post(endPoint, body);

      if (result['success']) {
        Widgets.hideLoader();

        final data = result['data'];
        if (data['message'] == 'Login successful') {
          final token = data['token'];
          userModel = UserModel.fromJson(data['userDetails']);
          print('Response: ${data}');
          saveDataTOPreference(userModel);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MpinView(),
            ),
          );
        } else {
          _showErrorDialog(context, data['message']);
          Widgets.hideLoader();
        }
      } else {
        _showErrorDialog(context, result['message']);
        Widgets.hideLoader();
      }
    } catch (e) {
      Widgets.hideLoader();
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
