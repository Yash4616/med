import 'package:flutter/material.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Gradient Header
          Container(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6E3EE3), Color(0xFF5B3BE8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Welcome Doctor',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.2),
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'User ID: 3356635915',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          // Patient's Condition Section
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Patient's Condition",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildConditionCard('Critical', '3', Colors.red),
                        _buildConditionCard("Need's Checkup", '1', Colors.blue),
                        _buildConditionCard('Stable', '5', Colors.green),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Patient's Data",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildPatientCard(
                    number: '1',
                    name: 'Ramesh',
                    symptoms: 'fatigue, dizziness',
                    isCheckup: true,
                  ),
                  const SizedBox(height: 15),
                  _buildPatientCard(
                    number: '2',
                    name: 'Rahul',
                    symptoms: 'blood vomit, nausea',
                    isCritical: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem('assets/icons/home.png', _selectedIndex == 0,
                onTap: () => setState(() => _selectedIndex = 0)),
            _buildNavItem('assets/icons/vitals.png', _selectedIndex == 1,
                onTap: () => setState(() => _selectedIndex = 1)),
            _buildNavItem('assets/icons/ai.png', _selectedIndex == 2,
                onTap: () => setState(() => _selectedIndex = 2), showBeta: true),
            _buildNavItem('assets/icons/profile.png', _selectedIndex == 3,
                onTap: () => setState(() => _selectedIndex = 3)),
          ],
        ),
      ),
    );
  }

  Widget _buildConditionCard(String title, String count, Color color) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPatientCard({
    required String number,
    required String name,
    required String symptoms,
    bool isCheckup = false,
    bool isCritical = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '$number. $name',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCritical ? Colors.red : Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Symptoms: $symptoms',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {},
            child: Text(
              'View Report',
              style: TextStyle(color: Colors.blue[700]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String iconPath, bool isActive,
      {VoidCallback? onTap, bool showBeta = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: isActive
                ? const BoxDecoration(
                    color: Color(0xFF6E3EE3),
                    shape: BoxShape.circle,
                  )
                : null,
            child: Image.asset(
              iconPath,
              height: 28,
              width: 28,
              color: Colors.white,
            ),
          ),
          if (showBeta)
            Positioned(
              right: -5,
              top: -5,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 72, 72, 72),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Beta',
                  style: TextStyle(color: Colors.white, fontSize: 8),
                ),
              ),
            ),
        ],
      ),
    );
  }
}