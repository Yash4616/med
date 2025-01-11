import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:med/screens/edit_profile_screen.dart';
import 'package:med/screens/signup_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profile', style: TextStyle(fontSize: 24)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Avatar and User Info
            Center(
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person, size: 80, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ramesh',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text('Ramesh@gmail.com'),
                  const Text('1239475605'),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      minimumSize: const Size(60, 20),
                      textStyle: const TextStyle(fontSize: 10),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text('Edit Profile'),
                  ),
                ],
              ),
            ),
            
            // Reports Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Reports uploaded',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatColumn(label: 'Current', value: '3'),
                        _StatColumn(label: 'Pending', value: '0'),
                        _StatColumn(label: 'History', value: '5'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Reports only valid for 6 months',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
            
            // Settings Menu
            ..._buildSettingsItems(),
            
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.only(bottom: 64), // Increased bottom padding
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(userType: 'patient'),
                    ),
                  );
                },
                child: const Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSettingsItems() {
    return [
      _SettingsItem(
        title: 'Language',
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text('English'),
        ),
      ),
      _SettingsItem(
        title: 'Notification',
        trailing: const Icon(Icons.notifications_outlined),
      ),
      _SettingsItem(
        title: 'Information',
        textColor: Colors.grey,
      ),
      _SettingsItem(
        title: 'Version',
        trailing: const Icon(Icons.phone_iphone),
      ),
      _SettingsItem(
        title: 'Terms of Service',
        trailing: const Icon(Icons.description_outlined),
      ),
      _SettingsItem(
        title: 'Privacy Policy',
        trailing: const Icon(Icons.security_outlined),
      ),
      _SettingsItem(
        title: 'Open Source License',
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    ];
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;

  const _StatColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final Color? textColor;

  const _SettingsItem({
    required this.title,
    this.trailing,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      trailing: trailing,
    );
  }
}