import 'dart:convert';
import 'package:http/io_client.dart' as http_io;
import 'dart:io';

import '../models/apiUsersModel.dart';

Future<List<APiUser>> fetchUsers() async {
  final client = http_io.IOClient(
    // Create a custom security context and disable certificate verification
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true,
  );

  final response = await client.get(
    Uri.parse('https://dummyjson.com/users'),
  );

  if (response.statusCode == 200) {
    final dynamic jsonResponse = json.decode(response.body);

    if (jsonResponse is List) {
      // Handle case when response is an array
      return jsonResponse.map((json) => APiUser.fromJson(json)).toList();
    } else if (jsonResponse is Map<String, dynamic>) {
      // Handle case when response is an object with key representing users
      final List<dynamic> userList = jsonResponse['users'];
      return userList.map((json) => APiUser.fromJson(json)).toList();
    } else {
      throw Exception('Invalid response format');
    }
  } else {
    throw Exception('Failed to fetch users');
  }
}
