import 'dart:convert';

import 'package:http/http.dart' as http;

void addGameApi(dynamic data) async {
  var id = "MainGroup";
  final response = await http.post(
    Uri.parse('https://federicomilanesio.pythonanywhere.com/$id/add_game'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to add game [${response.body}]');
  }
}
