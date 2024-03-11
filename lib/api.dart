import 'package:http/http.dart' as http;

void add_game_api(Map<String,String> data) async {
  final response = await http.post(Uri.parse("https://"),
      headers: {"Content-Type": "application/json"}, body: data);

  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to add game');
  }
}
