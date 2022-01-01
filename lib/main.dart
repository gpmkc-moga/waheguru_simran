import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const WaheguruSimranApp());
}

class WaheguruSimranApp extends StatelessWidget {
  const WaheguruSimranApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: Image.asset('assets/wahe-guru-simran-cover.jpg'),
              ),
              SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
