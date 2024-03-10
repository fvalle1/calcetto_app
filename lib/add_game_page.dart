import 'package:flutter/material.dart';
import 'package:fussball/gsheet.dart';
import 'package:intl/intl.dart';

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
  List<String> _players = [];
  static const TextStyle _blueStyle = TextStyle(color: Colors.blue);
  static const TextStyle _redStyle = TextStyle(color: Colors.red);
  static DateFormat format = DateFormat('dd/MM/yyyy');


  void fetchPlayers() {
    _players = ["Player 1", "Player 2", "Player 3", "Player 4", "Player 5"];
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
                                items: _players.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value, style: _blueStyle),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedOptions[0] = newValue;
                                  });
                                },
                                validator: _emptyValidator),
                            DropdownButtonFormField(
                                items: _players.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value, style: _blueStyle),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedOptions[1] = newValue;
                                  });
                                },
                                validator: _emptyValidator),
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
                                items: _players.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value, style: _redStyle),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedOptions[2] = newValue;
                                  });
                                },
                                validator: _emptyValidator),
                            DropdownButtonFormField(
                                items: _players.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value, style: _redStyle),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedOptions[3] = newValue;
                                  });
                                },
                                validator: _emptyValidator),
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
                              _state =
                                  "Saved!\n[${_selectedOptions[0]}-${_selectedOptions[1]} vs ${_selectedOptions[2]}-${_selectedOptions[3]}]\n${scoreBlueController.text}-${scoreRedController.text}\n${noteController.text}";
                              appendRow({
                                "ATT. ROSSO":_selectedOptions[2],
                                "DIF. ROSSO":_selectedOptions[3],
                                "ATT. BLU":_selectedOptions[0],
                                "DIF. BLU":_selectedOptions[0],
                                "VITTORIA": int.parse(scoreBlueController.text)>
                                        int.parse(scoreRedController.text)?"BLU":"ROSSO",
                                "DATA":format.format(DateTime.now()),
                                "SCORE":"${scoreBlueController.text}-${scoreRedController.text}"
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
