import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../helpers/helpers.dart';
import '../models/audioplayer_model.dart';
import '../widgets/custom_appbar.dart';

class MusicPlayerPage extends StatefulWidget {
  const MusicPlayerPage({super.key});

  @override
  State<MusicPlayerPage> createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CustomAppbar(),
              ImagenDiscoDuracion(),
              TituloPlay(),
              Expanded(child: Lyrics())
            ],
          ),
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    final screnSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: screnSize.height * 0.65,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.center,
              colors: [
                Color(0xff33333e),
                Color(0xff201e28),
              ])),
    );
  }
}

class Lyrics extends StatelessWidget {
  const Lyrics({super.key});

  @override
  Widget build(BuildContext context) {
    final lyrics = getLyrics();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: ListWheelScrollView(
        itemExtent: 42,
        diameterRatio: 1.5,
        physics: const BouncingScrollPhysics(),
        children: lyrics
            .map((linea) => Text(
                  linea,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class TituloPlay extends StatefulWidget {
  const TituloPlay({super.key});

  @override
  State<TituloPlay> createState() => _TituloPlayState();
}

class _TituloPlayState extends State<TituloPlay>
    with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  bool firstTime = true;
  late AnimationController playAnimation;

  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    playAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    final audioPlayerModel =
        Provider.of<AudioPlayerModel>(context, listen: false);
    assetsAudioPlayer.open(
      Audio(
        'assets/Amenazzy Farruko Myke Towers  Rochy RD  Rapido Official Audio.mp3',
      ),
      autoStart: false,
    );
    assetsAudioPlayer.currentPosition.listen((duration) {
      audioPlayerModel.current = duration;
    });
    assetsAudioPlayer.current.listen((playingAudio) {
      audioPlayerModel.songDuration = playingAudio!.audio.duration;
    });
    audioPlayerModel.controller.addListener(() {
      if (audioPlayerModel.porcentaje > 0.99) {
        audioPlayerModel.controller.reset();
        // audioPlayerModel.controller.stop();
        // audioPlayerModel.controller.reverse();
        playAnimation.reverse();
        isPlaying = false;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    playAnimation.dispose();
    super.dispose();
  }

  // void open() {
  //   final audioPlayerModel =
  //       Provider.of<AudioPlayerModel>(context, listen: false);
  //   assetsAudioPlayer.open(
  //     Audio(
  //       'assets/Amenazzy Farruko Myke Towers  Rochy RD  Rapido Official Audio.mp3',
  //     ),
  //     autoStart: false,
  //   );
  //   assetsAudioPlayer.playOrPause();
  //   assetsAudioPlayer.currentPosition.listen((duration) {
  //     audioPlayerModel.current = duration;
  //   });
  //   assetsAudioPlayer.current.listen((playingAudio) {
  //     audioPlayerModel.songDuration = playingAudio!.audio.duration;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      margin: const EdgeInsets.only(top: 40),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Prueba.index++;
              MyApp.setState(() {});
            },
            child: SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rápido',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  // Text('- Amenazzy -', style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.5)),),
                  Text(
                    'Amenazzy, Farruko, \nMyke Towers, Rochy RD',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          FloatingActionButton(
            elevation: 0,
            highlightElevation: 0,
            backgroundColor: const Color(0xfff8cb51),
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: playAnimation,
            ),
            onPressed: () {
              if (isPlaying) {
                playAnimation.reverse();
                audioPlayerModel.controller.stop();
                isPlaying = false;
              } else {
                playAnimation.forward();
                audioPlayerModel.controller.repeat();
                isPlaying = true;
              }
              if (firstTime) {
                // open();
                assetsAudioPlayer.playOrPause();
                firstTime = false;
              } else {
                assetsAudioPlayer.playOrPause();
              }
            },
          )
        ],
      ),
    );
  }
}

class ImagenDiscoDuracion extends StatelessWidget {
  const ImagenDiscoDuracion({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.only(
        top: mq.size.height * 0.10,
        right: mq.size.width * 0.15,
        left: mq.size.width * 0.15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          ImagenDisco(),
          BarraProgreso(),
        ],
      ),
    );
  }
}

class BarraProgreso extends StatelessWidget {
  const BarraProgreso({super.key});

  @override
  Widget build(BuildContext context) {
    final estilo = TextStyle(color: Colors.white.withOpacity(0.4));
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    final porcentaje = audioPlayerModel.porcentaje;

    return Column(
      children: [
        Text(audioPlayerModel.songTotalDuration, style: estilo),
        const SizedBox(
          height: 10,
        ),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: 3,
              height: 230,
              color: Colors.white.withOpacity(0.1),
            ),
            // Fernando lo pone abajo con el positioned pero es mas rapido el aligment...
            Container(
              width: 3,
              height: 230 * porcentaje,
              color: Colors.white.withOpacity(0.8),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(audioPlayerModel.currentSecond, style: estilo),
      ],
    );
  }
}

class ImagenDisco extends StatelessWidget {
  const ImagenDisco({super.key});

  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    return Container(
      width: 250,
      height: 250,
      padding: const EdgeInsetsDirectional.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              colors: [Color(0xff484750), Color(0xff1e1c24)])),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SpinPerfect(
              duration: const Duration(seconds: 10),
              infinite: true,
              manualTrigger: true,
              // importante este animate sino se reproduce solo cuando entras y solo gira una vez
              animate: false,
              controller: (animationController) =>
                  audioPlayerModel.controller = animationController,
              child: const Image(image: AssetImage('assets/rapido.png')),
            ),
            Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            Container(
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                color: const Color(0xff1c1c25).withOpacity(0.9),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
