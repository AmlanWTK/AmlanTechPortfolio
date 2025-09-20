import 'package:amlan_portfolio/widgets/OneTimeScrollAnimation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_constants.dart';
import 'responsive_wrapper.dart';


class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWrapper(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 80),
        child: Column(
          children: [
            OneTimeScrollAnimation(
              verticalOffset: 50,
              child: Text(
                'About Me',
                style: GoogleFonts.poppins(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.displayLarge?.color,
                ),
              ),
            ),
            SizedBox(height: 60),

            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 800) {
                  return _buildDesktopLayout(context);
                } else {
                  return _buildMobileLayout(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _buildAboutText(context)),
        SizedBox(width: 60),
        Expanded(flex: 2, child: _buildEducationCard(context)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildAboutText(context),
        SizedBox(height: 40),
        _buildEducationCard(context),
      ],
    );
  }

  Widget _buildAboutText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OneTimeScrollAnimation(
             verticalOffset: 50,
          child: Text(
            'Passionate Developer & Innovator',
            style: GoogleFonts.playfairDisplay(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        SizedBox(height: 20),
        OneTimeScrollAnimation(
             verticalOffset: 50,
          child: Text(
            AppConstants.heroDescription,
            style: GoogleFonts.inter(
              fontSize: 16,
              height: 1.6,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
        SizedBox(height: 20),
        OneTimeScrollAnimation(
             verticalOffset: 50,
          child: Text(
            'I specialize in combining mobile development with cutting-edge AI/ML technologies. '
            'My projects range from disease detection systems to mental health applications, '
            'always focusing on real-world problem solving and user experience.',
            style: GoogleFonts.inter(
              fontSize: 16,
              height: 1.6,
              color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.8),
            ),
          ),
        ),
        SizedBox(height: 30),
        OneTimeScrollAnimation(
             verticalOffset: 50,
          child: _buildPersonalityTraits(context),
        ),
      ],
    );
  }

  Widget _buildPersonalityTraits(BuildContext context) {
    final traits = [
      {'icon': Icons.code, 'text': 'Clean Code Advocate'},
      {'icon': Icons.lightbulb, 'text': 'Problem Solver'},
      {'icon': Icons.trending_up, 'text': 'Continuous Learner'},
      {'icon': Icons.group, 'text': 'Team Player'},
    ];

    return Wrap(
      spacing: 20,
      runSpacing: 15,
      children: traits.map((trait) => OneTimeScrollAnimation(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                trait['icon'] as IconData,
                size: 16,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 6),
              Text(
                trait['text'] as String,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildEducationCard(BuildContext context) {
    return OneTimeScrollAnimation(
      child: Container(
        padding: EdgeInsets.all(30),
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
                Icon(Icons.school, color: Theme.of(context).primaryColor, size: 28),
                SizedBox(width: 12),
                Text(
                  'Education',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.displayLarge?.color,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Bachelor of Science in\nComputer Science & Engineering',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.displayLarge?.color,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Khulna University of Engineering & Technology (KUET)',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '4th Year | 2022 - Present',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
              ),
            ),
            SizedBox(height: 20),
            _buildAchievements(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievements(BuildContext context) {
    final achievements = [
      'Competitive Programming',
      'Machine Learning Projects',
      'Full-Stack Development',
      'Image Processing Research',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OneTimeScrollAnimation(
          child: Text(
            'Key Focus Areas:',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.displayLarge?.color,
            ),
          ),
        ),
        SizedBox(height: 10),
        ...achievements.map((achievement) => OneTimeScrollAnimation(
          child: Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Icon(Icons.check_circle, size: 16, color: Theme.of(context).primaryColor),
                SizedBox(width: 8),
                Text(
                  achievement,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        )).toList(),
      ],
    );
  }
}
