import 'package:amlan_portfolio/widgets/OneTimeScrollAnimation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../constants/app_constants.dart';
import 'responsive_wrapper.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({Key? key}) : super(key: key);

  @override
  _SkillsSectionState createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with TickerProviderStateMixin {

  final List<Map<String, dynamic>> skillCategories = [
    {
      'title': 'Programming Languages',
      'icon': Icons.code,
      'skills': [
        {'name': 'C++', 'level': 0.90, 'color': Color(0xFF00599C)},
        {'name': 'Java', 'level': 0.85, 'color': Color(0xFFED8B00)},
        {'name': 'Python', 'level': 0.88, 'color': Color(0xFF3776AB)},
        {'name': 'Dart', 'level': 0.92, 'color': Color(0xFF0175C2)},
      ]
    },
    {
      'title': 'Frameworks & Tools',
      'icon': Icons.build,
      'skills': [
        {'name': 'Flutter', 'level': 0.95, 'color': Color(0xFF02569B)},
        {'name': 'Laravel', 'level': 0.82, 'color': Color(0xFFFF2D20)},
        {'name': 'Android', 'level': 0.80, 'color': Color(0xFF3DDC84)},
        {'name': 'Firebase', 'level': 0.85, 'color': Color(0xFFFFCA28)},
      ]
    },
    {
      'title': 'AI/ML & Data',
      'icon': Icons.psychology,
      'skills': [
        {'name': 'Machine Learning', 'level': 0.87, 'color': Color(0xFFFF6F00)},
        {'name': 'TensorFlow', 'level': 0.83, 'color': Color(0xFFFF6F00)},
        {'name': 'OpenCV', 'level': 0.85, 'color': Color(0xFF5C3EE8)},
        {'name': 'Image Processing', 'level': 0.88, 'color': Color(0xFFE91E63)},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: ResponsiveWrapper(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 80),
          child: Column(
            children: [
              Text(
                'Skills & Expertise',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.displayLarge?.color,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Technologies I work with to bring ideas to life',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.color
                      ?.withOpacity(0.7),
                ),
              ),
              SizedBox(height: 60),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 900) {
                    return _buildDesktopSkillsGrid(context);
                  } else {
                    return _buildMobileSkillsGrid(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopSkillsGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        childAspectRatio: 1.0,
      ),
      itemCount: skillCategories.length,
      itemBuilder: (context, index) {
        return OneTimeScrollAnimation(
          verticalOffset: 50.0,
          child: _buildSkillCard(context, skillCategories[index]),
        );
      },
    );
  }

  Widget _buildMobileSkillsGrid(BuildContext context) {
    return Column(
      children: skillCategories
          .map((category) => Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: OneTimeScrollAnimation(
                  verticalOffset: 50.0,
                  child: _buildSkillCard(context, category),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildSkillCard(BuildContext context, Map<String, dynamic> category) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  category['icon'],
                  color: Theme.of(context).primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  category['title'],
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.displayLarge?.color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          ...category['skills']
              .map<Widget>((skill) => _buildAnimatedSkillBar(context, skill))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildAnimatedSkillBar(
      BuildContext context, Map<String, dynamic> skill) {
    return OneTimeScrollAnimation(
      verticalOffset: 50.0,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  skill['name'],
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                Text(
                  '${(skill['level'] * 100).toInt()}%',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: skill['color'],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(3),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: skill['level'],
                child: Container(
                  decoration: BoxDecoration(
                    color: skill['color'],
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                        color: skill['color'].withOpacity(0.4),
                        blurRadius: 4,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Don't forget to include your OneTimeScrollAnimation widget from before
