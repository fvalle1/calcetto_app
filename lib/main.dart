import 'package:flutter/material.dart';
import 'package:fussball/add_game_page.dart';
import 'package:fussball/games.dart';
import 'package:fussball/leaderboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fussball App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Fussball'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _addGame(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddGamePage(),
      ),
    );
  }

  int _selectedIndex = 0;

  void _onBottomBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _pagesOptions = [
    const Text("Fussball App"),
    const GamesPage(),
    const LeaderbordPage(),
    const AddGamePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(child: _pagesOptions.elementAt(_selectedIndex)),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addGame(context),
          tooltip: 'Add Game',
          child: const Icon(Icons.add_box_rounded),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onBottomBarTap,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(icon: Icon(Icons.games), label: "games"),
            BottomNavigationBarItem(
                icon: Icon(Icons.leaderboard), label: "leaderboard")
          ],
        ));
  }
}
