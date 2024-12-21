import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart'; // استيراد مكتبة provider
import 'ham.dart';


// 1. ThemeNotifier لإدارة حالة الثيم
class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // إشعار المستمعين بتغيير الحالة
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 2. استخدام ThemeNotifier لتحديد الثيم
    final isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;

    return MaterialApp(
      title: 'Quran Recitation',
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "صفحة القراء",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: "Changa",
          ),
        ),
        // Set the AppBar color based on dark mode state
        backgroundColor: themeProvider.isDarkMode
            ? Colors.blue // Blue color in dark mode
            : const Color.fromARGB(255, 255, 255, 255), // White in light mode
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: DrawerMenu(
        toggleTheme: themeProvider.toggleTheme,
        isDarkMode: themeProvider.isDarkMode,
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "اختر قارئًا للاستماع إلى تلاوات القرآن الكريم.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Changa",
                    color: themeProvider.isDarkMode
                        ? Colors.white
                        : const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              const Divider(
                  thickness: 3, color: Color.fromARGB(129, 236, 52, 52)),
              _buildReaderTile(context, "بندر بليلة", "images/bander.webp",
                  QuranPageBander()),
              const Divider(thickness: 3, color: Colors.black),
              _buildReaderTile(context, "علي جابر", "images/ali.jpg",
                  const QuranPageAliJaber()),
              const Divider(thickness: 3, color: Colors.black),
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
                      color: themeProvider.isDarkMode
                          ? Colors.white70
                          : Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => themeProvider.toggleTheme(),
        child: Icon(
          themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
        ),
      ),
    );
  }

  Widget _buildReaderTile(
      BuildContext context, String name, String imagePath, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
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
  @override
  _QuranPageBanderState createState() => _QuranPageBanderState();
}

