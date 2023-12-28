import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impostor/providers/characters.dart';
import 'package:impostor/providers/players.dart';
import 'package:impostor/ui/app_bar.dart';

class TopicV extends ConsumerStatefulWidget {

  const TopicV({super.key});

  @override
  ConsumerState<TopicV> createState() => _TopicVS();
}

class _TopicVS extends ConsumerState<TopicV> {

  bool topicShowed = false;
  String selected = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final impostors = ref.read(impostorsP);
    final characters = ref.read(characterOptionsP);
    final topic = ref.read(currentCharacter);
    final turn = ref.watch(turnP);
    return Scaffold(
      appBar: myAppBar(theme),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.07,),
              Text(
                impostors[turn],
                style: GoogleFonts.alegreyaSans(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: size.height * 0.04,),
              Text(
                'What was the topic ?',
                style: GoogleFonts.alegreyaSans(fontSize: 20),
              ),
              SizedBox(height: size.height * 0.04,),
              SizedBox(
                height: size.height * 0.5,
                child: ListView.builder(
                  itemCount: characters.length,
                  itemBuilder: (context, idx) => Container(
                    padding: EdgeInsets.only(bottom: size.height * 0.01),
                    child: GestureDetector(
                      onTap: () {
                        if (selected == characters[idx]) {
                          setState(() => selected = '');
                        } else {
                          setState(() => selected = characters[idx]);
                        }
                      },
                      child: Container(
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: topicShowed && characters[idx] == topic ?
                          Colors.green[900] :
                          selected == characters[idx] ?
                          theme.primaryColor :
                          theme.primaryColorLight,
                        ),
                        padding: const EdgeInsets.all(1),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: topicShowed && characters[idx] == topic ?
                            Colors.green[900] :
                            selected == characters[idx] ?
                            theme.primaryColor :
                            theme.scaffoldBackgroundColor,
                          ),
                          child: Center(
                            child: Text(
                              characters[idx],
                              style: GoogleFonts.alegreyaSans(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.04,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(size.width * 0.5, size.height * 0.06),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: theme.primaryColor,
                  foregroundColor: theme.primaryColorLight,
                ),
                onPressed: () {
                  if (topicShowed && turn == impostors.length - 1) {
                    Navigator.of(context).popAndPushNamed('/');
                  } else {
                    if (topicShowed) {
                      selected = '';
                      ref.read(turnP.notifier).update((state) => state + 1);
                    }
                    setState(() => topicShowed = !topicShowed);
                  }
                },
                child: Text(
                  'Next',
                  style: GoogleFonts.alegreyaSans(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}