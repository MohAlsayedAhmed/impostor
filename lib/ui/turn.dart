import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impostor/providers/players.dart';
import 'package:impostor/services/functions.dart';
import 'package:impostor/ui/app_bar.dart';

class TurnV extends ConsumerWidget {

  const TurnV({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final text = ref.watch(textToShowP);
    final turn = ref.watch(turnP);
    final show = ref.watch(showP);
    final players = ref.watch(playersP);
    return Scaffold(
      appBar: myAppBar(theme),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.2),
              Text(
                players[ref.read(turnP)],
                style: GoogleFonts.alegreyaSans(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: size.height * 0.1),
              Text(
                text,
                style: GoogleFonts.alegreyaSans(
                  fontSize: 20,
                ),
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
                  if (turn == players.length - 1 && show) {
                    Navigator.of(context).popAndPushNamed('/discussion');
                    return;
                  }
                  ref.read(showP.notifier).update((state) => !state);
                  if (!ref.read(showP)) {
                    ref.read(turnP.notifier).update((state) => state + 1);
                  }
                  if (ref.read(showP)) {
                    showText(ref, players[turn]);
                  } else {
                    ref.read(textToShowP.notifier).state =
                    'Give the phone to ${players[ref.read(turnP)]}.';
                  }
                },
                child: Text(
                  'Next',
                  style: GoogleFonts.alegreyaSans(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}