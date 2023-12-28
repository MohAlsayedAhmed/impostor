import 'package:flutter/material.dart';
import 'package:impostor/services/theme.dart';
import 'package:impostor/ui/home.dart';
import 'package:impostor/ui/vote.dart';
import 'package:impostor/ui/turn.dart';
import 'package:impostor/ui/impostor.dart';
import 'package:impostor/ui/discussion.dart';
import 'package:impostor/ui/players.dart';
import 'package:impostor/ui/n_of_impostors.dart';
import 'package:impostor/ui/topic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Impostor',
      theme: myTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => const HomeV(),
        '/vote': (BuildContext context) => const VoteV(),
        '/turn': (BuildContext context) => const TurnV(),
        '/impostor': (BuildContext context) => const ImpostorV(),
        '/discussion': (BuildContext context) => const DiscussionV(),
        '/players': (BuildContext context) => PlayersV(),
        '/n_of_impostors': (BuildContext context) => const NOfImpostorsV(),
        '/topic': (BuildContext context) => const TopicV(),
      },
    );
  }

}