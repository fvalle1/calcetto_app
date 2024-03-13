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
  int _selectedIndex = 0;

  void _addGame(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddGamePage(),
      ),
    );
  }

  void _onBottomBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _pagesOptions = [
    const Column(children: [
      Spacer(flex: 2),
      Text("Fussball App"),
      Spacer(flex: 1),
      Text(
          "L'app e' pura visualizzazione si declina ogni responsabilita' per i dati mostrati."),
      Spacer(flex: 2)
    ]),
    const GamesPage(),
    const LeaderbordPage(),
    const AddGamePage()
  ];

  @override
  void initState() {
    // _bannerAd = BannerAd(
    //   adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    //   size: AdSize.banner,
    //   request: AdRequest(),
    //   listener: BannerAdListener(),
    // );

    // _bannerAd.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
            child: 
           _pagesOptions.elementAt(_selectedIndex)),
          // SizedBox(
          //     height: MediaQuery.of(context).size.height * 0.1,
          //     width: MediaQuery.of(context).size.width * 0.9,
          //     child: _bannerAd == null ? Container() : AdWidget(ad: _bannerAd))
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addGame(context),
          tooltip: 'Add Game',
          child: const Icon(Icons.add_box_rounded),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onBottomBarTap,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.games), label: "Games"),
            BottomNavigationBarItem(
                icon: Icon(Icons.leaderboard), label: "Leaderboard"),
          ],
        ));
  }
}