class _QuranPageBanderState extends State<QuranPageBander> {
  final List<Map<String, String>> _surahs = [
    {"name": "سورة الفاتحة", "path": "assetsBander/001.mp3"},
    {"name": "سورة البقرة", "path": "assetsBander/002.mp3"},
    {"name": "سورة آل عمران", "path": "assetsBander/003.mp3"},
    {"name": "سورة النساء", "path": "assetsBander/004.mp3"},
    {"name": "سورة المائدة", "path": "assetsBander/005.mp3"},
    {"name": "سورة الأنعام", "path": "assetsBander/006.mp3"},
    {"name": "سورة الأعراف", "path": "assetsBander/007.mp3"},
    {"name": "سورة الأنفال", "path": "assetsBander/008.mp3"},
    {"name": "سورة التوبة", "path": "assetsBander/009.mp3"},
    {"name": "سورة يونس", "path": "assetsBander/010.mp3"},
    {"name": "سورة هود", "path": "assetsBander/011.mp3"},
    {"name": "سورة يوسف", "path": "assetsBander/012.mp3"},
    {"name": "سورة الرعد", "path": "assetsBander/013.mp3"},
    {"name": "سورة إبراهيم", "path": "assetsBander/014.mp3"},
    {"name": "سورة الحجر", "path": "assetsBander/015.mp3"},
    {"name": "سورة النحل", "path": "assetsBander/016.mp3"},
    {"name": "سورة الإسراء", "path": "assetsBander/017.mp3"},
    {"name": "سورة الكهف", "path": "assetsBander/018.mp3"},
    {"name": "سورة مريم", "path": "assetsBander/019.mp3"},
    {"name": "سورة طه", "path": "assetsBander/020.mp3"},
    {"name": "سورة الأنبياء", "path": "assetsBander/021.mp3"},
    {"name": "سورة الحج", "path": "assetsBander/022.mp3"},
    {"name": "سورة المؤمنون", "path": "assetsBander/023.mp3"},
    {"name": "سورة النور", "path": "assetsBander/024.mp3"},
    {"name": "سورة الفرقان", "path": "assetsBander/025.mp3"},
    {"name": "سورة الشعراء", "path": "assetsBander/026.mp3"},
    {"name": "سورة النمل", "path": "assetsBander/027.mp3"},
    {"name": "سورة القصص", "path": "assetsBander/028.mp3"},
    {"name": "سورة العنكبوت", "path": "assetsBander/029.mp3"},
    {"name": "سورة الروم", "path": "assetsBander/030.mp3"},
    {"name": "سورة لقمان", "path": "assetsBander/031.mp3"},
    {"name": "سورة السجدة", "path": "assetsBander/032.mp3"},
    {"name": "سورة الأحزاب", "path": "assetsBander/033.mp3"},
    {"name": "سورة سبأ", "path": "assetsBander/034.mp3"},
    {"name": "سورة فاطر", "path": "assetsBander/035.mp3"},
    {"name": "سورة يس", "path": "assetsBander/036.mp3"},
    {"name": "سورة الصافات", "path": "assetsBander/037.mp3"},
    {"name": "سورة ص", "path": "assetsBander/038.mp3"},
    {"name": "سورة الزمر", "path": "assetsBander/039.mp3"},
    {"name": "سورة غافر", "path": "assetsBander/040.mp3"},
    {"name": "سورة فصلت", "path": "assetsBander/041.mp3"},
    {"name": "سورة الشورى", "path": "assetsBander/042.mp3"},
    {"name": "سورة الزخرف", "path": "assetsBander/043.mp3"},
    {"name": "سورة الدخان", "path": "assetsBander/044.mp3"},
    {"name": "سورة الجاثية", "path": "assetsBander/045.mp3"},
    {"name": "سورة الأحقاف", "path": "assetsBander/046.mp3"},
    {"name": "سورة محمد", "path": "assetsBander/047.mp3"},
    {"name": "سورة الفتح", "path": "assetsBander/048.mp3"},
    {"name": "سورة الحجرات", "path": "assetsBander/049.mp3"},
    {"name": "سورة ق", "path": "assetsBander/050.mp3"},
    {"name": "سورة الذاريات", "path": "assetsBander/051.mp3"},
    {"name": "سورة الطور", "path": "assetsBander/052.mp3"},
    {"name": "سورة النجم", "path": "assetsBander/053.mp3"},
    {"name": "سورة القمر", "path": "assetsBander/054.mp3"},
    {"name": "سورة الرحمن", "path": "assetsBander/055.mp3"},
    {"name": "سورة الواقعة", "path": "assetsBander/056.mp3"},
    {"name": "سورة الحديد", "path": "assetsBander/057.mp3"},
    {"name": "سورة المجادلة", "path": "assetsBander/058.mp3"},
    {"name": "سورة الحشر", "path": "assetsBander/059.mp3"},
    {"name": "سورة الممتحنة", "path": "assetsBander/060.mp3"},
    {"name": "سورة الصف", "path": "assetsBander/061.mp3"},
    {"name": "سورة الجمعة", "path": "assetsBander/062.mp3"},
    {"name": "سورة المنافقون", "path": "assetsBander/063.mp3"},
    {"name": "سورة التغابن", "path": "assetsBander/064.mp3"},
    {"name": "سورة الطلاق", "path": "assetsBander/065.mp3"},
    {"name": "سورة التحريم", "path": "assetsBander/066.mp3"},
    {"name": "سورة الملك", "path": "assetsBander/067.mp3"},
    {"name": "سورة القلم", "path": "assetsBander/068.mp3"},
    {"name": "سورة الحاقة", "path": "assetsBander/069.mp3"},
    {"name": "سورة المعارج", "path": "assetsBander/070.mp3"},
    {"name": "سورة نوح", "path": "assetsBander/071.mp3"},
    {"name": "سورة الجن", "path": "assetsBander/072.mp3"},
    {"name": "سورة المزمل", "path": "assetsBander/073.mp3"},
    {"name": "سورة المدثر", "path": "assetsBander/074.mp3"},
    {"name": "سورة القيامة", "path": "assetsBander/075.mp3"},
    {"name": "سورة الإنسان", "path": "assetsBander/076.mp3"},
    {"name": "سورة المرسلات", "path": "assetsBander/077.mp3"},
    {"name": "سورة النبأ", "path": "assetsBander/078.mp3"},
    {"name": "سورة النازعات", "path": "assetsBander/079.mp3"},
    {"name": "سورة عبس", "path": "assetsBander/080.mp3"},
    {"name": "سورة التكوير", "path": "assetsBander/081.mp3"},
    {"name": "سورة الإنفطار", "path": "assetsBander/082.mp3"},
    {"name": "سورة المطففين", "path": "assetsBander/083.mp3"},
    {"name": "سورة الإنشقاق", "path": "assetsBander/084.mp3"},
    {"name": "سورة البروج", "path": "assetsBander/085.mp3"},
    {"name": "سورة الطارق", "path": "assetsBander/086.mp3"},
    {"name": "سورة الأعلى", "path": "assetsBander/087.mp3"},
    {"name": "سورة الغاشية", "path": "assetsBander/088.mp3"},
    {"name": "سورة الفجر", "path": "assetsBander/089.mp3"},
    {"name": "سورة البلد", "path": "assetsBander/090.mp3"},
    {"name": "سورة الشمس", "path": "assetsBander/091.mp3"},
    {"name": "سورة الليل", "path": "assetsBander/092.mp3"},
    {"name": "سورة الضحى", "path": "assetsBander/093.mp3"},
    {"name": "سورة الشرح", "path": "assetsBander/094.mp3"},
    {"name": "سورة التين", "path": "assetsBander/095.mp3"},
    {"name": "سورة العلق", "path": "assetsBander/096.mp3"},
    {"name": "سورة القدر", "path": "assetsBander/097.mp3"},
    {"name": "سورة البينة", "path": "assetsBander/098.mp3"},
    {"name": "سورة الزلزلة", "path": "assetsBander/099.mp3"},
    {"name": "سورة العاديات", "path": "assetsBander/100.mp3"},
    {"name": "سورة القارعة", "path": "assetsBander/101.mp3"},
    {"name": "سورة التكاثر", "path": "assetsBander/102.mp3"},
    {"name": "سورة العصر", "path": "assetsBander/103.mp3"},
    {"name": "سورة الهمزة", "path": "assetsBander/104.mp3"},
    {"name": "سورة الفيل", "path": "assetsBander/105.mp3"},
    {"name": "سورة قريش", "path": "assetsBander/106.mp3"},
    {"name": "سورة الماعون", "path": "assetsBander/107.mp3"},
    {"name": "سورة الكوثر", "path": "assetsBander/108.mp3"},
    {"name": "سورة الكافرون", "path": "assetsBander/109.mp3"},
    {"name": "سورة النصر", "path": "assetsBander/110.mp3"},
    {"name": "سورة المسد", "path": "assetsBander/111.mp3"},
    {"name": "سورة الإخلاص", "path": "assetsBander/112.mp3"},
    {"name": "سورة الفلق", "path": "assetsBander/113.mp3"},
    {"name": "سورة الناس", "path": "assetsBander/114.mp3"},
  ];
  // متغير لتخزين نص البحث
  String _searchText = '';
  final TextEditingController _searchController = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  String _currentSurah = '';
  Map<String, Duration> _currentPositions = {};
  Map<String, Duration> _totalDurations = {};

