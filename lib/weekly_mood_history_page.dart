import 'package:flutter/material.dart';

class WeeklyMoodHistoryPage extends StatefulWidget {
  const WeeklyMoodHistoryPage({Key? key}) : super(key: key);

  @override
  State<WeeklyMoodHistoryPage> createState() => _WeeklyMoodHistoryPageState();
}

class _WeeklyMoodHistoryPageState extends State<WeeklyMoodHistoryPage> {
  String _selectedFilter = 'last7days';

  final List<Map<String, dynamic>> _moodData = [
    {
      'day': 'Monday, Oct 23',
      'label': 'Yesterday',
      'description': 'Morning optimism met evening contentment. A balanced day overall.',
      'morningScore': 7.5,
      'eveningScore': 8.2,
      'trend': 'up',
      'hasInsights': true,
    },
    {
      'day': 'Sunday, Oct 22',
      'description': 'Started neutral but energy dipped. Evening reflection highlighted fatigue.',
      'morningScore': 6.0,
      'eveningScore': 4.5,
      'trend': 'down',
      'hasInsights': false,
    },
    {
      'day': 'Saturday, Oct 21',
      'description': 'High energy morning sustained throughout. Great social interactions.',
      'morningScore': 8.0,
      'eveningScore': 8.5,
      'trend': 'up',
      'hasInsights': false,
    },
    {
      'day': 'Friday, Oct 20',
      'description': 'Steady focus at work. Relaxing evening with no major mood swings.',
      'morningScore': 7.0,
      'eveningScore': 7.1,
      'trend': 'flat',
      'hasInsights': false,
    },
    {
      'day': 'Thursday, Oct 19',
      'description': 'Woke up anxious but solved key problems by noon. Strong finish.',
      'morningScore': 5.5,
      'eveningScore': 8.0,
      'trend': 'up',
      'hasInsights': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF102215) : const Color(0xFFF6F8F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDark ? const Color(0xFF102215).withOpacity(0.95) : const Color(0xFFF6F8F6).withOpacity(0.95),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
          color: isDark ? Colors.white : Colors.black87,
        ),
        title: Text(
          'Weekly History',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  _buildFilterChip(
                    label: 'Last 7 Days',
                    value: 'last7days',
                    isSelected: _selectedFilter == 'last7days',
                    isDark: isDark,
                  ),
                  const SizedBox(width: 12),
                  _buildFilterChip(
                    label: 'Last 30 Days',
                    value: 'last30days',
                    isSelected: _selectedFilter == 'last30days',
                    isDark: isDark,
                  ),
                  const SizedBox(width: 12),
                  _buildFilterChip(
                    label: 'All Time',
                    value: 'alltime',
                    isSelected: _selectedFilter == 'alltime',
                    isDark: isDark,
                  ),
                ],
              ),
            ),
          ),

          // Weekly Summary List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _moodData.length,
              itemBuilder: (context, index) {
                final dayData = _moodData[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: dayData['hasInsights'] == true
                      ? _buildInsightCard(dayData, isDark)
                      : _buildMoodCard(dayData, isDark),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required String value,
    required bool isSelected,
    required bool isDark,
  }) {
    return FilterChip(
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = value;
        });
      },
      label: Text(label),
      backgroundColor: isSelected
          ? const Color(0xFF13ec49)
          : (isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1)),
      labelStyle: TextStyle(
        color: isSelected
            ? const Color(0xFF102215)
            : (isDark ? Colors.grey[300] : Colors.grey[600]),
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      side: BorderSide.none,
    );
  }

  Widget _buildInsightCard(Map<String, dynamic> data, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1c2e21) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[200]!,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Trend Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF13ec49).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.trending_up,
                    color: const Color(0xFF13ec49),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            data['day'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          Text(
                            data['label'] ?? '',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.grey[500] : Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data['description'],
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.grey[300] : Colors.grey[600],
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Scores
                      Row(
                        children: [
                          _buildScoreDisplay(
                            icon: Icons.wb_sunny,
                            score: data['morningScore'].toString(),
                            isDark: isDark,
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 1,
                            height: 18,
                            color: isDark
                                ? Colors.white.withOpacity(0.2)
                                : Colors.grey[300],
                          ),
                          const SizedBox(width: 12),
                          _buildScoreDisplay(
                            icon: Icons.bedtime,
                            score: data['eveningScore'].toString(),
                            isDark: isDark,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // View Insights Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Showing insights...'),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF13ec49),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.insights,
                                color: const Color(0xFF102215),
                                size: 18,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'View Insights',
                                style: TextStyle(
                                  color: const Color(0xFF102215),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodCard(Map<String, dynamic> data, bool isDark) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Showing details for ${data['day']}')),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1c2e21) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[200]!,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Trend Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getTrendColor(data['trend']).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getTrendIcon(data['trend']),
                  color: _getTrendColor(data['trend']),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['day'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      data['description'],
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Scores
                    Row(
                      children: [
                        _buildScoreDisplay(
                          icon: Icons.wb_sunny,
                          score: data['morningScore'].toString(),
                          isDark: isDark,
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 1,
                          height: 18,
                          color: isDark
                              ? Colors.white.withOpacity(0.2)
                              : Colors.grey[300],
                        ),
                        const SizedBox(width: 12),
                        _buildScoreDisplay(
                          icon: Icons.bedtime,
                          score: data['eveningScore'].toString(),
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Chevron
              Icon(
                Icons.chevron_right,
                color: isDark ? Colors.grey[600] : Colors.grey[300],
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreDisplay({
    required IconData icon,
    required String score,
    required bool isDark,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: isDark ? Colors.grey[400] : Colors.grey[500],
        ),
        const SizedBox(width: 6),
        Text(
          score,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.grey[200] : Colors.grey[700],
          ),
        ),
      ],
    );
  }

  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case 'up':
        return Icons.trending_up;
      case 'down':
        return Icons.trending_down;
      case 'flat':
        return Icons.trending_flat;
      default:
        return Icons.trending_flat;
    }
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case 'up':
        return const Color(0xFF13ec49);
      case 'down':
        return Colors.grey[500]!;
      case 'flat':
        return Colors.grey[500]!;
      default:
        return Colors.grey[500]!;
    }
  }
}
