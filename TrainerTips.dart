import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrainerTipsPage extends StatefulWidget {
  const TrainerTipsPage({super.key});

  @override
  State<TrainerTipsPage> createState() => _TrainerTipsPageState();
}

class _TrainerTipsPageState extends State<TrainerTipsPage> {
  String? selectedCategory;
  String searchQuery = '';
  List<String> savedItems = [];

  late YoutubePlayerController _youtubeController;
  final String _currentVideoTitle =
      'EASY WORKOUT AT HOME . 25 MINUTES FULL BODY WORKOUT';

  final List<String> categories = [
    'Meditation',
    'Simple Workout',
    'Meal Plan',
  ];

  final Map<String, List<String>> dummyData = {
    'Meditation': ['Meditation Tip 1', 'Mind Relaxation', 'Deep Breathing'],
    'Simple Workout': ['Pushups', '10 Min Home Workout', 'Stretching'],
    'Meal Plan': ['Healthy Meals', 'Easy Recipes', 'Meal Prep Tips'],
  };

  @override
  void initState() {
    super.initState();
    _youtubeController = YoutubePlayerController(
      initialVideoId: 'cbKkB3POqaY',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
  }

  @override
  void deactivate() {
    _youtubeController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
  }

  void _saveItem(String item) {
    if (!savedItems.contains(item)) {
      setState(() {
        savedItems.add(item);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$item saved!'),
          duration: const Duration(seconds: 1),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Item already saved!', style: TextStyle(color: Colors.white)),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  void _viewSavedItems() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black87,
      builder: (context) => ListView(
        children: savedItems
            .map(
              (item) => ListTile(
                title: Text(item, style: const TextStyle(color: Colors.white)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white70),
                  onPressed: () {
                    setState(() {
                      savedItems.remove(item);
                    });
                    Navigator.pop(context);
                    if (savedItems.isNotEmpty) {
                      _viewSavedItems();
                    }
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(20),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCategory,
                  hint: const Text('Categories',
                      style: TextStyle(color: Colors.white)),
                  dropdownColor: Colors.black87,
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                      searchQuery = '';
                    });
                  },
                  items: categories
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category,
                              style: const TextStyle(color: Colors.white)),
                        ),
                      )
                      .toList(),
                  icon: const Icon(Icons.keyboard_arrow_down,
                      color: Colors.white),
                ),
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: Colors.grey[900],
                    title: const Text('Search Tips',
                        style: TextStyle(color: Colors.white)),
                    content: TextField(
                      style: const TextStyle(color: Colors.white),
                      onChanged: _onSearch,
                      decoration: const InputDecoration(
                        hintText: 'Enter keyword',
                        hintStyle: TextStyle(color: Colors.white54),
                      ),
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.bookmark, color: Colors.white),
              onPressed: _viewSavedItems,
            ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // ✅ Updated Video Player Section with fixed size
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 350,
              height: 200,
              child: YoutubePlayer(
                controller: _youtubeController,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blueAccent,
                onReady: () {},
              ),
            ),
          ),

          // Video Description and Save Button
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _currentVideoTitle,
                    style:
                        const TextStyle(color: Colors.white, fontSize: 16),
                    softWrap: true,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.bookmark_add, color: Colors.white),
                  onPressed: () => _saveItem(_currentVideoTitle),
                ),
              ],
            ),
          ),

          // Fill remaining space
          Expanded(
            child: Container(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
