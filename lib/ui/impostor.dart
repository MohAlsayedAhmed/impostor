import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impostor/providers/players.dart';
import 'package:impostor/ui/app_bar.dart';

class ImpostorV extends ConsumerWidget {

  const ImpostorV({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final impostors = ref.read(impostorsP);
    return Scaffold(
      appBar: myAppBar(theme),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.2),
              Text(
                impostors.length == 1 ?
                    'The impostor was :' :
                    'The impostors were :',
                style: GoogleFonts.alegreyaSans(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: size.height * 0.1),
              Text(
                impostors.length == 1 ?
                    impostors[0] :
                    impostors.length == 2 ?
                        '${impostors[0]} , ${impostors[1]}' :
                        '${impostors[0]} , ${impostors[1]} , ${impostors[2]}',
                style: GoogleFonts.alegreyaSans(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: size.height * 0.1,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fixedSize: Size(size.width * 0.5, size.height * 0.06),
                  backgroundColor: theme.primaryColor,
                  foregroundColor: theme.primaryColorLight,
                ),
                onPressed: () {
                  ref.read(turnP.notifier).state = 0;
                  Navigator.of(context).popAndPushNamed('/topic');
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