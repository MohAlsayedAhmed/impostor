import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:impostor/providers/players.dart';
import 'package:impostor/services/functions.dart';
import 'package:impostor/ui/app_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class NOfImpostorsV extends ConsumerWidget {

  const NOfImpostorsV({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final number = ref.watch(nOfImpostorsP);
    final players = ref.read(playersP);
    return Scaffold(
      appBar: myAppBar(theme),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.2),
            Text(
              'Number of impostors',
              style: GoogleFonts.alegreyaSans(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: size.height * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: size.height * 0.015),
                  child: IconButton(
                    icon: Icon(
                      Icons.minimize,
                      size: 28,
                      color: theme.primaryColorLight,
                    ),
                    onPressed: () {
                      if (number > 1) {
                        ref.read(nOfImpostorsP.notifier).update((state) => state - 1);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  number.toString(),
                  style: GoogleFonts.alegreyaSans(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 15),
                IconButton(
                  icon: Icon(
                    Icons.add,
                    size: 28,
                    color: theme.primaryColorLight,
                  ),
                  onPressed: () {
                    final nOfPlayers = players.length;
                    if (nOfPlayers >= 7) {
                      if (number < 3) {
                        ref.read(nOfImpostorsP.notifier).update((state) => state + 1);
                      }
                    } else {
                      if (number < 2) {
                        ref.read(nOfImpostorsP.notifier).update((state) => state + 1);
                      }
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: size.height * 0.1),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(size.width * 0.5, size.height * 0.06),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                foregroundColor: theme.primaryColorLight,
                backgroundColor: theme.primaryColor,
              ),
              onPressed: () {
                List<String> impostors = [];
                ref.read(nOfImpostorsP) == 1 ?
                impostors.add(randomImpostor(players)) :
                impostors.addAll(randomImpostors(ref.read(nOfImpostorsP), players));
                ref.read(impostorsP.notifier).state = impostors;
                ref.read(textToShowP.notifier).state = 'Give the phone to ${players[0]}';
                Navigator.of(context).popAndPushNamed('/turn');
              },
              child: Text(
                'Start',
                style: GoogleFonts.alegreyaSans(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}