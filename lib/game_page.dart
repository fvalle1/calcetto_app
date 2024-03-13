import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fussball/stats.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class GamePage extends StatelessWidget {
  final Partita game;
  static DateFormat format = DateFormat("dd-MM-yyyy");
  Future<String>? _randomfact;

  Future<String> _getRandomEvent(DateTime date) async {
    var response = await http.get(Uri.parse(
        "https://en.wikipedia.org/api/rest_v1/feed/onthisday/events/${date.month}/${date.day}"),
        headers: {"User-Agent":"online.fvalle.fussball"}
        );

    if (response.statusCode == 200) {
      var events = jsonDecode(response.body)["events"];
      Random random = Random();

      int randomIndex = random.nextInt(events.length);

      // Get the random element from the array
      var randomElement = events[randomIndex];

      return "On this day in ${randomElement["year"]} ${randomElement["text"]}";
    } else {
      throw Exception(response.body);
    }
  }

  GamePage({super.key, required this.game}) {
    _randomfact = _getRandomEvent(game.data ?? DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("${game.score[0]}-${game.score[1]}"),
        ),
        body: Center(
            child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              Icon(Icons.emoji_events, color: Colors.yellow[600], size: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Column(
                    children: [
                      Text(format.format(game.data ?? DateTime(2024))),
                      Text("${game.score[0]}-${game.score[1]}")
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Text("${game.players[0]} ${game.players[1]}",
                          style: getStyle(game)[0]),
                      const Text("vs"),
                      Text("${game.players[2]} ${game.players[3]}",
                          style: getStyle(game)[1])
                    ],
                  ),
                  const Spacer()
                ],
              ),
              const Spacer(),
              Row(
                children: Iterable<Icon>.generate(
                    game.score[0],
                    (i) => const Icon(Icons.sports_soccer_outlined,
                        color: Colors.red)).toList(),
              ),
              Row(
                children: Iterable<Icon>.generate(
                    game.score[1],
                    (i) => const Icon(Icons.sports_soccer_outlined,
                        color: Colors.blue)).toList(),
              ),
              const Spacer(),
              FutureBuilder(
                  future: _randomfact,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data!);
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      return Container();
                    }
                  }),
              const Spacer(
                flex: 5,
              ),
            ],
          ),
        )));
  }
}
