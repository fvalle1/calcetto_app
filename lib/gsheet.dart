import 'package:gsheets/gsheets.dart';
import 'package:fussball/gsheet_credentials.dart';

const _spreadsheetId = '1PodA5S9aJsvI0Rj7vUhXZK8qYZBX5vA2P2BYV-xA2_I';

void appendRow(dynamic data) async {
  // init GSheets
  final gsheets = GSheets(credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);

  // get worksheet by its title
  var sheet = ss.worksheetByTitle('Foglio1');
  // create worksheet if it does not exist yet
  sheet ??= await ss.addWorksheet('Foglio1');

  // insert list in row #1
  final firstRow = [
    'ATT. ROSSO',
    'DIF. ROSSO',
    'ATT. BLU',
    'DIF. BLU',
    'VITTORIA',
    'DATA',
    'SCORE'
  ];
  await sheet.values.insertRow(1, firstRow);
  // prints [index, letter, number, label]
  print(await sheet.values.row(1));

  await sheet.values.map.appendRow(data);
  print(await sheet.values.map.lastRow());
}
