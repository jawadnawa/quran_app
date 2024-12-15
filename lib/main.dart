import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const Quran());
}

class Quran extends StatelessWidget {
  const Quran({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "صفحة القراء",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              // عنصر القارئ: بندر بليلة
              GestureDetector(
                onTap: () {
                  // عند الضغط على الصورة، انتقل إلى صفحة الاستماع
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QuranPageBander()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage("images/bander.webp"),
                        radius: 50,
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        "بندر بليلة",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Changa",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(thickness: 3, color: Colors.black),
              // عنصر القارئ: علي جابر
              GestureDetector(
                onTap: () {
                  // عند الضغط على الصورة، انتقل إلى صفحة الاستماع لعلي جابر
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QuranPageAliJaber()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage("images/ali.jpg"),
                        radius: 50,
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        "علي جابر",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Changa",
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
              const Divider(thickness: 3, color: Colors.black),
               Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "أجر لجواد النوايسة ولمن استمع إليه",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Changa",
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          
        ),
      ),
    );
  }
}

class QuranPageBander extends StatefulWidget {
  const QuranPageBander({super.key});

  @override
  State<QuranPageBander> createState() => _QuranPageBanderState();
}
// قران بندر بليلة
class _QuranPageBanderState extends State<QuranPageBander> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  String _currentSurah = '';

  void _toggleAudio(String surahPath) async {
    if (_isPlaying && _currentSurah == surahPath) {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
        _currentSurah = '';
      });
    } else {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(surahPath));
      setState(() {
        _isPlaying = true;
        _currentSurah = surahPath;
      });
    }
  }

  void _restartAudio(String surahPath) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(surahPath));
    setState(() {
      _isPlaying = true;
      _currentSurah = surahPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quran Recitation - بندر بليلة",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: "Changa",
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      backgroundColor: const Color.fromARGB(244, 255, 255, 255),
      body: SafeArea(
        child: Column(
         children: [
            // عنصر لسورة مريم
              ListTile(
                minVerticalPadding: 20,
                leading: const CircleAvatar(
                  backgroundImage: AssetImage("images/bander.webp"),
                  radius: 50,
                ),
                title: const Text(
                  "سورة مريم - بندر بليلة",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Changa",
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        _isPlaying && _currentSurah == 'quran-1.mp3'
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.green,
                        size: 30,
                      ),
                      onPressed: () => _toggleAudio('quran-1.mp3'),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.replay,
                        color: Colors.blue,
                        size: 30,
                      ),
                      onPressed: () => _restartAudio('quran-1.mp3'),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 3, color: Colors.black),
              // عنصر لسورة الحجر
              ListTile(
                minVerticalPadding: 20,
                leading: const CircleAvatar(
                  backgroundImage: AssetImage("images/bander.webp"),
                  radius: 50,
                ),
                title: const Text(
                  "سورة الحجر - بندر بليلة",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Changa",
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        _isPlaying && _currentSurah == 'quran-2.mp3'
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.green,
                        size: 30,
                      ),
                      onPressed: () => _toggleAudio('quran-2.mp3'),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.replay,
                        color: Colors.blue,
                        size: 30,
                      ),
                      onPressed: () => _restartAudio('quran-2.mp3'),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 3, color: Colors.black),
              //سورة الفاتحة
              ListTile(
              minVerticalPadding: 20,
              leading: const CircleAvatar(
                backgroundImage: AssetImage("images/bander.webp"),
                radius: 50,
              ),
              title: const Text(
                "سورة الفاتحة - بندر بليلة",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Changa",
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      _isPlaying && _currentSurah == 'quran-3.mp3'
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.green,
                      size: 30,
                    ),
                    onPressed: () => _toggleAudio('quran-3.mp3'),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.replay,
                      color: Colors.blue,
                      size: 30,
                    ),
                    onPressed: () => _restartAudio('quran-3.mp3'),
                  ),
                ],
              ),
            ),
              Divider(thickness: 3, color: Colors.black),
              //سورة السجده
              ListTile(
  minVerticalPadding: 20,
  leading: const CircleAvatar(
    backgroundImage: AssetImage("images/bander.webp"),
    radius: 50,
  ),
  title: const Text(
    "سورة السجدة - بندر بليلة",
    style: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      fontFamily: "Changa",
    ),
  ),
  trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        icon: Icon(
          _isPlaying && _currentSurah == 'quran-4.mp3'
              ? Icons.pause
              : Icons.play_arrow,
          color: Colors.green,
          size: 30,
        ),
        onPressed: () => _toggleAudio('quran-4.mp3'),
      ),
      IconButton(
        icon: const Icon(
          Icons.replay,
          color: Colors.blue,
          size: 30,
        ),
        onPressed: () => _restartAudio('quran-4.mp3'),
      ),
    ],
  ),
),
          ],
        ),
      ),
    );
  }
}

class QuranPageAliJaber extends StatefulWidget {
  const QuranPageAliJaber({super.key});

  @override
  State<QuranPageAliJaber> createState() => _QuranPageAliJaberState();
}
// قران علي جابر
class _QuranPageAliJaberState extends State<QuranPageAliJaber> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  String _currentSurah = '';

  void _toggleAudio(String surahPath) async {
    if (_isPlaying && _currentSurah == surahPath) {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
        _currentSurah = '';
      });
    } else {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(surahPath));
      setState(() {
        _isPlaying = true;
        _currentSurah = surahPath;
      });
    }
  }

  void _restartAudio(String surahPath) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(surahPath));
    setState(() {
      _isPlaying = true;
      _currentSurah = surahPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quran Recitation - علي جابر",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: "Changa",
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      backgroundColor: const Color.fromARGB(244, 255, 255, 255),
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              minVerticalPadding: 20,
              leading: const CircleAvatar(
                backgroundImage: AssetImage("images/ali.jpg"),
                radius: 50,
              ),
              title: const Text(
                "قيد الانشاء - علي جابر",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Changa",
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      _isPlaying && _currentSurah == 'quran-1-ali.mp3'
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.green,
                      size: 30,
                    ),
                    onPressed: () => _toggleAudio('quran-1-ali.mp3'),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.replay,
                      color: Colors.blue,
                      size: 30,
                    ),
                    onPressed: () => _restartAudio('quran-1-ali.mp3'),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 3, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
