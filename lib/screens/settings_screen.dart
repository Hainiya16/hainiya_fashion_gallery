// screens/settings_screen.dart (Completely Fixed)
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          _buildSettingsGroup(
            title: 'Preferences',
            children: [
              SwitchListTile(
                title: const Text('Dark Mode'),
                subtitle: const Text('Switch to dark theme'),
                value: false,
                onChanged: (value) {},
                secondary: const Icon(Icons.dark_mode, color: Colors.blue),
              ),
              SwitchListTile(
                title: const Text('Notifications'),
                subtitle: const Text('Receive push notifications'),
                value: true,
                onChanged: (value) {},
                secondary: const Icon(Icons.notifications, color: Colors.blue),
              ),
            ],
          ),
          _buildSettingsGroup(
            title: 'Language',
            children: [
              ListTile(
                leading: const Icon(Icons.language, color: Colors.blue),
                title: const Text('App Language'),
                subtitle: const Text('English'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ],
          ),
          _buildSettingsGroup(
            title: 'Privacy',
            children: [
              ListTile(
                leading: const Icon(Icons.privacy_tip, color: Colors.blue),
                title: const Text('Privacy Policy'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.description, color: Colors.blue), // Changed from Icons.terms to Icons.description
                title: const Text('Terms & Conditions'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        ...children,
        const Divider(height: 20),
      ],
    );
  }
}