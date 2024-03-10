import 'package:intl/intl.dart';

class Partita {
  List<String> players;
  DateTime? data;
  List<int> score;
  static final DateFormat format = DateFormat('dd/MM/yyyy');

  Partita({required this.players, this.data, required this.score});

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

  factory Partita.fromFetchedJson(String json) {
    var data = json.split(',');
    return Partita(
        players: [data[0], data[1], data[2], data[3]],
        data: format.parse(data[5]),
        score: parseScore(data[6]));
  }
}

class Stats {
  List<Partita>? games;

  Stats({this.games});

  factory Stats.fromFetchedCSV(String json) {
    return Stats(
        games: json
            .split("\n")
            .sublist(1)
            .map((g) => Partita.fromFetchedJson(g))
            .toList());
  }
}
