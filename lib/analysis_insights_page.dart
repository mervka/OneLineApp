import 'package:flutter/material.dart';

class AnalysisInsightsPage extends StatefulWidget {
  const AnalysisInsightsPage({Key? key}) : super(key: key);

  @override
  State<AnalysisInsightsPage> createState() => _AnalysisInsightsPageState();
}

class _AnalysisInsightsPageState extends State<AnalysisInsightsPage> {
  final TextEditingController _reflectionController = TextEditingController();
  final List<String> _selectedTags = [];

  final List<String> _suggestedTags = [
    'Productive Work',
    'Good Sleep',
    'Socializing',
    'Exercise',
    'Meditation',
  ];

  double morningScore = 6.0;
  double eveningScore = 8.5;

  @override
  void dispose() {
    _reflectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scoreDifference = eveningScore - morningScore;
    final percentageChange = (scoreDifference / morningScore * 100).toStringAsFixed(0);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF102215) : const Color(0xFFF6F8F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDark ? const Color(0xFF102215) : const Color(0xFFF6F8F6),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: isDark ? Colors.white : Colors.black,
        ),
        title: Text(
          'Insight',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Insight saved!')),
                  );
                },
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Color(0xFF13ec49),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.015,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // Headline
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Score Change Detected',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 28,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 8),

            // Body Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'There was a significant positive shift between your morning expectation and evening reflection.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark ? Colors.grey[300] : Colors.grey[600],
                  fontSize: 16,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 24),

            // Chart Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1a2e1f) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(0.05)
                        : Colors.grey[200]!,
                  ),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with Score Gap and Percentage
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Daily Score Gap',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: isDark
                                    ? Colors.grey[400]
                                    : Colors.grey[500],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '+${scoreDifference.toStringAsFixed(1)}',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF13ec49).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.trending_up,
                                color: const Color(0xFF13ec49),
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '+$percentageChange%',
                                style: const TextStyle(
                                  color: Color(0xFF13ec49),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Bar Chart
                    SizedBox(
                      height: 220,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Morning Bar
                          _buildChartBar(
                            label: 'Morning',
                            score: morningScore,
                            maxScore: 10,
                            color: isDark ? Colors.grey[600]! : Colors.grey[300]!,
                            isDark: isDark,
                          ),

                          // Evening Bar
                          _buildChartBar(
                            label: 'Evening',
                            score: eveningScore,
                            maxScore: 10,
                            color: const Color(0xFF13ec49),
                            isDark: isDark,
                            isHighlight: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Reflection Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What do you think caused this increase?',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Reflection Textarea
                  _buildReflectionTextarea(isDark),

                  const SizedBox(height: 16),

                  // Suggested Tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _suggestedTags.map((tag) {
                      final isSelected = _selectedTags.contains(tag);
                      return FilterChip(
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedTags.add(tag);
                            } else {
                              _selectedTags.remove(tag);
                            }
                          });
                        },
                        label: Text(
                          tag,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? const Color(0xFF13ec49)
                                : (isDark
                                ? Colors.grey[400]
                                : Colors.grey[600]),
                          ),
                        ),
                        backgroundColor: isSelected
                            ? const Color(0xFF13ec49).withOpacity(0.2)
                            : (isDark
                            ? const Color(0xFF1a2e1f)
                            : Colors.grey[100]),
                        side: BorderSide(
                          color: isSelected
                              ? const Color(0xFF13ec49).withOpacity(0.3)
                              : (isDark
                              ? Colors.white.withOpacity(0.05)
                              : Colors.transparent),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildChartBar({
    required String label,
    required double score,
    required double maxScore,
    required Color color,
    required bool isDark,
    bool isHighlight = false,
  }) {
    final percentage = (score / maxScore) * 100;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Score value (shown on hover, we'll show it always for better UX)
        Text(
          score.toStringAsFixed(1),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isHighlight ? const Color(0xFF13ec49) : Colors.grey[500],
          ),
        ),
        const SizedBox(height: 8),

        // Bar
        Container(
          width: 48,
          height: (percentage / 100) * 160,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
            boxShadow: isHighlight
                ? [
              BoxShadow(
                color: const Color(0xFF13ec49).withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: 0,
              ),
            ]
                : null,
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              if (isHighlight)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.white.withOpacity(0.2),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Label
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: isHighlight ? const Color(0xFF13ec49) : Colors.grey[500],
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildReflectionTextarea(bool isDark) {
    return TextField(
      controller: _reflectionController,
      maxLines: 6,
      decoration: InputDecoration(
        hintText: 'Reflect on your day here...',
        hintStyle: TextStyle(
          color: isDark ? Colors.grey[600] : Colors.grey[400],
        ),
        filled: true,
        fillColor: isDark ? const Color(0xFF1a2e1f) : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.grey[200]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF13ec49),
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.all(16),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  Icons.image,
                  color: isDark ? Colors.grey[600] : Colors.grey[400],
                  size: 20,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Image picker would open')),
                  );
                },
                tooltip: 'Add Image',
              ),
              IconButton(
                icon: Icon(
                  Icons.mic,
                  color: isDark ? Colors.grey[600] : Colors.grey[400],
                  size: 20,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Voice recorder would open')),
                  );
                },
                tooltip: 'Record Voice',
              ),
            ],
          ),
        ),
      ),
      style: TextStyle(
        color: isDark ? Colors.white : Colors.black,
      ),
      cursorColor: const Color(0xFF13ec49),
    );
  }
}
