import 'package:flutter/material.dart';
import 'package:fussball/games_card.dart';
import 'package:fussball/stats.dart';

import 'package:http/http.dart' as http;

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  @override
  State<StatefulWidget> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  Future<Stats>? _futureStats;

  Future<Stats> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://docs.google.com/spreadsheets/d/1SSFXASco6-ld0arnmjhplIbsaCvLiUdEbDG15g5qKus/export?gid=0&format=csv'));

    if (response.statusCode == 200) {
      return Stats.fromFetchedCSV(response.body);
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  void initState() {
    super.initState();
    _futureStats = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futureStats,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.75,
                  child: ListView(
                    children: snapshot.data!.games!
                        .map((game) => GameCard(game: game))
                        .toList())));
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
