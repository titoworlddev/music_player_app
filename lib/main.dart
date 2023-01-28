import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/models/audioplayer_model.dart';
import 'src/pages/music_player_page.dart';
import 'src/theme/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  static late AnimationController _setSt;

  const MyApp({super.key});
  static void setState(void Function() fn) {
    fn();
    _setSt.forward(from: 0);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    MyApp._setSt = AnimationController(
        vsync: this, duration: const Duration(microseconds: 10));
    MyApp._setSt.addListener(() => setState(() {
          if (kDebugMode) {
            print('Setstate');
          }
        }));
    super.initState();
  }

  @override
  void dispose() {
    MyApp._setSt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioPlayerModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Music Player',
        theme: miTema,
        home: const MusicPlayerPage(),
      ),
    );
  }
}
