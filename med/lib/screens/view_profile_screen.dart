import 'package:flutter/material.dart';

class ViewProfileScreen extends StatelessWidget {
  const ViewProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileBanner(),
            _buildVitalsGrid(),
            _buildTreatmentSection(),
            _buildLabResults(),
            _buildEmergencyCard(),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[700]!, Colors.blue[500]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 40, color: Colors.blue),
          ),
          const SizedBox(height: 16),
          const Text(
            'Ramesh',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          _buildInfoChip(Icons.cake, '15 Jan 1990 (33 yrs)'),
          _buildInfoChip(Icons.phone, '+91 9876543210'),
          _buildInfoChip(Icons.local_hospital, 'Patient ID: P12345'),
        ],
      ),
    );
  }

  Widget _buildVitalsGrid() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8), // Reduced bottom padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Vital Statistics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              _buildVitalCard('Blood Pressure', '120/80', 'mmHg'),
              _buildVitalCard('Heart Rate', '72', 'bpm'),
              _buildVitalCard('Temperature', '98.6', '°F'),
              _buildVitalCard('SpO2', '98', '%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVitalCard(String title, String value, String unit) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildTreatmentSection() {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16), // Reduced top margin
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Current Treatments',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildTreatmentItem(
              medicine: 'Amoxicillin',
              dosage: '500mg',
              frequency: 'Twice daily',
              duration: '7 days',
            ),
            const Divider(),
            _buildTreatmentItem(
              medicine: 'Ibuprofen',
              dosage: '400mg',
              frequency: 'As needed',
              duration: '5 days',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTreatmentItem({
    required String medicine,
    required String dosage,
    required String frequency,
    required String duration,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            medicine,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Dosage: $dosage • Frequency: $frequency',
            style: TextStyle(color: Colors.grey[600]),
          ),
          Text(
            'Duration: $duration',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildLabResults() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Lab Results',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildLabResultItem(
              testName: 'Blood Sugar',
              value: '95 mg/dL',
              date: '2023-11-15',
              status: 'Normal',
            ),
            _buildLabResultItem(
              testName: 'Blood Pressure',
              value: '120/80 mmHg',
              date: '2023-11-15',
              status: 'Normal',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabResultItem({
    required String testName,
    required String value,
    required String date,
    required String status,
  }) {
    return ListTile(
      title: Text(testName),
      subtitle: Text(date),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(value),
          Text(
            status,
            style: TextStyle(
              color: status == 'Normal' ? Colors.green : Colors.red,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.red[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.emergency, color: Colors.red[700]),
                const SizedBox(width: 8),
                const Text(
                  'Emergency Contact',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildEmergencyContactItem(
              name: 'Sara',
              relation: 'Spouse',
              phone: '+91 9876543210',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyContactItem({
    required String name,
    required String relation,
    required String phone,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          relation,
          style: TextStyle(color: Colors.grey[600]),
        ),
        Row(
          children: [
            Text(
              phone,
              style: const TextStyle(fontSize: 16),
            ),
            IconButton(
              icon: const Icon(Icons.phone),
              onPressed: () {
                // Add phone call functionality
              },
            ),
          ],
        ),
      ],
    );
  }
}