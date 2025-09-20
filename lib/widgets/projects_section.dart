import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_constants.dart';
import 'responsive_wrapper.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({Key? key}) : super(key: key);

  @override
  _ProjectsSectionState createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWrapper(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 80),
        child: Column(
          children: [
            // Section Title
            Text(
              'Featured Projects',
              style: GoogleFonts.playfairDisplay(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.displayLarge?.color,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'A showcase of my technical journey and problem-solving capabilities',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
              ),
            ),
            SizedBox(height: 60),
            
            // Projects Grid
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 800) {
                  return _buildProjectsGrid(context, 2);
                } else {
                  return _buildProjectsGrid(context, 1);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context, int crossAxisCount) {
    return AnimationLimiter(
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          childAspectRatio: crossAxisCount == 2 ? 1.1 : 0.8,
        ),
        itemCount: AppConstants.projects.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: Duration(milliseconds: 600),
            columnCount: crossAxisCount,
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: _buildProjectCard(context, AppConstants.projects[index]),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Map<String, dynamic> project) {
    return MouseRegion(
      onEnter: (_) => setState(() {}),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.1),
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Image/Banner
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.8),
                      Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        _getProjectIcon(project['title']),
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: _buildStatusBadge(context, project['status']),
                    ),
                  ],
                ),
              ),
              
              // Project Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project['title'],
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.displayLarge?.color,
                        ),
                      ),
                      SizedBox(height: 8),
                      
                      Expanded(
                        child: Text(
                          project['description'],
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            height: 1.5,
                            color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 16),
                      
                      // Technologies
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: (project['technologies'] as List<String>).map((tech) => 
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Theme.of(context).primaryColor.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              tech,
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          )
                        ).toList(),
                      ),
                      
                      SizedBox(height: 16),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _launchURL(project['github']),
                              icon: Icon(Icons.code, size: 16),
                              label: Text('Code', style: TextStyle(fontSize: 12)),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 8),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _showProjectDetails(context, project),
                              icon: Icon(Icons.info, size: 16),
                              label: Text('Details', style: TextStyle(fontSize: 12)),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, String status) {
    Color badgeColor;
    switch (status.toLowerCase()) {
      case 'completed':
        badgeColor = Colors.green;
        break;
      case 'in progress':
        badgeColor = Colors.orange;
        break;
      default:
        badgeColor = Colors.blue;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  IconData _getProjectIcon(String title) {
    if (title.contains('AI') || title.contains('ML') || title.contains('Detection')) {
      return Icons.psychology;
    } else if (title.contains('App') || title.contains('Mobile')) {
      return Icons.phone_android;
    } else if (title.contains('Web') || title.contains('Blog')) {
      return Icons.web;
    }
    return Icons.work;
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  void _showProjectDetails(BuildContext context, Map<String, dynamic> project) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(project['title']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(project['description']),
            SizedBox(height: 16),
            Text('Features:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...project['features'].map<Widget>((feature) => 
              Text('• $feature')
            ).toList(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _launchURL(project['github']);
            },
            child: Text('View Code'),
          ),
        ],
      ),
    );
  }
}