import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impostor/providers/players.dart';
import 'package:impostor/ui/app_bar.dart';

class DiscussionV extends ConsumerWidget {

  const DiscussionV({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: myAppBar(theme),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.2),
            Text(
              'Discussion Time !',
              style: GoogleFonts.alegreyaSans(
                fontWeight: FontWeight.w800,
                fontSize: 25,
              ),
            ),
            SizedBox(height: size.height * 0.1),
            Text(
              'Ask each other some questions about the topic and try to figure out the impostor.',
              style: GoogleFonts.alegreyaSans(
                fontSize: 20,
              ),
            ),
            SizedBox(height: size.height * 0.1),
            ElevatedButton(
              onPressed: () {
                ref.read(turnP.notifier).state = 0;
                Navigator.of(context).pushNamed('/vote');
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(size.width * 0.5, size.height * 0.06),
                foregroundColor: theme.primaryColorLight,
                backgroundColor: theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
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
    );
  }

}