import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_constants.dart';
import 'animated_text_widget.dart';
import 'responsive_wrapper.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  _HeroSectionState createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.elasticOut,
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.bounceOut,
    ));

    _slideController.forward();
    Future.delayed(Duration(milliseconds: 300), () {
      _scaleController.forward();
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWrapper(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.1),
              Theme.of(context).colorScheme.secondary.withOpacity(0.1),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile Avatar with Animation
              ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/profile.jpg', // Add your image
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.white,
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              
              // Name with Slide Animation
              SlideTransition(
                position: _slideAnimation,
                child: Text(
                  AppConstants.name,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.displayLarge?.color,
                  ),
                ),
              ),
              SizedBox(height: 10),
              
              // Animated Title
              AnimatedTextWidget(),
              SizedBox(height: 20),
              
              // Description
              SlideTransition(
                position: _slideAnimation,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 600),
                  child: Text(
                    AppConstants.heroDescription,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      height: 1.5,
                      color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              
              // Action Buttons
              SlideTransition(
                position: _slideAnimation,
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    _buildActionButton(
                      context,
                      'View Projects',
                      Icons.work,
                      () => _scrollToProjects(),
                      isPrimary: true,
                    ),
                    _buildActionButton(
                      context,
                      'Contact Me',
                      Icons.mail,
                      () => _scrollToContact(),
                      isPrimary: false,
                    ),
                    _buildActionButton(
                      context,
                      'Download CV',
                      Icons.download,
                      () => _downloadCV(),
                      isPrimary: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String text,
    IconData icon,
    VoidCallback onPressed,
    {required bool isPrimary}
  ) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary 
            ? Theme.of(context).primaryColor 
            : Colors.transparent,
          foregroundColor: isPrimary 
            ? Colors.white 
            : Theme.of(context).primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: isPrimary 
              ? BorderSide.none 
              : BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }

  void _scrollToProjects() {
    // Implement scroll to projects
  }
  
  void _scrollToContact() {
    // Implement scroll to contact
  }
  
  void _downloadCV() async {
    const url = 'https://github.com/AmlanWTK'; // Replace with actual CV link
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}