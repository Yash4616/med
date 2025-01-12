import 'package:flutter/material.dart';
import 'package:med/screens/profile_screen.dart';
import 'package:med/screens/ai_chat_screen.dart';
import 'package:med/screens/view_profile_screen.dart';
import 'ai_help_screen.dart';

class DoctorStatScreen extends StatefulWidget {
  const DoctorStatScreen({super.key});

  @override
  State<DoctorStatScreen> createState() => _DoctorStatScreenState();
}

class _DoctorStatScreenState extends State<DoctorStatScreen> {
  final int _selectedIndex = 1; // Default to statistics tab

  Widget _buildNavItem(String iconPath, bool isActive,
      {VoidCallback? onTap, bool showBeta = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Image.asset(
            iconPath,
            height: 25,
            width: 28,
            // Remove color property here to show original icon color
          ),
          if (showBeta)
            Positioned(
              right: -4,
              top: -4,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 72, 72, 72),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'BETA',
                  style: TextStyle(color: Colors.white, fontSize: 8),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                const Text(
                  'Hello,',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 24,
                  ),
                ),
                const Text(
                  'Doctor Rahul',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),

                // Appointment Card
                _buildPatientCard(),
                const SizedBox(height: 24), // Adjusted gap here

                // Second Appointment Card
                _buildSecondAppointmentCard(),
                const SizedBox(height: 50), // Increased gap here

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 80, // Match home screen height
        margin: const EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 60,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem('assets/icons/home.png', _selectedIndex == 0,
                onTap: () {
              Navigator.pop(context);
            }),
            _buildNavItem('assets/icons/stat.png', _selectedIndex == 1,
                onTap: () {}),
            _buildNavItem('assets/icons/ai.png', _selectedIndex == 2,
                onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AIChatScreen()),
              );
            }, 
            showBeta: true),
            _buildNavItem('assets/icons/profile.png', _selectedIndex == 3,
                onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientCard() {
    return PatientCard(
      patientName: "Ramesh",  // Add patient name
      patientId: "823y83271",  // Add appropriate patient ID
      age: 30,  // Add patient age
      gender: "Male",  // Add patient gender
      lastCheckup: DateTime(2023, 5, 20),  // Add last checkup date
      symptoms: const ["Fever", "Headache"],  // Add list of symptoms
    );
  }

  Widget _buildSecondAppointmentCard() {
    return PatientCard(
      patientName: "Sara",  // Add patient name
      patientId: "2873627",  // Add appropriate patient ID
      age: 25,  // Add patient age
      gender: "Female",  // Add patient gender
      lastCheckup: DateTime(2023, 5, 18),  // Add last checkup date
      symptoms: const ["Cough", "Fatigue"],  // Add list of symptoms
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  

  Widget _buildSuggestionCard(String title, String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class PatientCard extends StatelessWidget {
  final String patientName;
  final String patientId;
  final int age;
  final String gender;
  final DateTime lastCheckup;
  final List<String> symptoms;
  final bool isActive;

  const PatientCard({
    super.key,
    required this.patientName,
    required this.patientId,
    required this.age,
    required this.gender,
    required this.lastCheckup,
    required this.symptoms,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive ? Colors.green : Colors.grey,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patientName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'ID: $patientId',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Main Content - Grid Layout
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 3,
              children: [
                _buildInfoItem('Age', '$age years'),
                _buildInfoItem('Gender', gender),
                _buildInfoItem('Last Checkup', 
                    '${lastCheckup.day}/${lastCheckup.month}/${lastCheckup.year}'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,  // Minimize vertical space
                  children: [
                    Text(
                      'Symptoms',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 2),  // Reduced spacing
                    Container(
                      constraints: const BoxConstraints(maxHeight: 50),  // Constrain height
                      child: SingleChildScrollView(
                        child: Wrap(
                          spacing: 2,  // Reduced spacing
                          runSpacing: 2,  // Reduced spacing
                          children: symptoms.map((symptom) => Chip(
                            visualDensity: VisualDensity.compact,  // More compact chips
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            label: Text(
                              symptom,
                              style: const TextStyle(fontSize: 11),  // Smaller text
                            ),
                            backgroundColor: Colors.blue[50],
                            padding: const EdgeInsets.symmetric(horizontal: 4),  // Reduced padding
                          )).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Footer with AI Button
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {   
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ViewProfileScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.person_outline, size: 18),
                  label: const Text('View Profile'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AIHelpScreen(
                          patientName: patientName,
                          age: age,
                          patientId: patientId,
                          lastVisit: lastCheckup,
                          physician: 'Dr. Rahul',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.smart_toy, size: 18),
                  label: const Text('AI Help'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
