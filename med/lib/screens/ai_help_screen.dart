import 'package:flutter/material.dart';

class AIHelpScreen extends StatelessWidget {
  final String patientName;
  final int age;
  final String patientId;
  final DateTime lastVisit;
  final String physician;

  const AIHelpScreen({
    super.key,
    required this.patientName,
    required this.age,
    required this.patientId,
    required this.lastVisit,
    required this.physician,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Analysis'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24), // Additional bottom padding
          child: Column(
            children: [
              _buildPatientBanner(),
              _buildQuickActions(),
              _buildAnalysisSummary(),
              _buildRecommendations(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatientBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blue[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            patientName,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Age: $age'),
          Text('ID: $patientId'),
          Text('Last Visit: ${lastVisit.toString()}'),
          Text('Physician: $physician'),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _actionButton(Icons.share, 'Share'),
          _actionButton(Icons.note_add, 'Add Note'),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: () {},
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildAnalysisSummary() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Analysis Summary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildSummaryItem(
            icon: Icons.medical_information,
            title: 'Condition',
            description: 'Based on symptoms and history',
          ),
          _buildSummaryItem(
            icon: Icons.trending_up,
            title: 'Progress',
            description: 'Showing improvement since last visit',
          ),
          _buildSummaryItem(
            icon: Icons.warning_amber,
            title: 'Risk Factors',
            description: 'No significant risks identified',
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendations() {
    return Container(
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 32, // Increased bottom margin
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.amber[700]),
              const SizedBox(width: 8),
              const Text(
                'AI Recommendations',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildRecommendationItem(
            title: 'Follow-up Schedule',
            description: 'Schedule next check-up in 2 weeks',
            priority: 'High',
          ),
          const Divider(),
          _buildRecommendationItem(
            title: 'Additional Tests',
            description: 'Consider blood test for comprehensive evaluation',
            priority: 'Medium',
          ),
          const Divider(),
          _buildRecommendationItem(
            title: 'Lifestyle Changes',
            description: 'Recommend regular exercise and balanced diet',
            priority: 'Normal',
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem({
    required String title,
    required String description,
    required String priority,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getPriorityColor(priority),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              priority,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red[400]!;
      case 'medium':
        return Colors.orange[400]!;
      default:
        return Colors.green[400]!;
    }
  }
}