import 'package:flutter/material.dart';
import 'package:fussball/stats.dart';
import 'package:intl/intl.dart';

class GameCard extends StatelessWidget {
  final Partita game;
  final int index;
  static DateFormat format = DateFormat('dd-MM-yyyy');
  const GameCard({super.key, required this.game, this.index = -1});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 1),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(format.format(game.data ?? DateTime(2024))),
              Text("${game.score[0]}-${game.score[1]}")
            ]),
            const Spacer(flex: 1),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("${game.players[0]} ${game.players[1]}",
                  style: getStyle(game)[0]),
              const Text("vs"),
              Text("${game.players[2]} ${game.players[3]}",
                  style: getStyle(game)[1])
            ]),
            const Spacer(flex: 2),
          ],
        ));
  }
}
