import 'package:flutter/material.dart';

class MorningCheckInPage extends StatefulWidget {
  const MorningCheckInPage({Key? key}) : super(key: key);

  @override
  State<MorningCheckInPage> createState() => _MorningCheckInPageState();
}

class _MorningCheckInPageState extends State<MorningCheckInPage> {
  final TextEditingController _feelingController = TextEditingController();
  final TextEditingController _expectationController = TextEditingController();

  double _dayScore = 7.0;
  String? _selectedMood;

  final List<Map<String, dynamic>> _moodTags = [
    {'icon': Icons.wb_sunny, 'label': 'Hopeful', 'color': Colors.amber},
    {'icon': Icons.water_drop, 'label': 'Calm', 'color': Colors.lightBlue},
    {'icon': Icons.bolt, 'label': 'Anxious', 'color': Colors.red},
    {'icon': Icons.bedtime, 'label': 'Tired', 'color': Colors.purple},
  ];

  @override
  void dispose() {
    _feelingController.dispose();
    _expectationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDark ? const Color(0xFF1A100C) : const Color(0xFFFFF5F0),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
          color: isDark ? const Color(0xFFF0E6E1) : const Color(0xFF1A100C),
        ),
        title: Text(
          'Morning Check-in',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark ? const Color(0xFFF0E6E1) : const Color(0xFF1A100C),
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Save',
              style: TextStyle(
                color: Color(0xFFFF9F43),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: isDark ? const Color(0xFF1A100C) : const Color(0xFFFFF5F0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Image Section
              Container(
                margin: const EdgeInsets.all(16),
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuA_1u4BtXzJqeK4LepAi61OYRbciDHYsvZlqAI4Nvn6Q7li3vPf0L_Kxdan-3hN5SZdSz2baOWfAzRyRDw5iVyg_774IpVuhd0SReZ7ZXum2cDdIt6lIEYhAYMaw4GeYtUprJCiKqPlIN7vUaXS_8bXc_90IrjJOrh_bjhL9E4wsHRUxqY6SsztXPUtdye5OLc-CNLz2ZeQsYUsJaHKcYH3KykxIfezaKpv6CGVrTn6nHzuDFFQSvi090JldUmbarrGbfZcRD6jtzfN',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Oct 24, 2023',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: const Color(0xFFFF9F43),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Good Morning',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Start your day with intention.',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Feeling Section
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'How are you feeling right now?',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: isDark ? const Color(0xFFF0E6E1) : const Color(0xFF1A100C),
                    ),
                  ),
                ),
              ),

              // Feeling Text Input
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: _feelingController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'I\'m feeling calm but a bit sleepy...',
                    hintStyle: TextStyle(
                      color: isDark
                          ? const Color(0xFFF0E6E1).withOpacity(0.4)
                          : const Color(0xFF1A100C).withOpacity(0.4),
                    ),
                    filled: true,
                    fillColor: isDark ? const Color(0xFF2A1D18) : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  style: TextStyle(
                    color: isDark ? const Color(0xFFF0E6E1) : const Color(0xFF1A100C),
                  ),
                ),
              ),

              // Mood Tags
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _moodTags.map((mood) {
                      final isSelected = _selectedMood == mood['label'];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedMood = selected ? mood['label'] : null;
                            });
                          },
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                mood['icon'],
                                size: 18,
                                color: mood['color'],
                              ),
                              const SizedBox(width: 6),
                              Text(mood['label']),
                            ],
                          ),
                          backgroundColor: isDark ? const Color(0xFF2A1D18) : Colors.white,
                          side: BorderSide(
                            color: isSelected
                                ? const Color(0xFFFF9F43)
                                : (isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1)),
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              // Expectation Section
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Main expectation for today',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: isDark ? const Color(0xFFF0E6E1) : const Color(0xFF1A100C),
                    ),
                  ),
                ),
              ),

              // Expectation Text Input
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: _expectationController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'I expect to finish my project and go for a run...',
                    hintStyle: TextStyle(
                      color: isDark
                          ? const Color(0xFFF0E6E1).withOpacity(0.4)
                          : const Color(0xFF1A100C).withOpacity(0.4),
                    ),
                    filled: true,
                    fillColor: isDark ? const Color(0xFF2A1D18) : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  style: TextStyle(
                    color: isDark ? const Color(0xFFF0E6E1) : const Color(0xFF1A100C),
                  ),
                ),
              ),

              // Day Score Slider
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF2A1D18) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Initial Day Score',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isDark ? const Color(0xFFF0E6E1) : const Color(0xFF1A100C),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF9F43).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            child: Text(
                              '${_dayScore.toInt()} / 10',
                              style: const TextStyle(
                                color: Color(0xFFFF9F43),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 4,
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 12,
                            elevation: 4,
                          ),
                          overlayShape: const RoundSliderOverlayShape(
                            overlayRadius: 14,
                          ),
                        ),
                        child: Slider(
                          value: _dayScore,
                          min: 1,
                          max: 10,
                          activeColor: const Color(0xFFFF9F43),
                          inactiveColor: Colors.grey.withOpacity(0.3),
                          onChanged: (value) {
                            setState(() {
                              _dayScore = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rough start',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? const Color(0xFFF0E6E1).withOpacity(0.5)
                                  : const Color(0xFF1A100C).withOpacity(0.5),
                            ),
                          ),
                          Text(
                            'Amazing',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? const Color(0xFFF0E6E1).withOpacity(0.5)
                                  : const Color(0xFF1A100C).withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Complete Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle completion
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Check-in completed!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF9F43),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 8,
                      shadowColor: const Color(0xFFFF9F43).withOpacity(0.4),
                    ),
                    child: Text(
                      'Complete Check-in',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF4d2e0b),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
