import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';

class TuneModel {
  final String title;
  final String sound;
  final Color color;

  const TuneModel({
    required this.title,
    required this.sound,
    required this.color,
  });

  playSound() async {
    final player = AudioPlayer();
    await player.play(AssetSource(sound));
  }
}
