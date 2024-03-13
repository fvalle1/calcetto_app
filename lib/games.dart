import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fussball/game_page.dart';
import 'package:fussball/games_card.dart';
import 'package:fussball/stats.dart';
import 'package:http/http.dart' as http;

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  @override
  State<StatefulWidget> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  late Future<Stats> _futureStats;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _futureStats = fetchData();
  }

  Future<Stats> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://federicomilanesio.pythonanywhere.com/MainGroup/get_csv'));

    if (response.statusCode == 200) {
      return Stats.fromFetchedCSV(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _removeGame(int index) async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });
    final response = await http.post(
      Uri.parse(
          'https://federicomilanesio.pythonanywhere.com/MainGroup/remove_game'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"idx": index}),
    );

    if (response.statusCode == 201) {
      setState(() {
        _futureStats = fetchData();
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to remove game [${response.body}]');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: FutureBuilder<Stats>(
        future: _futureStats,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Column(
              children: [
                Spacer(flex: 1),
                CircularProgressIndicator(),
                Spacer(
                  flex: 1,
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData && snapshot.data!.games != null) {
            return ListView.builder(
              itemCount: snapshot.data!.games!.length,
              itemBuilder: (context, index) {
                final game = snapshot.data!.games![index];
                return Card(
                    child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 100,
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GameCard(game: game),
                        GestureDetector(
                            child: const Icon(
                              Icons.info,
                              color: Colors.lightBlue,
                            ),
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => GamePage(game: game),
                                ))),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            if (game.index != null) {
                              _removeGame(game.index!);
                            }
                          },
                          child: _isLoading
                              ? const SizedBox(
                                  width: 10,
                                  height: 10,
                                  child: CircularProgressIndicator())
                              : const Icon(
                                  Icons.delete_forever,
                                  color: Color.fromARGB(255, 199, 57, 57),
                                ),
                        )
                      ],
                    ),
                  ),
                ));
              },
            );
          } else {
            return const Text('No games available');
          }
        },
      ),
    ));
  }
}
