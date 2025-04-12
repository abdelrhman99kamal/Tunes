// import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:tunes/pages/tune_page.dart';

// void main() {
//   runApp(DevicePreview(enabled: true, builder: (context) => Home()));
// }

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: TunePage());
  }
}



