import 'package:flutter/material.dart';
import 'package:fussball/stats.dart';
import 'package:intl/intl.dart';

class GameCard extends StatelessWidget {
  final Partita game;
  static DateFormat format = DateFormat('dd-MM-yyyy');

  const GameCard({super.key, required this.game});

  static List<TextStyle> _getStyle(Partita game) {
    try {
      if (game.score[0] > game.score[1]) {
        return [
          const TextStyle(fontWeight: FontWeight.bold),
          const TextStyle()
        ];
      } else {
        return [
          const TextStyle(),
          const TextStyle(fontWeight: FontWeight.bold)
        ];
      }
    } catch (e) {
      print(e);
      return [const TextStyle(), const TextStyle()];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 1),
        Column(children: [
          Text(format.format(game.data ?? DateTime(2024))),
          Text("${game.score[0]}-${game.score[1]}")
        ]),
        const Spacer(flex: 1),
        Column(children: [
          Text("${game.players[0]} ${game.players[1]}",
              style: _getStyle(game)[0]),
          const Text("vs"),
          Text("${game.players[2]} ${game.players[3]}",
              style: _getStyle(game)[1])
        ]),
        const Spacer(flex: 1)
      ],
    ));
  }
}
