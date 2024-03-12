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
  String score = "elo";
  final TextStyle _titleStyle =
      const TextStyle(fontSize: 21, fontWeight: FontWeight.bold);

  void _fetchPlayers() async {
    final response = await http.get(
        Uri.parse('https://federicomilanesio.pythonanywhere.com/get_stats'));

    if (response.statusCode == 200) {
      _players = jsonDecode(response.body);
      for (var i = 0; i < _players.keys.length; i++) {
        //1 header, -1 last row is empty
        var player = _players.keys.toList()[i];
        _attackers.add(player);
        _defenders.add(player);
      }
    }

    setState(() {
      _attackers.sort((a, b) {
        return _players[a]["Attack_elo"].compareTo(_players[b]["Attack_elo"]);
      });
      _defenders.sort((a, b) {
        return _players[a]["Defense_elo"].compareTo(_players[b]["Defense_elo"]);
      });
      _attackers = _attackers.reversed.toList().sublist(0, 10);
      _defenders = _defenders.reversed.toList().sublist(0, 10);
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
                              child: Text("$e [${_players[e]['Attack_elo']}]")))
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
                              child:
                                  Text("$e [${_players[e]['Defense_elo']}]")))
                          .toList()))
        ])
      ],
    )));
  }
}
