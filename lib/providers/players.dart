import 'package:flutter_riverpod/flutter_riverpod.dart';

final playersP = StateNotifierProvider<PlayersN, List<String>>((ref) => PlayersN());
final nOfImpostorsP = StateProvider<int>((ref) => 1);
final impostorsP = StateProvider<List<String>>((ref) => []);
final showP = StateProvider<bool>((ref) => false);
final turnP = StateProvider<int>((ref) => 0);
final textToShowP = StateProvider<String>((ref) => '');
final voteP = StateProvider<Map<String, List<String>>>((ref) => {});
final selectedVotesP = StateProvider<List<String>>((ref) => []);

class PlayersN extends StateNotifier<List<String>> {

  PlayersN() : super([]);

  void addPlayer(String name) =>
      state = [...state, name];

  void removePlayer(String name) =>
      state = [...state.where((element) => element != name)];

}