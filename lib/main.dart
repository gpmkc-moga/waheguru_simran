import 'package:flutter/material.dart';

void main() {
  runApp(const WaheguruSimranApp());
}

class WaheguruSimranApp extends StatelessWidget {
  const WaheguruSimranApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const WaheguruSimranHomePage(),
    );
  }
}

class WaheguruSimranHomePage extends StatefulWidget {
  const WaheguruSimranHomePage({Key? key}) : super(key: key);

  @override
  State<WaheguruSimranHomePage> createState() => _WaheguruSimranHomePageState();
}

class _WaheguruSimranHomePageState extends State<WaheguruSimranHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Image.asset('assets/wahe-guru-simran-cover.jpg'),
          ),
        ],
      ),
    );
  }
}
