import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LeaderbordPage extends StatefulWidget {
  const LeaderbordPage({super.key});

  @override
  State<StatefulWidget> createState() => _LeaderbordPageState();
}

class _LeaderbordPageState extends State<LeaderbordPage> {
  late List<String> _attackers;
  late List<String> _defenders;
  late Map<String, dynamic> _players;
  String _score = "elo";
  final TextStyle _titleStyle =
      const TextStyle(fontSize: 21, fontWeight: FontWeight.bold);

  void sortPlayers() {
    _attackers.sort((a, b) {
      return _players[a]["Attack_$_score"]
          .compareTo(_players[b]["Attack_$_score"]);
    });
    _defenders.sort((a, b) {
      return _players[a]["Defense_$_score"]
          .compareTo(_players[b]["Defense_$_score"]);
    });
    _attackers = _attackers.reversed.toList();
    _defenders = _defenders.reversed.toList();
  }

  void _fetchPlayers() async {
    final response = await http.get(
        Uri.parse('https://federicomilanesio.pythonanywhere.com/get_stats'));

    if (response.statusCode == 200) {
      _players = jsonDecode(response.body);
      for (var i = 0; i < _players.keys.length; i++) {
        //1 header, -1 last row is empty
        var player = _players.keys.toList()[i];
        if (_players[player]["Attack_games"] > 5) {
          _attackers.add(player);
        }
        if (_players[player]["Defense_games"] > 5) {
          _defenders.add(player);
        }
      }
    }

    setState(() {
      sortPlayers();
    });
  }

  @override
  void initState() {
    super.initState();
    _attackers = [];
    _defenders = [];
    _fetchPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
            child: Column(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.55,
            height: MediaQuery.of(context).size.width * 0.2,
            child: Row(
              children: [
                const Text("Choose a metric: "),
                const Spacer(flex: 1),
                DropdownButton(
                  hint: const Text("score"),
                  value: _score,
                  items: ['elo', 'games', 'wins', 'score']
                      .map((e) =>
                          DropdownMenuItem<String>(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _score = value ?? "elo";
                      sortPlayers();
                    });
                  },
                )
              ],
            )),
        Row(children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Column(children: [Text("Attackers", style: _titleStyle)])),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Column(children: [Text("Defenders", style: _titleStyle)]))
        ]),
        Row(children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Column(
                  children: [
                        _attackers.isNotEmpty
                            ? Container()
                            : const CircularProgressIndicator()
                      ] +
                      _attackers
                          .map((e) => Card(
                              child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Center(
                                      child: Text(_score == "score"
                                          ? "$e [${_players[e]['Attack_$_score'].toStringAsFixed(4)}]"
                                          : "$e [${_players[e]['Attack_$_score']}]")))))
                          .toList())),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Column(
                  children: [
                        _defenders.isNotEmpty
                            ? Container()
                            : const CircularProgressIndicator()
                      ] +
                      _defenders
                          .map((e) => Card(
                              child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Center(
                                      child: Text(_score == "score"
                                          ? "$e [${_players[e]['Defense_$_score'].toStringAsFixed(4)}]"
                                          : "$e [${_players[e]['Defense_$_score']}]")))))
                          .toList())),
        ]),
      ],
    )));
  }
}
