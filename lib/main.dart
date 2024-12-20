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
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, fontFamily: "Changa"),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true, // تقليل الحجم ليكون مناسباً
            children: [
              // نص إرشادي
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "اختر قارئًا للاستماع إلى تلاوات القرآن الكريم.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Changa",
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              const Divider(
                  thickness: 3, color: Color.fromARGB(129, 236, 52, 52)),
              // قائمة القراء
              _buildReaderTile(context, "بندر بليلة", "images/bander.webp",
                  const QuranPageBander()),
              const Divider(thickness: 3, color: Colors.black),
              _buildReaderTile(context, "علي جابر", "images/ali.jpg",
                  const QuranPageAliJaber()),
              const Divider(thickness: 3, color: Colors.black),
              // رسالة إضافية
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    "أجر لجواد النوايسة ولمن استمع إليه",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Changa",
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دالة لبناء عنصر القارئ
  Widget _buildReaderTile(
      BuildContext context, String name, String imagePath, Widget page) {
    return GestureDetector(
      onTap: () {
        // الانتقال إلى صفحة الاستماع
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: 50,
            ),
            const SizedBox(width: 20),
            Text(
              name,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: "Changa",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuranPageBander extends StatefulWidget {
  const QuranPageBander({super.key});

  @override
  _QuranPageBanderState createState() => _QuranPageBanderState();
}

class _QuranPageBanderState extends State<QuranPageBander> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  String _currentSurah = '';
  Map<String, Duration> _currentPositions = {};
  Map<String, Duration> _totalDurations = {};

  // متغير لتخزين نص البحث
  String _searchText = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _surahs = [
    {"name": "سورة مريم", "path": "quran-1.mp3"},
    {"name": "سورة الحجر", "path": "quran-2.mp3"},
    {"name": "سورة الفاتحة", "path": "quran-3.mp3"},
    {"name": "سورة البقرة", "path": "quran-4.mp3"},
    {"name": "سورة آل عمران", "path": "quran-5.mp3"},
    {"name": "سورة النساء", "path": "quran-6.mp3"},
    {"name": "سورة المائدة", "path": "quran-7.mp3"},
    {"name": "سورة الأنعام", "path": "quran-8.mp3"},
    {"name": "سورة الأعراف", "path": "quran-9.mp3"},
    {"name": "سورة الأنفال", "path": "quran-10.mp3"},
    {"name": "سورة التوبة", "path": "quran-11.mp3"},
    {"name": "سورة يونس", "path": "quran-12.mp3"},
    {"name": "سورة هود", "path": "quran-13.mp3"},
  ];

  @override
  void initState() {
    super.initState();

    // مراقبة تغييرات الموقع الحالي
    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _currentPositions[_currentSurah] = position;
      });
    });

    // مراقبة تغييرات مدة الملف الصوتي
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _totalDurations[_currentSurah] = duration;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose(); // تأكد من تفريغ المتحكم عند التخلص من الصفحة
    super.dispose();
  }

  void _toggleAudio(String surahPath) async {
    if (_isPlaying && _currentSurah == surahPath) {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      if (_isPlaying) {
        await _audioPlayer.stop();
      }
      await _audioPlayer.play(AssetSource(surahPath));
      setState(() {
        _isPlaying = true;
        _currentSurah = surahPath;
      });

      // احصل على مدة السورة بعد فترة قصيرة من بدء التشغيل
      Duration? duration = await _audioPlayer.getDuration();
      if (duration != null) {
        setState(() {
          _totalDurations[surahPath] = duration; // قم بتخزين المدة
        });
      }
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

  ListTile addSurah(String surahName, String surahPath) {
    Duration currentPosition = _currentPositions[surahPath] ?? Duration.zero;
    Duration totalDuration = _totalDurations[surahPath] ?? Duration.zero;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      leading: const CircleAvatar(
        backgroundImage: AssetImage("images/bander.webp"), // صورة القارئ
        radius: 50,
      ),
      title: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // محاذاة العمود إلى اليسار
        children: [
          Text(
            surahName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Changa",
            ),
          ),
          const SizedBox(height: 4), // مسافة تفصل بين الاسم واسم القارئ
          Text(
            "- بندر بليلة", // اسم القارئ
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: "Changa",
            ),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Slider(
            value: currentPosition.inSeconds.toDouble(),
            min: 0.0,
            max: totalDuration.inSeconds > 0
                ? totalDuration.inSeconds.toDouble()
                : 1.0,
            onChanged: (value) {
              _audioPlayer.seek(Duration(seconds: value.toInt()));
            },
          ),
          Text(
            '${_formatDuration(currentPosition)} / ${_formatDuration(totalDuration)}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              _isPlaying && _currentSurah == surahPath
                  ? Icons.pause
                  : Icons.play_arrow,
              color: Colors.green,
              size: 30,
            ),
            onPressed: () => _toggleAudio(surahPath),
          ),
          IconButton(
            icon: const Icon(
              Icons.replay,
              color: Colors.blue,
              size: 30,
            ),
            onPressed: () => _restartAudio(surahPath),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    // تصفية السور بناءً على نص البحث
    final filteredSurahs = _surahs.where((surah) {
      return surah["name"]!.contains(_searchText);
    }).toList();

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
            // شريط البحث
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                textDirection: TextDirection.rtl, // ضبط اتجاه النص
                textAlign: TextAlign.right, // محاذاة النص إلى اليمين
                decoration: InputDecoration(
                  labelText: 'ابحث عن سورة',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchText = value; // تحديث نص البحث
                  });
                },
              ),
            ),
            // قائمة السور المتبقية
            Expanded(
              child: ListView.builder(
                itemCount: filteredSurahs.length,
                itemBuilder: (context, index) {
                  final surah = filteredSurahs[index];
                  return Column(
                    children: [
                      addSurah(surah["name"]!, surah["path"]!),
                      const Divider(thickness: 3, color: Colors.black),
                    ],
                  );
                },
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
  Map<String, Duration> _currentPositions = {};
  Map<String, Duration> _totalDurations = {};

  // متغير لتخزين نص البحث
  String _searchText = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _surahs = [
    {"name": "سورة مريم", "path": "quran-1.mp3"},
    {"name": "سورة الحجر", "path": "quran-2.mp3"},
    {"name": "سورة الفاتحة", "path": "quran-3.mp3"},
    {"name": "سورة البقرة", "path": "quran-4.mp3"},
    {"name": "سورة آل عمران", "path": "quran-5.mp3"},
    {"name": "سورة النساء", "path": "quran-6.mp3"},
    {"name": "سورة المائدة", "path": "quran-7.mp3"},
    {"name": "سورة الأنعام", "path": "quran-8.mp3"},
    {"name": "سورة الأعراف", "path": "quran-9.mp3"},
    {"name": "سورة الأنفال", "path": "quran-10.mp3"},
    {"name": "سورة التوبة", "path": "quran-11.mp3"},
    {"name": "سورة يونس", "path": "quran-12.mp3"},
    {"name": "سورة هود", "path": "quran-13.mp3"},
  ];

  @override
  void initState() {
    super.initState();

    // مراقبة تغييرات الموقع الحالي
    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _currentPositions[_currentSurah] = position;
      });
    });

    // مراقبة تغييرات مدة الملف الصوتي
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _totalDurations[_currentSurah] = duration;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose(); // تأكد من تفريغ المتحكم عند التخلص من الصفحة
    super.dispose();
  }

  void _toggleAudio(String surahPath) async {
    if (_isPlaying && _currentSurah == surahPath) {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      if (_isPlaying) {
        await _audioPlayer.stop();
      }
      await _audioPlayer.play(AssetSource(surahPath));
      setState(() {
        _isPlaying = true;
        _currentSurah = surahPath;
      });

      // احصل على مدة السورة بعد فترة قصيرة من بدء التشغيل
      Duration? duration = await _audioPlayer.getDuration();
      if (duration != null) {
        setState(() {
          _totalDurations[surahPath] = duration; // قم بتخزين المدة
        });
      }
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

  ListTile addSurah(String surahName, String surahPath) {
    Duration currentPosition = _currentPositions[surahPath] ?? Duration.zero;
    Duration totalDuration = _totalDurations[surahPath] ?? Duration.zero;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      leading: const CircleAvatar(
        backgroundImage: AssetImage("images/ali.jpg"), // صورة القارئ
        radius: 50,
      ),
      title: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // محاذاة العمود إلى اليسار
        children: [
          Text(
            surahName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Changa",
            ),
          ),
          const SizedBox(height: 4), // مسافة تفصل بين الاسم واسم القارئ
          Text(
            "- علي جابر" ,// اسم القارئ
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: "Changa",
            ),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Slider(
            value: currentPosition.inSeconds.toDouble(),
            min: 0.0,
            max: totalDuration.inSeconds > 0
                ? totalDuration.inSeconds.toDouble()
                : 1.0,
            onChanged: (value) {
              _audioPlayer.seek(Duration(seconds: value.toInt()));
            },
          ),
          Text(
            '${_formatDuration(currentPosition)} / ${_formatDuration(totalDuration)}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              _isPlaying && _currentSurah == surahPath
                  ? Icons.pause
                  : Icons.play_arrow,
              color: Colors.green,
              size: 30,
            ),
            onPressed: () => _toggleAudio(surahPath),
          ),
          IconButton(
            icon: const Icon(
              Icons.replay,
              color: Colors.blue,
              size: 30,
            ),
            onPressed: () => _restartAudio(surahPath),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    // تصفية السور بناءً على نص البحث
    final filteredSurahs = _surahs.where((surah) {
      return surah["name"]!.contains(_searchText);
    }).toList();

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
            // شريط البحث
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                textDirection:
                    TextDirection.rtl, // ضبط اتجاه النص ليكون من اليمين لليسار
                textAlign: TextAlign.right, // محاذاة النص إلى اليمين
                decoration: InputDecoration(
                  labelText: 'ابحث عن سورة',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchText = value; // تحديث نص البحث
                  });
                },
              ),
            ),
            // قائمة السور المتبقية
            Expanded(
              child: ListView.builder(
                itemCount: filteredSurahs.length,
                itemBuilder: (context, index) {
                  final surah = filteredSurahs[index];
                  return Column(
                    children: [
                      addSurah(surah["name"]!, surah["path"]!),
                      const Divider(thickness: 3, color: Colors.black),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
