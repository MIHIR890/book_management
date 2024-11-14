// login_controller.dart



import 'dart:convert';
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
  String url1 = ApiEndpoints.baseUrl;

  Future<void> login(BuildContext context) async {
    print("login");
    // if (!formKey.currentState!.validate()) return;

    final url = Uri.parse('http://192.168.204.11/login');
    print('${passwordController.text}');

    print('${url}');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': emailController.text,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['message'] == 'Login successful') {
        final token = data['token'];
        final userDetails = LoginModel.fromJson(data['userDetails']);
        print('Response :${response.body}');
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
      _showErrorDialog(context, 'Login failed. Please try again.');
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
  }}