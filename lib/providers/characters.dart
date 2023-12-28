import 'package:flutter_riverpod/flutter_riverpod.dart';

final narutoP = StateProvider<bool>((ref) => true);
final aotP = StateProvider<bool>((ref) => true);
final deathNoteP = StateProvider<bool>((ref) => true);
final jujutsuKaisenP = StateProvider<bool>((ref) => true);
final othersP = StateProvider<bool>((ref) => true);
final currentCharacter = StateProvider<String>((ref) => '');
final characterOptionsP = StateProvider<List<String>>((ref) => []);