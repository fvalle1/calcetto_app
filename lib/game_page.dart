import 'package:flutter/material.dart';
import 'package:fussball/stats.dart';
import 'package:intl/intl.dart';

class GamePage extends StatelessWidget {
  final Partita game;
  static DateFormat format = DateFormat("dd-MM-yyyy");

  const GamePage({super.key, required this.game});

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
              )
            ],
          ),
        )));
  }
}
