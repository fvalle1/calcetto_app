import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Partita {
  List<String> players;
  DateTime? data;
  List<int> score;
  int? index;
  static final DateFormat format = DateFormat('dd/MM/yyyy');

  Partita({required this.players, this.data, required this.score, this.index});

  static List<int> parseScore(String scoreStr) {
    try {
      return [
        int.tryParse(scoreStr.split("-")[0]) ?? 0,
        int.tryParse(scoreStr.split("-")[1]) ?? 0
      ];
    } catch (e) {
      print(e);
      return [0, 0];
    }
  }

  factory Partita.fromFetchedJson(String json, int index) {
    var data = json.split(',');
    return Partita(
        players: [data[0], data[1], data[2], data[3]],
        data: format.parse(data[5]),
        score: parseScore(data[6]),
        index: index);
  }
}

List<TextStyle> getStyle(Partita game) {
    try {
      if (game.score[0] > game.score[1]) {
        return [
          const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          const TextStyle(color: Colors.black)
        ];
      } else {
        return [
          const TextStyle(color: Colors.black),
          const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
        ];
      }
    } catch (e) {
      return [const TextStyle(), const TextStyle()];
    }
  }

class Stats {
  List<Partita>? games;

  Stats({this.games});

  factory Stats.fromFetchedCSV(String json) {
    var tmpGames = json.split("\n");
    List<Partita> games = [];
    for (var i = 1; i < tmpGames.length - 1; i++) {
      games.add(Partita.fromFetchedJson(tmpGames[i], i - 1));
    }

    return Stats(games: games.reversed.toList());
  }
}
