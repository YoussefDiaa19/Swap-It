import 'package:flutter/material.dart';
import '../../features/chat/chat_page.dart';
import '../../features/favorites/favorites_page.dart';
import '../../features/home/home_page.dart';
import '../../features/profile/profile_page.dart';

/// Main navigation scaffold containing the persistent Bottom Navigation Bar.
///
/// Styled according to the sleek minimalist aesthetic in the design:
/// - 4 clean uppercase tabs: HOME, CHAT, FAVORITES, PROFILE
/// - Preserves state across tabs using [IndexedStack]
class MainNavWrapper extends StatefulWidget {
  const MainNavWrapper({super.key});

  @override
  State<MainNavWrapper> createState() => _MainNavWrapperState();
}

class _MainNavWrapperState extends State<MainNavWrapper> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ChatPage(),
    FavoritesPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color(0xFFE5E7EB), width: 1),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  label: 'HOME',
                  activeIcon: Icons.home_rounded,
                  inactiveIcon: Icons.home_outlined,
                ),
                _buildNavItem(
                  index: 1,
                  label: 'CHAT',
                  activeIcon: Icons.chat_bubble_rounded,
                  inactiveIcon: Icons.chat_bubble_outline_rounded,
                ),
                _buildNavItem(
                  index: 2,
                  label: 'FAVORITES',
                  activeIcon: Icons.favorite_rounded,
                  inactiveIcon: Icons.favorite_border_rounded,
                ),
                _buildNavItem(
                  index: 3,
                  label: 'PROFILE',
                  activeIcon: Icons.account_circle_rounded,
                  inactiveIcon: Icons.account_circle_outlined,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    required IconData activeIcon,
    required IconData inactiveIcon,
  }) {
    final isSelected = _selectedIndex == index;
    final color = isSelected ? const Color(0xFF111827) : const Color(0xFF9CA3AF);

    return InkWell(
      onTap: () => _onItemTapped(index),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : inactiveIcon,
              color: color,
              size: 24,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                color: color,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
