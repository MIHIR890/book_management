// login_controller.dart

import 'dart:convert';
import 'package:book_management/repository/api_client.dart';
import 'package:book_management/repository/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:book_management/modules/dashboard/view/dashboard.dart';
import 'package:book_management/modules/login/model/login_model.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


Future<void> login(BuildContext context) async {
  print("login");

  const String endPoint = ApiEndpoints.loginApi;
  final body = {
    'username': emailController.text,
    'password': passwordController.text,
  };

  final result = await ApiHelper.post(endPoint, body);

  if (result['success']) {
    final data = result['data'];
    if (data['message'] == 'Login successful') {
      final token = data['token'];
      final userDetails = LoginModel.fromJson(data['userDetails']);
      print('Response: ${data}');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ),
      );
    } else {
      _showErrorDialog(context, data['message']);
    }
  } else {
    _showErrorDialog(context, result['message']);
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
