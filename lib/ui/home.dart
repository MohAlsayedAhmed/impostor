import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impostor/providers/characters.dart';
import 'package:impostor/services/functions.dart';
import 'package:impostor/ui/app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeV extends ConsumerWidget {

  const HomeV({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: myAppBar(theme),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: size.height * 0.1),
            myCheckboxListTile(ref, narutoP, 'Include Naruto Characters'),
            SizedBox(height: size.height * 0.03),
            myCheckboxListTile(ref, aotP, 'Include AOT Characters'),
            SizedBox(height: size.height * 0.03),
            myCheckboxListTile(ref, deathNoteP, 'Include Death Note Characters'),
            SizedBox(height: size.height * 0.03),
            myCheckboxListTile(ref, jujutsuKaisenP, 'Include Jujutsu Kaisen Characters'),
            SizedBox(height: size.height * 0.03),
            myCheckboxListTile(ref, othersP, 'Include other popular Characters'),
            SizedBox(height: size.height * 0.09),
            ElevatedButton(
              onPressed: () {
                final characters = possibleCharacters(ref);
                final character = randomCharacter(characters);
                ref.read(characterOptionsP.notifier).state =
                    characterOptions(characters, character);
                ref.read(currentCharacter.notifier).state = character;
                Navigator.pushNamed(context, '/players');
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: theme.primaryColor,
                fixedSize: Size(size.width * 0.5, size.height * 0.06),
                foregroundColor: theme.primaryColorLight,
              ),
              child: Text(
                'Continue',
                style: GoogleFonts.alegreyaSans(
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

Widget myCheckboxListTile(WidgetRef ref, StateProvider<bool> provider, String title) {
  return CheckboxListTile(
    value: ref.watch(provider),
    onChanged: (value) => ref.read(provider.notifier).state = value!,
    title: Text(
      title,
      style: GoogleFonts.alegreyaSans(
        fontSize: 20,
      ),
    ),
  );
}