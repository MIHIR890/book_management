import 'dart:convert';
import 'dart:async'; // Import for TimeoutException

import 'package:book_management/repository/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiHelper {


  static Future<Map<String, dynamic>> post(
    String endPoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    String url = ApiEndpoints.baseUrl + endPoint;
    final uri = Uri.parse(url);
    print(url);
    print(body);

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      )
          .timeout(const Duration(seconds: 30));
      debugPrint(response.body.toString());

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': jsonDecode(response.body),
        };
      } else {
        return {
          'success': false,
          'message': 'Error: ${response.reasonPhrase}',
        };
      }
    } on TimeoutException catch (_) {
      // Handle timeout

      return {
        'success': false,
        'message': 'Request timed out. Please try again later.',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred: $e',
      };
    }
  }
static Future<Map<String, dynamic>> post2(
    String endPoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    String url = ApiEndpoints.baseUrl2 + endPoint;
    final uri = Uri.parse(url);
    print(url);
    print(body);

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      )
          .timeout(const Duration(seconds: 30));
      debugPrint(response.body.toString());

      if (response.statusCode == 200) {
        return {
         'data' : jsonDecode(response.body),
        };
      } else {
        return {
          'success': false,
          'message': 'Error: ${response.reasonPhrase}',
        };
      }
    } on TimeoutException catch (_) {
      // Handle timeout

      return {
        'success': false,
        'message': 'Request timed out. Please try again later.',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred: $e',
      };
    }
  }

  static Future<dynamic> get(String endpoint) async {
    var baseUrl = ApiEndpoints.baseUrl2;
    final url = Uri.parse(baseUrl + endpoint);
    ("GET: $url");

    try {
      final response = await http.get(url);

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception("GET request failed: ${response.statusCode}");
      }
    } catch (e) {
      print("ERROR: $e");
      rethrow;
    }
  }


}
