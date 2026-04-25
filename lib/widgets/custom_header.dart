// widgets/custom_header.dart
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onMenuTap;
  final VoidCallback? onNotificationTap;
  final String? profileImageUrl;
  final VoidCallback? onProfileTap;
  final int cartItemCount;

  const CustomHeader({
    super.key,
    required this.title,
    this.onMenuTap,
    this.onNotificationTap,
    this.profileImageUrl,
    this.onProfileTap,
    this.cartItemCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black),
        onPressed: onMenuTap,
      ),
      actions: [
        // Notification Icon
        IconButton(
          icon: Stack(
            children: [
              const Icon(Icons.notifications_outlined, color: Colors.black),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          onPressed: onNotificationTap,
        ),
        const SizedBox(width: 8),
        // Cart Icon with Badge
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
            ),
            if (cartItemCount > 0)
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    cartItemCount > 99 ? '99+' : '$cartItemCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 4),
        // Profile Photo
        GestureDetector(
          onTap: onProfileTap,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: profileImageUrl != null && profileImageUrl!.isNotEmpty
                ? AssetImage(profileImageUrl!)
                : null,
            child: profileImageUrl == null || profileImageUrl!.isEmpty
                ? const Icon(Icons.person, size: 20, color: Colors.grey)
                : null,
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}