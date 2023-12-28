import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impostor/providers/players.dart';
import 'package:impostor/services/functions.dart';
import 'package:impostor/ui/app_bar.dart';

class PlayersV extends ConsumerWidget {

  PlayersV({super.key});

  final TextEditingController _nameCtrl = TextEditingController();
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final players = ref.watch(playersP);
    return Scaffold(
      appBar: myAppBar(theme),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.03),
              SizedBox(
                height: size.height * 0.5,
                child: ListView.builder(
                  itemCount: players.length,
                  itemBuilder: (BuildContext context, int idx) => Container(
                    padding: EdgeInsets.only(
                      bottom: size.height * 0.01,
                    ),
                    child: SizedBox(
                      height: size.height * 0.06,
                      child: myListTile(
                              ref: ref,
                              name: players[idx],
                              theme: theme,
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(height: size.height * 0.02),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
              child: TextField(
                style: GoogleFonts.alegreyaSans(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Add Player',
                ),
                controller: _nameCtrl,
                maxLength: 33,
              ),
            ),
              SizedBox(height: size.height * 0.06),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fixedSize: Size(size.width * 0.5, size.height * 0.06),
                  foregroundColor: theme.primaryColorLight,
                  backgroundColor: theme.primaryColor,
                ),
                onPressed: () {
                  if (players.length >= 3) {
                    if (players.length >=5) {
                      Navigator.pushNamed(context, '/n_of_impostors');
                    } else {
                      final impostor = randomImpostor(players);
                      ref.read(impostorsP.notifier).state.add(impostor);
                      ref.read(textToShowP.notifier).state = 'Give the phone to ${players[0]}.';
                      Navigator.of(context).popAndPushNamed('/turn');
                    }
                  }
                },
                child: Text(
                  'Continue',
                  style: GoogleFonts.alegreyaSans(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: FloatingActionButton(
          onPressed: () {
            if (_nameCtrl.text.isNotEmpty) {
              bool isUnique = true;
              for (int i = 0; i < players.length; i++) {
                if (players[i] == _nameCtrl.text) isUnique = false;
              }
              if (isUnique) {
                ref.read(playersP.notifier).addPlayer(_nameCtrl.text);
                _nameCtrl.clear();
              }
            }
          },
          backgroundColor: theme.primaryColor,
          foregroundColor: theme.primaryColorLight,
          shape: const CircleBorder(eccentricity: 0.5),
          child: Icon(
            Icons.add,
            size: 25,
            color: theme.primaryColorLight,
          ),
        ),
      ),
    );
  }

}

Widget myListTile({
  required WidgetRef ref,
  required String name,
  required ThemeData theme,
}) => ListTile(
  title: Text(
      name,
      style: GoogleFonts.alegreyaSans(
        fontSize: 21,
        fontWeight: FontWeight.w700,
      ),
  ),

  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  tileColor: theme.primaryColor,
  trailing: IconButton(
    icon: Icon(
      Icons.delete_outline,
      size: 25,
      color: theme.primaryColorLight,
    ),
    onPressed: () =>
        ref.read(playersP.notifier).removePlayer(name),
  ),
);