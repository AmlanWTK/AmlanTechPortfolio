import 'package:amlan_portfolio/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatefulWidget {
  final Function(int) onSectionTap;
  final ThemeProvider themeProvider;
  final int currentIndex;

  const CustomAppBar({
    Key? key,
    required this.onSectionTap,
    required this.themeProvider,
    required this.currentIndex,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final List<String> _sections = ['Home', 'About', 'Skills', 'Projects', 'Contact'];
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              // Logo/Brand
              Text(
                'Amlan Sarkar',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),

              Spacer(),

              // Desktop Navigation
              if (MediaQuery.of(context).size.width > 800) ...[
                Row(
                  children: _sections.asMap().entries.map((entry) {
                    int index = entry.key;
                    String section = entry.value;
                    return _buildNavItem(context, section, index);
                  }).toList(),
                ),
                SizedBox(width: 20),
                _buildThemeToggle(context),
              ] else ...[
                // Mobile Navigation
                _buildThemeToggle(context),
                SizedBox(width: 16),
                _buildMobileMenuButton(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String title, int index) {
    final isSelected = widget.currentIndex == index;

    return InkWell(
      onTap: () {
        widget.onSectionTap(index);
      },
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          style: GoogleFonts.playfairDisplay(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected
                ? Theme.of(context).primaryColor
                : Theme.of(context).textTheme.bodyLarge?.color,
          ),
          child: Text(title),
        ),
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    return InkWell(
      onTap: widget.themeProvider.toggleTheme,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          widget.themeProvider.isDark ? Icons.light_mode : Icons.dark_mode,
          color: Theme.of(context).primaryColor,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildMobileMenuButton(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isMenuOpen = !_isMenuOpen;
        });
        _showMobileMenu(context);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Icon(
          Icons.menu,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _sections.asMap().entries.map((entry) {
            int index = entry.key;
            String section = entry.value;
            return ListTile(
              leading: Icon(
                _getSectionIcon(index),
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                section,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                widget.onSectionTap(index);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  IconData _getSectionIcon(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.person;
      case 2:
        return Icons.code;
      case 3:
        return Icons.work;
      case 4:
        return Icons.contact_mail;
      default:
        return Icons.circle;
    }
  }
}
