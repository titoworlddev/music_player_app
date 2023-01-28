import 'package:flutter/material.dart';

class Prueba {
  static int index = 0;
  static Color color = Colors.white;
}

class AudioPlayerModel with ChangeNotifier {
  bool _playing = false;

  bool get playing => _playing;
  set playing(bool valor) {
    _playing = valor;
    notifyListeners();
  }

  late AnimationController controller;

  Duration _songDuration = const Duration(milliseconds: 0);

  Duration get songDuration => _songDuration;
  set songDuration(Duration valor) {
    _songDuration = valor;
    notifyListeners();
  }

  Duration _current = const Duration(milliseconds: 0);

  Duration get current => _current;
  set current(Duration valor) {
    _current = valor;
    notifyListeners();
  }

  double get porcentaje => (_songDuration.inSeconds > 0)
      ? _current.inSeconds / _songDuration.inSeconds
      : 0;

  String printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return '$n';
      return '0$n';
    }

    String twoDigitsMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitsSeconds = twoDigits(duration.inSeconds.remainder(60));

    // return '${twoDigits(duration.inHours)}:$twoDigitsMinutes:$twoDigitsSeconds';
    return '$twoDigitsMinutes:$twoDigitsSeconds';
  }

  String get songTotalDuration => printDuration(_songDuration);
  String get currentSecond => printDuration(_current);
}
