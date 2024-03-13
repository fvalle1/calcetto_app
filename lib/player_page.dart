import 'package:flutter/material.dart';
import 'package:fussball/player.dart';

class PlayerPage extends StatelessWidget {
  Player player;

  static Map<String, String> images = {
    "Leonardo":
        "https://media.licdn.com/dms/image/D4E03AQEXARkUvC9J-A/profile-displayphoto-shrink_800_800/0/1691601600338?e=1715817600&v=beta&t=x9hbDuW2ajXjFr0mutuHtM7hWF06v9XJPHXAotvRn_8",
    "Davide":
        "https://media.licdn.com/dms/image/C4E03AQFW_xx0t-6HGw/profile-displayphoto-shrink_400_400/0/1632739103768?e=1715817600&v=beta&t=PQL0gkjOyC1WK8xrWgnS-DQoOsLnBU2Q2pQ4UkTS_zM",
    "Letizia":
        "https://media.licdn.com/dms/image/C4E03AQHP4hiVEk5Vmw/profile-displayphoto-shrink_400_400/0/1618220324829?e=1715817600&v=beta&t=ISFH4YVoHZjZoU3aaBMzakaxD8wOEXojGA5sYwpa3O4",
    "Niccolo":
        "https://media.licdn.com/dms/image/C4E03AQFtJ2hnbYIJ2g/profile-displayphoto-shrink_400_400/0/1531686220965?e=1715817600&v=beta&t=9itQxNDkCZ3SQstC5kQEW_EmLP5yeTXbJrKJB6bSw_8",
    "Federico":
        "https://media.licdn.com/dms/image/D4D03AQHbGFbI1tIWPw/profile-displayphoto-shrink_100_100/0/1699538015764?e=1715817600&v=beta&t=xp8oI7P_3rqR7R_3vBOs1Vih3DIX7Puvdeq49FY434k",
    "Matteo":
        "https://media.licdn.com/dms/image/C5603AQHokarMQe9zVw/profile-displayphoto-shrink_100_100/0/1556794903978?e=1715817600&v=beta&t=QU_mDcxxzMLzL84_AfaW7Adt8zJlirQPJgLK4hcsnqw",
    "Filippo": "https://media.licdn.com/dms/image/D4D03AQHHn9MBbjW9eA/profile-displayphoto-shrink_400_400/0/1710061649337?e=1715817600&v=beta&t=xabPMJrYW2DR3Pi_Nb0Sl7UsBpbuJAAerdilcb-l7qs",
    "Marta": "https://media.licdn.com/dms/image/C4E03AQG014zp3niOdw/profile-displayphoto-shrink_100_100/0/1624289549404?e=1715817600&v=beta&t=SKjeqZm9RBxysCFR5earmoEAUIXJVHWZAAcSBnDy2g0"
  };

  PlayerPage({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(player.name),
        ),
        body: Center(
          child: Column(
            children: [
              images.keys.contains(player.name)
                  ? Image.network(images[player.name]!,
                      width: MediaQuery.of(context).size.width * 0.3)
                  : const Icon(Icons.account_box),
              Text(
                  "games: ${player.data["Attack_games"] + player.data["Defense_games"]}"),
              Text(
                  "wins: ${player.data["Attack_wins"]} ${player.data["Defense_wins"]}"),
              Text(
                  "elo: ${player.data["Attack_elo"]} ${player.data["Defense_elo"]}"),
              Text(
                  "score: ${player.data["Attack_score"].toStringAsFixed(4)} ${player.data["Defense_score"].toStringAsFixed(4)}"),
              Text(
                  "winrate: ${player.data["Attack_winrate"]}% ${player.data["Defense_winrate"]}%"),
            ],
          ),
        ));
  }
}
