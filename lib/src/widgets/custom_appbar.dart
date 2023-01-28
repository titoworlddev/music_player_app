import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_player_app/main.dart';
import 'package:music_player_app/src/models/audioplayer_model.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

//   @override
//   _CustomAppbarState createState() => _CustomAppbarState();
// }

// class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            GestureDetector(
                onTap: () {
                  MyApp.setState(() {
                    if (Prueba.color == Colors.red) {
                      Prueba.color = Colors.white;
                    } else {
                      Prueba.color = Colors.red;
                    }
                    Prueba.index++;
                  });
                },
                child: Icon(
                  FontAwesomeIcons.chevronLeft,
                  color: Prueba.color,
                )),
            const Spacer(),
            GestureDetector(
                onTap: () {
                  Prueba.index = 0;
                  MyApp.setState(() {});
                },
                child: Text(Prueba.index.toString())),
            const SizedBox(
              width: 100,
            ),
            const Icon(FontAwesomeIcons.message),
            const SizedBox(
              width: 20,
            ),
            const Icon(FontAwesomeIcons.headphonesSimple),
            const SizedBox(
              width: 20,
            ),
            const Icon(FontAwesomeIcons.upRightFromSquare),
          ],
        ),
      ),
    );
  }
}
