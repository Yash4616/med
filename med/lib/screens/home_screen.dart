import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:med/screens/profile_screen.dart';
import 'package:med/screens/statistics_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  final String? userType;
  const HomeScreen({super.key, required this.userType});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _symptomsController = TextEditingController();
  bool _isContactingDoctor = false;
  int _selectedIndex = 0;
  bool _isSubmitting = false;
  bool _isMicOn = false;

  @override
  void initState() {
    super.initState();
    if (widget.userType != 'patient') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
    }
  }

  @override
  void dispose() {
    _symptomsController.dispose();
    super.dispose();
  }

  Future<void> _handleUpload() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path!);
        setState(() {
          _isContactingDoctor = true;
        });

        // Add your file upload logic here
        // await uploadFile(file);

        setState(() {
          _isContactingDoctor = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File uploaded successfully')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading file: $e')),
      );
    }
  }

  void _handleSubmit() {
    setState(() {
      _isSubmitting = true;
    });
    
    // Clear symptoms text
    _symptomsController.clear();

    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isSubmitting = false;
      });
    });
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showSymptomsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Symptoms'),
          content: TextField(
            controller: _symptomsController,
            decoration: const InputDecoration(
              hintText: 'Enter your symptoms',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Handle the symptoms submission
                final symptoms = _symptomsController.text;
                _symptomsController.clear(); // Clear the text
                _submitSymptoms(symptoms); // Submit symptoms
                Navigator.pop(context);
                setState(() {
                  // Trigger rebuild of home screen
                });
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _submitSymptoms(String symptoms) async {
    setState(() {
      // Update any state variables that need refreshing
    });
    // Add validation if needed
    try {
      // Add your symptom submission logic here using the symptoms parameter
      // For example:
      // await symptomService.submitSymptoms(symptoms);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Symptoms submitted successfully'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting symptoms: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _pickAndUploadFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path!);
        setState(() {
          _isContactingDoctor = true;
        });

        // Add your file upload logic here
        // await uploadFile(file);

        setState(() {
          _isContactingDoctor = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File uploaded successfully')),
        );
      }
    } catch (e) {
      setState(() {
        _isContactingDoctor = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading file: $e')),
      );
    }
  }

  Future<void> _toggleMic() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) {
      setState(() {
        _isMicOn = !_isMicOn;
      });
    } else {
      // Show permission denied message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Microphone permission denied')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Profile Card
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6666FF), Color(0xFF8A8AFF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: SafeArea(
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 16),
                          ),
                          Text(
                            'Ramesh',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 25,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoColumn('Age', '38 yrs'),
                      _buildInfoColumn('Gender', 'Male'),
                      _buildInfoColumn('User ID', '3356635915'),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _symptomsController,
                    maxLines: 4,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      labelText: 'Enter Symptoms',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Voice message',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      IconButton(
                        icon: Icon(
                          _isMicOn ? Icons.mic : Icons.mic_off,
                          color: _isMicOn ? Colors.blue : Colors.grey[700],
                          size: 24,
                        ),
                        onPressed: _toggleMic,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _handleSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                      ),
                      child: _isSubmitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Submit',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton.icon(
                    onPressed: _handleUpload,
                    icon: const Icon(Icons.cloud_upload, color: Colors.white),
                    label: const Text(
                      'Upload Report',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Recent Health Activities',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 120, // Fixed height for activities
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildActivityItem(
                              'Last health check with Dr. Anitha, 01/07/2022'),
                          _buildActivityItem(
                              'Last medication with Rani, 01/07/2022'),
                          if (_isContactingDoctor)
                            _buildActivityItem('Uploading Report...',
                                isLoading: true),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40), // Fixed gap before navigation
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius:
                          BorderRadius.circular(20), // Increased radius
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15), // Increased padding
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNavItem(
                            'assets/icons/home.png', _selectedIndex == 0,
                            onTap: () => _onNavItemTapped(0)),
                        _buildNavItem(
                            'assets/icons/stat.png', _selectedIndex == 1,
                            onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const StatisticsScreen()),
                          );
                        }),
                        _buildNavItem(
                            'assets/icons/ai.png', _selectedIndex == 2,
                            onTap: () => _onNavItemTapped(2), showBeta: true),
                        _buildNavItem(
                            'assets/icons/profile.png', _selectedIndex == 4,
                            onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfileScreen()),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildActivityItem(String text, {bool isLoading = false}) {
    return GestureDetector(
      onTap: text.contains('Uploading Report') ? _pickAndUploadFile : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            const Icon(Icons.circle, size: 8, color: Colors.grey),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: isLoading ? Colors.blue : Colors.black87,
                fontSize: 16,
              ),
            ),
            if (isLoading) ...[
              const SizedBox(width: 10),
              const SizedBox(
                height: 12,
                width: 12,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String iconPath, bool isActive,
      {VoidCallback? onTap, bool showBeta = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10), // Increased padding
        decoration: isActive
            ? const BoxDecoration(
                color: Color.fromARGB(255, 97, 62, 234),
                shape: BoxShape.circle,
              )
            : null,
        child: Stack(
          children: [
            Image.asset(
              iconPath,
              height: 25, // Increased icon size
              width: 28,
              color: Colors.white,
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
