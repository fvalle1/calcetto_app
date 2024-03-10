import 'package:flutter/material.dart';

class LeaderbordPage extends StatefulWidget {
  const LeaderbordPage({super.key});

  @override
  State<StatefulWidget> createState() => _LeaderbordPageState();
}

class _LeaderbordPageState extends State<LeaderbordPage> {
  late List<String> _attackers;

  late List<String> _defenders;

  _fetchAttackers() {
    _attackers = ["Player 1", "Player 2"];
  }

  _fetchDefenders() {
    _defenders = ["Player 3", "Player 4"];
  }

  @override
  void initState() {
    super.initState();
    _fetchAttackers();
    _fetchDefenders();
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
              child: const Column(children: [
                Text("Attackers", style: TextStyle(fontWeight: FontWeight.bold))
              ])),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: const Column(children: [
                Text("Defenders", style: TextStyle(fontWeight: FontWeight.bold))
              ]))
        ]),
        Row(children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Column(
                  children:
                      _attackers.map((e) => Card(child: Text(e))).toList())),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Column(
                  children: _defenders.map((e) => Card(child: Text(e))).toList()))
        ])
      ],
    )));
  }
}