  // متغير لتخزين حالة الوضع (Dark/Light)
  @override
  void initState() {
    super.initState();
    _audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        _currentPositions[_currentSurah] = position;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose(); // تأكد من تفريغ المتحكم عند التخلص من الصفحة
    super.dispose();
  }

  void _toggleAudio(String surahPath) async {
    try {
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
    } catch (e) {
      print('Error occurred: $e');
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
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      leading: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: const CircleAvatar(
          backgroundImage: AssetImage("images/bander.webp"), // صورة القارئ
          radius: 50,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  surahName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Changa",
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors
                            .black, // التبديل بين الأبيض والأسود بناءً على الثيم
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "- بندر بليلة", // اسم القارئ
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontFamily: "Changa",
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white70
                        : Colors
                            .black87, // التبديل بين الأبيض والأسود بناءً على الثيم
                  ),
                ),
              ],
            ),
          ),
          Row(
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
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Slider(
            value: _currentPositions[surahPath]?.inSeconds.toDouble() ?? 0.0,
            max: _totalDurations[surahPath]?.inSeconds.toDouble() ?? 1.0,
            onChanged: (double value) async {
              final position = Duration(seconds: value.toInt());
              await _audioPlayer.seek(position);
              setState(() {
                _currentPositions[surahPath] =
                    position; // تحديث السورة المعينة فقط
              });
            },
          ),
          Text(
            '${_formatDuration(currentPosition)} / ${_formatDuration(totalDuration)}',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white70
                  : Colors
                      .black87, // التبديل بين الأبيض والأسود بناءً على الثيم
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds'; // عرض الساعات أيضًا
  }

  @override
  Widget build(BuildContext context) {
    final filteredSurahs = _surahs.where((surah) {
      return surah["name"]!.contains(_searchText);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.blue
            : null, // الأزرق للوضع المظلم، والافتراضي للوضع الفاتح
        title: Text(
          "Quran Recitation - بندر بليلة",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: "Changa",
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              context.watch<ThemeNotifier>().isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              context
                  .read<ThemeNotifier>()
                  .toggleTheme(); // التبديل بين الوضعين
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: 'ابحث عن سورة',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchText = value;
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredSurahs.length,
                itemBuilder: (context, index) {
                  final surah = filteredSurahs[index];
                  return addSurah(surah["name"]!, surah["path"]!);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ThemeNotifier>().toggleTheme(); // التبديل بين الوضعين
        },
        child: Icon(
          context.watch<ThemeNotifier>().isDarkMode
              ? Icons.wb_sunny
              : Icons.nights_stay,
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
  final List<Map<String, String>> _surahs = [
    {
      "name": "سورة الفاتحة",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-001.ogg"
    },
    {
      "name": "سورة البقرة",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-002.ogg"
    },
    {
      "name": "سورة آل عمران",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-003.ogg"
    },
    {
      "name": "سورة النساء",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-004.ogg"
    },
    {
      "name": "سورة المائدة",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-005.ogg"
    },
    {
      "name": "سورة الأنعام",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-006.ogg"
    },
    {
      "name": "سورة الأعراف",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-007.ogg"
    },
    {
      "name": "سورة الأنفال",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-008.ogg"
    },
    {
      "name": "سورة التوبة",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-009.ogg"
    },
    {
      "name": "سورة يونس",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-010.ogg"
    },
    {
      "name": "سورة هود",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-011.ogg"
    },
    {
      "name": "سورة يوسف",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-012.ogg"
    },
    {
      "name": "سورة الرعد",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-013.ogg"
    },
    {
      "name": "سورة إبراهيم",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-014.ogg"
    },
    {
      "name": "سورة الحجر",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-015.ogg"
    },
    {
      "name": "سورة النحل",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-016.ogg"
    },
    {
      "name": "سورة الإسراء",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-017.ogg"
    },
    {
      "name": "سورة الكهف",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-018.ogg"
    },
    {
      "name": "سورة مريم",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-019.ogg"
    },
    {
      "name": "سورة طه",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-020.ogg"
    },
    {
      "name": "سورة الأنبياء",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-021.ogg"
    },
    {
      "name": "سورة الحج",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-022.ogg"
    },
    {
      "name": "سورة المؤمنون",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-023.ogg"
    },
    {
      "name": "سورة النور",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-024.ogg"
    },
    {
      "name": "سورة الفرقان",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-025.ogg"
    },
    {
      "name": "سورة الشعراء",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-026.ogg"
    },
    {
      "name": "سورة النمل",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-027.ogg"
    },
    {
      "name": "سورة القصص",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-028.ogg"
    },
    {
      "name": "سورة العنكبوت",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-029.ogg"
    },
    {
      "name": "سورة الروم",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-030.ogg"
    },
    {
      "name": "سورة لقمان",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-031.ogg"
    },
    {
      "name": "سورة السجدة",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-032.ogg"
    },
    {
      "name": "سورة الأحزاب",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-033.ogg"
    },
    {
      "name": "سورة سبأ",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-034.ogg"
    },
    {
      "name": "سورة فاطر",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-035.ogg"
    },
    {
      "name": "سورة يس",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-036.ogg"
    },
    {
      "name": "سورة الصافات",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-037.ogg"
    },
    {
      "name": "سورة ص",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-038.ogg"
    },
    {
      "name": "سورة الزمر",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-039.ogg"
    },
    {
      "name": "سورة غافر",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-040.ogg"
    },
    {
      "name": "سورة فصلت",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-041.ogg"
    },
    {
      "name": "سورة الشورى",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-042.ogg"
    },
    {
      "name": "سورة الزخرف",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-043.ogg"
    },
    {
      "name": "سورة الدخان",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-044.ogg"
    },
    {
      "name": "سورة الجاثية",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-045.ogg"
    },
    {
      "name": "سورة الأحقاف",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-046.ogg"
    },
    {
      "name": "سورة محمد",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-047.ogg"
    },
    {
      "name": "سورة الفتح",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-048.ogg"
    },
    {
      "name": "سورة الحجرات",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-049.ogg"
    },
    {
      "name": "سورة ق",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-050.ogg"
    },
    {
      "name": "سورة الذاريات",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-051.ogg"
    },
    {
      "name": "سورة الطور",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-052.ogg"
    },
    {
      "name": "سورة النجم",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-053.ogg"
    },
    {
      "name": "سورة القمر",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-054.ogg"
    },
    {
      "name": "سورة الرحمن",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-055.ogg"
    },
    {
      "name": "سورة الواقعة",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-056.ogg"
    },
    {
      "name": "سورة الحديد",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-057.ogg"
    },
    {
      "name": "سورة المجادلة",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-058.ogg"
    },
    {
      "name": "سورة الحشر",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-059.ogg"
    },
    {
      "name": "سورة الممتحنة",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-060.ogg"
    },
    {
      "name": "سورة الصف",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-061.ogg"
    },
    {
      "name": "سورة الجمعة",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-062.ogg"
    },
    {
      "name": "سورة المنافقون",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-063.ogg"
    },
    {
      "name": "سورة التغابن",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-064.ogg"
    },
    {
      "name": "سورة الطلاق",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-065.ogg"
    },
    {
      "name": "سورة التحريم",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-066.ogg"
    },
    {
      "name": "سورة الملك",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-067.ogg"
    },
    {
      "name": "سورة القلم",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-068.ogg"
    },
    {
      "name": "سورة الحاقة",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-069.ogg"
    },
    {
      "name": "سورة المعارج",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-070.ogg"
    },
    {
      "name": "سورة نوح",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-071.ogg"
    },
    {
      "name": "سورة الجن",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-072.ogg"
    },
    {
      "name": "سورة المزمل",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-073.ogg"
    },
    {
      "name": "سورة المدثر",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-074.ogg"
    },
    {
      "name": "سورة القيامة",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-075.ogg"
    },
    {
      "name": "سورة الإنسان",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-076.ogg"
    },
    {
      "name": "سورة المرسلات",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-077.ogg"
    },
    {
      "name": "سورة النبأ",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-078.ogg"
    },
    {
      "name": "سورة النازعات",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-079.ogg"
    },
    {
      "name": "سورة عبس",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-080.ogg"
    },
    {
      "name": "سورة التكوير",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-081.ogg"
    },
    {
      "name": "سورة الإنفطار",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-082.ogg"
    },
    {
      "name": "سورة المطففين",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-083.ogg"
    },
    {
      "name": "سورة الإنشقاق",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-084.ogg"
    },
    {
      "name": "سورة البروج",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-085.ogg"
    },
    {
      "name": "سورة الطارق",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-086.ogg"
    },
    {
      "name": "سورة الأعلى",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-087.ogg"
    },
    {
      "name": "سورة الغاشية",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-088.ogg"
    },
    {
      "name": "سورة الفجر",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-089.ogg"
    },
    {
      "name": "سورة البلد",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-090.ogg"
    },
    {
      "name": "سورة الشمس",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-091.ogg"
    },
    {
      "name": "سورة الليل",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-092.ogg"
    },
    {
      "name": "سورة الضحى",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-093.ogg"
    },
    {
      "name": "سورة الشرح",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-094.ogg"
    },
    {
      "name": "سورة التين",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-095.ogg"
    },
    {
      "name": "سورة العلق",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-096.ogg"
    },
    {
      "name": "سورة القدر",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-097.ogg"
    },
    {
      "name": "سورة البينة",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-098.ogg"
    },
    {
      "name": "سورة الزلزلة",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-099.ogg"
    },
    {
      "name": "سورة العاديات",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-100.ogg"
    },
    {
      "name": "سورة القارعة",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-101.ogg"
    },
    {
      "name": "سورة التكاثر",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-102.ogg"
    },
    {
      "name": "سورة العصر",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-103.ogg"
    },
    {
      "name": "سورة الهمزة",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-104.ogg"
    },
    {
      "name": "سورة الفيل",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-105.ogg"
    },
    {
      "name": "سورة قريش",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-106.ogg"
    },
    {
      "name": "سورة الماعون",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-107.ogg"
    },
    {
      "name": "سورة الكوثر",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-108.ogg"
    },
    {
      "name": "سورة الكافرون",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-109.ogg"
    },
    {
      "name": "سورة النصر",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-110.ogg"
    },
    {
      "name": "سورة المسد",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-111.ogg"
    },
    {
      "name": "سورة الإخلاص",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-112.ogg"
    },
    {
      "name": "سورة الفلق",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-113.ogg"
    },
    {
      "name": "سورة الناس",
      "path": "assetsAli/compressed_Quran_Ali_Jaber_studio-114.ogg"
    },
  ];
  // متغير لتخزين نص البحث
  String _searchText = '';
  final TextEditingController _searchController = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  String _currentSurah = '';
  Map<String, Duration> _currentPositions = {};
  Map<String, Duration> _totalDurations = {};

  // متغير لتخزين حالة الوضع (Dark/Light)
  @override
  void initState() {
    super.initState();
    _audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        _currentPositions[_currentSurah] = position;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose(); // تأكد من تفريغ المتحكم عند التخلص من الصفحة
    super.dispose();
  }

  void _toggleAudio(String surahPath) async {
    try {
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
    } catch (e) {
      print('Error occurred: $e');
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
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      leading: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: const CircleAvatar(
          backgroundImage: AssetImage("images/ali.jpg"), // صورة القارئ
          radius: 50,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  surahName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Changa",
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors
                            .black, // التبديل بين الأبيض والأسود بناءً على الثيم
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "- علي جابر", // اسم القارئ
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontFamily: "Changa",
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white70
                        : Colors
                            .black87, // التبديل بين الأبيض والأسود بناءً على الثيم
                  ),
                ),
              ],
            ),
          ),
          Row(
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
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Slider(
            value: _currentPositions[surahPath]?.inSeconds.toDouble() ?? 0.0,
            max: _totalDurations[surahPath]?.inSeconds.toDouble() ?? 1.0,
            onChanged: (double value) async {
              final position = Duration(seconds: value.toInt());
              await _audioPlayer.seek(position);
              setState(() {
                _currentPositions[surahPath] =
                    position; // تحديث السورة المعينة فقط
              });
            },
          ),
          Text(
            '${_formatDuration(currentPosition)} / ${_formatDuration(totalDuration)}',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white70
                  : Colors
                      .black87, // التبديل بين الأبيض والأسود بناءً على الثيم
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds'; // عرض الساعات أيضًا
  }

  @override
  Widget build(BuildContext context) {
    final filteredSurahs = _surahs.where((surah) {
      return surah["name"]!.contains(_searchText);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.blue
            : null, // إذا كان الوضع الداكن مفعلًا، يصبح اللون أزرق، وإلا يكون اللون الافتراضي
        title: Text(
          "Quran Recitation - علي جابر",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: "Changa",
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              context.watch<ThemeNotifier>().isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              context
                  .read<ThemeNotifier>()
                  .toggleTheme(); // التبديل بين الوضعين
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: 'ابحث عن سورة',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchText = value;
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredSurahs.length,
                itemBuilder: (context, index) {
                  final surah = filteredSurahs[index];
                  return addSurah(surah["name"]!, surah["path"]!);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ThemeNotifier>().toggleTheme(); // التبديل بين الوضعين
        },
        child: Icon(
          context.watch<ThemeNotifier>().isDarkMode
              ? Icons.wb_sunny
              : Icons.nights_stay,
        ),
      ),
    );
  }
}
