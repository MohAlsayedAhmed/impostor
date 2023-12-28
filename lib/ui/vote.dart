import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impostor/providers/players.dart';
import 'package:impostor/ui/app_bar.dart';

class VoteV extends ConsumerStatefulWidget {

  const VoteV({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VoteVS();
}

class _VoteVS extends ConsumerState<VoteV> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final players = ref.read(playersP);
    final selectedVotes = ref.watch(selectedVotesP);
    final nOfImpostors = ref.read(nOfImpostorsP);
    final turn = ref.watch(turnP);
    return Scaffold(
      appBar: myAppBar(theme),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.06,),
              Text(
                players[turn],
                style: GoogleFonts.alegreyaSans(
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: size.height * 0.06,),
              Text(
                'Vote for the impostor(s).',
                style: GoogleFonts.alegreyaSans(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: size.height * 0.06,),
              SizedBox(
                height: size.height * 0.4,
                child: ListView.builder(
                  itemCount: players.length,
                  itemBuilder: (context, idx) {
                    return Container(
                      padding: EdgeInsets.only(bottom: size.height * 0.01),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: selectedVotes.contains(players[idx]) ?
                          theme.primaryColor :
                          theme.primaryColorLight,
                        ),
                        padding: const EdgeInsets.all(1),
                        child: GestureDetector(
                          onTap: () {
                            if (selectedVotes.contains(players[idx])) {
                              ref.read(selectedVotesP.notifier).update((state) {
                                state.remove(players[idx]);
                                return state;
                              });
                              setState(() {});
                            } else if (selectedVotes.length < nOfImpostors) {
                              ref.read(selectedVotesP.notifier).update((state) =>
                              [...state, players[idx]]);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: selectedVotes.contains(players[idx]) ?
                              theme.primaryColor :
                              theme.scaffoldBackgroundColor,
                            ),
                            height: size.height * 0.06,
                            child: Center(
                              child: Text(
                                players[idx],
                                style: GoogleFonts.alegreyaSans(
                                  fontSize: 20,
                                  color: theme.primaryColorLight,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: size.height * 0.06,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fixedSize: Size(size.width * 0.5, size.height * 0.06),
                  backgroundColor: theme.primaryColor,
                  foregroundColor: theme.primaryColorLight
                ),
                onPressed: () {
                    if (selectedVotes.length == nOfImpostors) {
                      ref.read(voteP.notifier).update((state) {
                        state.addAll({players[turn]: selectedVotes});
                        return state;
                      });
                      if (ref.read(turnP) == players.length - 1) {
                        Navigator.popAndPushNamed(context, '/impostor');
                      } else {
                        ref.read(selectedVotesP.notifier).state = [];
                        ref.read(turnP.notifier).update((state) => state + 1);
                      }
                    }
                },
                child: Text(
                  'Vote',
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