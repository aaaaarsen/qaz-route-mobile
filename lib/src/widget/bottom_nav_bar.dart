import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:qaz_route_mobile/src/core/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.tabsRouter});

  final TabsRouter tabsRouter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        16 + MediaQuery.paddingOf(context).bottom,
      ),
      child: Container(
        height: 76,
        decoration: BoxDecoration(
          color: AppColors.supplementary600,
          borderRadius: BorderRadius.circular(36),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BottomNavBarItem(
              onPressed: () => tabsRouter.setActiveIndex(0),
              icon: Icons.home,
              label: 'Home',
              isSelected: tabsRouter.activeIndex == 0,
            ),
            BottomNavBarItem(
              onPressed: () => tabsRouter.setActiveIndex(1),
              icon: Icons.map,
              label: 'Map',
              isSelected: tabsRouter.activeIndex == 1,
            ),
            BottomNavBarItem(
              onPressed: () => tabsRouter.setActiveIndex(2),
              icon: Icons.qr_code,
              label: 'QR',
              isSelected: tabsRouter.activeIndex == 2,
            ),
            BottomNavBarItem(
              onPressed: () => tabsRouter.setActiveIndex(3),
              icon: Icons.person,
              label: 'Profile',
              isSelected: tabsRouter.activeIndex == 3,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavBarItem extends StatelessWidget {
  const BottomNavBarItem({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final bool isSelected;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 64,
        height: 64,
        decoration:
            isSelected
                ? BoxDecoration(
                  color: AppColors.black.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(24),
                )
                : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.black, size: 28),
            Text(
              label,
              style: TextStyle(
                color: AppColors.neutral900,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
