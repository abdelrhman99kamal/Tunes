// import 'package:flutter/material.dart';
// import 'package:tunes/components/tune_item.dart';
// import 'package:tunes/models/tune_model.dart';

// class TunePage extends StatelessWidget {
//   const TunePage({super.key});

//   final List<TuneModel> tunes = const [
//     TuneModel(color: Color(0xFFB2DFDB), sound: "note1.wav", title: "Do"),
//     TuneModel(color: Color(0xFF80CBC4), sound: "note2.wav", title: "Re"),
//     TuneModel(color: Color(0xFF4DB6AC), sound: "note3.wav", title: "Mi"),
//     TuneModel(color: Color(0xFF26A69A), sound: "note4.wav", title: "Fa"),
//     TuneModel(color: Color(0xFF009688), sound: "note5.wav", title: "Sol"),
//     TuneModel(color: Color(0xFF00897B), sound: "note6.wav", title: "La"),
//     TuneModel(color: Color(0xFF00796B), sound: "note7.wav", title: "Si"),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           "Tune App",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 30,
//           ),
//         ),
//         backgroundColor: Colors.teal[900],
//       ),
//       body: Column(
//         children: tunes.map((tune) => TuneItem(tune: tune)).toList(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:tunes/components/tune_item.dart';
import 'package:tunes/models/tune_model.dart';
import 'package:audioplayers/audioplayers.dart'; // لو مش موجود، ضيفه في pubspec.yaml

class TunePage extends StatefulWidget {
  const TunePage({super.key});

  @override
  State<TunePage> createState() => _TunePageState();
}

class _TunePageState extends State<TunePage> {
  final List<TuneModel> tunes = const [
    TuneModel(color: Color(0xFFB2DFDB), sound: "note1.wav", title: "Do"),
    TuneModel(color: Color(0xFF80CBC4), sound: "note2.wav", title: "Re"),
    TuneModel(color: Color(0xFF4DB6AC), sound: "note3.wav", title: "Mi"),
    TuneModel(color: Color(0xFF26A69A), sound: "note4.wav", title: "Fa"),
    TuneModel(color: Color(0xFF009688), sound: "note5.wav", title: "Sol"),
    TuneModel(color: Color(0xFF00897B), sound: "note6.wav", title: "La"),
    TuneModel(color: Color(0xFF00796B), sound: "note7.wav", title: "Si"),
  ];

  final List<GlobalKey> keys = List.generate(7, (_) => GlobalKey());
  final Set<int> triggered = {}; // علشان نمنع التكرار

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Tune App",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.teal[900],
      ),
      body: GestureDetector(
        onPanDown: (details) => _handleTouch(details.globalPosition),
        onPanUpdate: (details) => _handleTouch(details.globalPosition),
        onPanEnd: (_) => triggered.clear(), // نفرّغ اللستة بعد ما المستخدم يشيل إيده
        child: Column(
          children: List.generate(tunes.length, (index) {
            return TuneItem(
              key: keys[index],
              tune: tunes[index],
            );
          }),
        ),
      ),
    );
  }

  void _handleTouch(Offset globalPosition) {
    for (int i = 0; i < keys.length; i++) {
      final key = keys[i];
      final context = key.currentContext;
      if (context == null) continue;

      final box = context.findRenderObject() as RenderBox;
      final position = box.localToGlobal(Offset.zero);
      final size = box.size;
      final rect = position & size;

      if (rect.contains(globalPosition) && !triggered.contains(i)) {
        triggered.add(i);
        _playSound(tunes[i].sound);
      }
    }
  }

  void _playSound(String sound) {
    final player = AudioPlayer();
    player.play(AssetSource(sound));
  }
}
