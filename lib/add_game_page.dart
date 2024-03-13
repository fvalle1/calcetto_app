import 'package:flutter/material.dart';
import 'package:fussball/api.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class AddGamePage extends StatefulWidget {
  const AddGamePage({super.key});

  @override
  State<StatefulWidget> createState() => _AddGameState();
}

class _AddGameState extends State<AddGamePage> {
  final _formKey = GlobalKey<FormState>();
  String _state = "unsaved";

  final noteController = TextEditingController();
  final scoreBlueController = TextEditingController();
  final scoreRedController = TextEditingController();

  late List<String?> _selectedOptions;
  late List<TextEditingController?> _selectedOptionsControllers;
  List<String> _players = [];
  static const TextStyle _blueStyle = TextStyle(color: Colors.blue);
  static const TextStyle _redStyle = TextStyle(color: Colors.red);
  static DateFormat format = DateFormat('dd/MM/yyyy');

  void fetchPlayers() async {
    // _players = ["Player 1", "Player 2", "Player 3", "Player 4", "Player 5"];
    final response = await http
        .get(Uri.parse('https://federicomilanesio.pythonanywhere.com/MainGroup/get_csv'));

    if (response.statusCode == 200) {
      var rows = response.body.split("\n");
      for (var i = 1; i < rows.length - 1; i++) {
        //1 header, -1 last row is empty
        var row = rows[i].split(",");
        _players.add(row[0]);
        _players.add(row[1]);
        _players.add(row[2]);
        _players.add(row[3]);
      }

      _players = _players.toSet().toList(); //drop duplicates

      setState(() {
        _players.sort((a, b) {
          return a.toLowerCase().compareTo(b.toLowerCase());
        });
      });
      print(_players);
    } else {
      throw Exception('Failed to load');
    }
  }

  static String? _emptyValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _selectedOptions = List.filled(4, null);
    _selectedOptionsControllers =
        List.generate(4, (i) => TextEditingController());
    fetchPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Add game"),
        ),
        body: Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Row(children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(children: [
                            DropdownButtonFormField(
                                hint: const Text("Attacker"),
                                items: _players.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value, style: _blueStyle),
                                      );
                                    }).toList() +
                                    [
                                      const DropdownMenuItem(
                                          value: "newplayer",
                                          child: Text("New player"))
                                    ],
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedOptions[0] = newValue;
                                  });
                                },
                                validator: _emptyValidator),
                            if (_selectedOptions[0] == "newplayer")
                              TextFormField(
                                controller: _selectedOptionsControllers[0],
                                decoration: const InputDecoration(
                                  labelText: 'Enter custom value',
                                ),
                              ),
                            DropdownButtonFormField(
                                hint: const Text("Defender"),
                                items: _players.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value, style: _blueStyle),
                                      );
                                    }).toList() +
                                    [
                                      const DropdownMenuItem(
                                          value: "newplayer",
                                          child: Text("New player"))
                                    ],
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedOptions[1] = newValue;
                                  });
                                },
                                validator: _emptyValidator),
                            if (_selectedOptions[1] == "newplayer")
                              TextFormField(
                                controller: _selectedOptionsControllers[1],
                                decoration: const InputDecoration(
                                  labelText: 'Enter custom value',
                                ),
                              ),
                            TextFormField(
                                keyboardType: TextInputType.number,
                                controller: scoreBlueController,
                                validator: _emptyValidator,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  hintText:
                                      'Blue team score', // Placeholder text
                                ))
                          ])),
                      const Spacer(flex: 1),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(children: [
                            DropdownButtonFormField(
                                hint: const Text("Attacker"),
                                items: _players.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value, style: _redStyle),
                                      );
                                    }).toList() +
                                    [
                                      const DropdownMenuItem(
                                          value: "newplayer",
                                          child: Text("New player"))
                                    ],
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedOptions[2] = newValue;
                                  });
                                },
                                validator: _emptyValidator),
                            if (_selectedOptions[2] == "newplayer")
                              TextFormField(
                                controller: _selectedOptionsControllers[2],
                                decoration: const InputDecoration(
                                  labelText: 'Enter custom value',
                                ),
                              ),
                            DropdownButtonFormField(
                                hint: const Text("Defender"),
                                items: _players.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value, style: _redStyle),
                                      );
                                    }).toList() +
                                    [
                                      const DropdownMenuItem(
                                          value: "newplayer",
                                          child: Text("New player"))
                                    ],
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedOptions[3] = newValue;
                                  });
                                },
                                validator: _emptyValidator),
                            if (_selectedOptions[3] == "newplayer")
                              TextFormField(
                                controller: _selectedOptionsControllers[3],
                                decoration: const InputDecoration(
                                  labelText: 'Enter custom value',
                                ),
                              ),
                            TextFormField(
                                keyboardType: TextInputType.number,
                                controller: scoreRedController,
                                validator: _emptyValidator,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  hintText:
                                      'Red team score', // Placeholder text
                                ))
                          ]))
                    ]),
                    TextFormField(
                      controller: noteController,
                      decoration: const InputDecoration(hintText: "Notes"),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              var player0 = _selectedOptions[0] != "newplayer"
                                  ? _selectedOptions[0]
                                  : _selectedOptionsControllers[0]!.text;
                              var player1 = _selectedOptions[1] != "newplayer"
                                  ? _selectedOptions[1]
                                  : _selectedOptionsControllers[1]!.text;
                              var player2 = _selectedOptions[2] != "newplayer"
                                  ? _selectedOptions[2]
                                  : _selectedOptionsControllers[2]!.text;

                              var player3 = _selectedOptions[3] != "newplayer"
                                  ? _selectedOptions[3]
                                  : _selectedOptionsControllers[3]!.text;
                              _state =
                                  "Saved!\n[$player0-$player1 vs $player2-$player3]\n${scoreBlueController.text}-${scoreRedController.text}\n${noteController.text}";
                              addGameApi({
                                "ATT. ROSSO": player2,
                                "DIF. ROSSO": player3,
                                "ATT. BLU": player0,
                                "DIF. BLU": player1,
                                "VITTORIA":
                                    int.parse(scoreBlueController.text) >
                                            int.parse(scoreRedController.text)
                                        ? "BLU"
                                        : "ROSSO",
                                "DATA": format.format(DateTime.now()),
                                "SCORE":
                                    "${scoreBlueController.text}-${scoreRedController.text}"
                              });
                            });
                          }
                        },
                        child: const Text("Save")),
                    Text(_state, softWrap: true, maxLines: 4)
                  ]),
                ))));
  }
}
