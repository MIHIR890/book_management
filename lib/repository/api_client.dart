import 'dart:convert';
import 'dart:async'; // Import for TimeoutException

import 'package:book_management/repository/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static Future<Map<String, dynamic>> post(
    String endPoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    String url = ApiEndpoints.baseUrl + endPoint;
    final uri = Uri.parse(url);

    try {
      final response = await http
          .post(
            uri,
            headers: headers ?? {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 30));

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
}
