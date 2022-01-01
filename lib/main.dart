import 'package:flutter/material.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/services.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:just_audio/just_audio.dart';

const double SIZE_PLAYER_BUTTON = 80.0;
Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationIcon: 'drawable/ic_stat_Waheguru',
    androidNotificationChannelId: 'com.wahegurulive.waheguru_simran.channel.audio',
    androidNotificationChannelName: 'Waheguru Simran Audio playback',
    androidNotificationOngoing: true,
  );
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
  static int _nextMediaId = 0;
  late AudioPlayer _player;
  final _playlist = ConcatenatingAudioSource(
    children: [
      AudioSource.uri(
        Uri.parse("asset:///asset/waheguru-simran-loop.mp3"),
        tag: MediaItem(
          id: '${_nextMediaId++}',
          album: "Simran | Gurdwara Prabh Milne Ka Chao, Moga",
          title: "Wahe-Guru Simran",
          artUri: Uri.parse("asset:///asset/waheguru-simran-cover.jpg"),
        ),
      ),
    ],
  );

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {}, onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await _player.setLoopMode(LoopMode.one); // loop current item
      await _player.setAudioSource(_playlist);
    } catch (e, stackTrace) {
      // Catch load errors: 404, invalid url ...
      print("Error loading playlist: $e");
      print(stackTrace);
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset('assets/wahe-guru-simran-cover.jpg'),
              ),
              SizedBox(
                height: 16.0,
              ),
              StreamBuilder<PlayerState>(
                stream: _player.playerStateStream,
                builder: (context, snapshot) {
                  final playerState = snapshot.data;
                  final processingState = playerState?.processingState;
                  final playing = playerState?.playing;
                  if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
                    return Container(
                      width: SIZE_PLAYER_BUTTON,
                      height: SIZE_PLAYER_BUTTON,
                      child: CircularProgressIndicator(),
                    );
                  } else if (playing != true) {
                    return IconButton(
                      icon: Icon(Icons.play_arrow),
                      iconSize: SIZE_PLAYER_BUTTON,
                      onPressed: _player.play,
                    );
                  } else if (processingState != ProcessingState.completed) {
                    return IconButton(
                      icon: Icon(Icons.pause),
                      iconSize: SIZE_PLAYER_BUTTON,
                      onPressed: _player.pause,
                    );
                  } else {
                    return IconButton(
                      icon: Icon(Icons.replay),
                      iconSize: SIZE_PLAYER_BUTTON,
                      onPressed: () => _player.seek(Duration.zero, index: _player.effectiveIndices!.first),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
