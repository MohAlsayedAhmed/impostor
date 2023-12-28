import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:impostor/providers/characters.dart';
import 'package:impostor/providers/players.dart';
import 'package:impostor/topics/anime_characters.dart';

Random _random = Random();

String randomCharacter(List<String> characters) {
  final idx = _random.nextInt(characters.length - 1);
  return characters[idx];
}

List<String> possibleCharacters(WidgetRef ref) {
  List<String> result = [];
  if (ref.read(narutoP.notifier).state == true) {
    result.addAll(naruto.toList());
  }
  if (ref.read(aotP.notifier).state == true) {
    result.addAll(aot.toList());
  }
  if (ref.read(deathNoteP.notifier).state == true) {
    result.addAll(deathNote.toList());
  }
  if (ref.read(jujutsuKaisenP.notifier).state == true) {
    result.addAll(jujutsuKaisen.toList());
  }
  if (ref.read(othersP.notifier).state == true) {
    result.addAll(others.toList());
  }
  if(result.isEmpty) {
    result = naruto;
  }
  return result;
}

String randomImpostor(List<String> players) {
    final idx = _random.nextInt(players.length - 1);
    return players[idx];
}

List<String> randomImpostors(int number, List<String> players) {
  List<String> impostors = [];
  int idx1, idx2, idx3;
  idx1 = _random.nextInt(players.length - 1);
  impostors.add(players[idx1]);
  do {
    idx2 = _random.nextInt(players.length - 1);
  } while (idx2 == idx1);
  impostors.add(players[idx2]);
  if (number == 3) {
    do {
      idx3 = _random.nextInt(players.length - 1);
    } while (idx3 == idx1 || idx3 == idx2);
    impostors.add(players[idx3]);
  }
  return impostors;
}

void showText(WidgetRef ref, String player) {
  final impostors = ref.read(impostorsP);
  final topic = ref.read(currentCharacter);
  if (impostors.contains(player)) {
    if (impostors.length == 1) {
      ref.read(textToShowP.notifier).state =
      'You are an impostor. Try to figure out the topic.';
    } else if (impostors.length == 2) {
      final idx = impostors.indexOf(player);
      List<String> otherImpostors = [];
      for (int i = 0; i < impostors.length; i++) {
        if (i != idx) {
          otherImpostors.add(impostors[i]);
        }
      }
      ref.read(textToShowP.notifier).state =
      'You and ${otherImpostors[0]} are impostors. Try to figure out the topic.';
    } else {
      final idx = impostors.indexOf(player);
      List<String> otherImpostors = [];
      for (int i = 0; i < impostors.length; i++) {
        if (i != idx) {
          otherImpostors.add(impostors[i]);
        }
      }
      ref.read(textToShowP.notifier).state =
      'You, ${otherImpostors[0]} and ${otherImpostors[1]} are impostors. Try to figure out the topic.';
    }
  } else {
    ref.read(textToShowP.notifier).state =
    'The topic is $topic. Try to figure out the impostor(s).';
  }
}

List<String> characterOptions(List<String> characters, String topic) {
  List<String> result = [];
  String character = '';
  int idx = _random.nextInt(7);
  for (int i = 0; i < 7; i++) {
    if (i == idx) {
      result.add(topic);
    } else {
      do {
        character = randomCharacter(characters);
      } while (character == topic);
      result.add(character);
    }
  }
  return result;
}