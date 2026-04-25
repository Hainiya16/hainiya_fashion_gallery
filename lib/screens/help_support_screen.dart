// screens/help_support_screen.dart (Fixed - Removed Icons.whatsapp)
import 'package:flutter/material.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final TextEditingController _questionController = TextEditingController();
  final List<Map<String, String>> _faqs = [
    {
      'question': 'How to track my order?',
      'answer': 'You can track your order from the Order History section in your profile.',
    },
    {
      'question': 'What is the return policy?',
      'answer': 'We offer 30-day return policy for unused products with original packaging.',
    },
    {
      'question': 'How long does shipping take?',
      'answer': 'Standard shipping takes 3-5 business days. Express shipping takes 1-2 business days.',
    },
    {
      'question': 'Do you offer international shipping?',
      'answer': 'Yes, we ship to most countries worldwide. Shipping charges apply.',
    },
    {
      'question': 'How to change my password?',
      'answer': 'Go to Settings > Security > Change Password to update your password.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Help & Support'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Q&A'),
              Tab(text: 'Service'),
            ],
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        body: TabBarView(
          children: [
            // Q&A Tab
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _faqs.length,
                    itemBuilder: (context, index) {
                      return _buildFAQItem(_faqs[index]);
                    },
                  ),
                ),
                _buildAskQuestionSection(),
              ],
            ),
            // Service Tab
            _buildServiceTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(Map<String, String> faq) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: const Icon(Icons.help_outline, color: Colors.blue),
        title: Text(
          faq['question']!,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              faq['answer']!,
              style: const TextStyle(color: Colors.grey, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAskQuestionSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _questionController,
              decoration: InputDecoration(
                hintText: 'Ask a question...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {
              if (_questionController.text.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Question submitted: ${_questionController.text}'),
                    duration: const Duration(seconds: 2),
                  ),
                );
                _questionController.clear();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildServiceCard(
          icon: Icons.headset_mic,
          title: '24/7 Customer Support',
          description: 'Call us anytime for immediate assistance',
          action: 'Call Now',
          color: Colors.green,
        ),
        _buildServiceCard(
          icon: Icons.email,
          title: 'Email Support',
          description: 'support@shoeshop.com',
          action: 'Send Email',
          color: Colors.blue,
        ),
        _buildServiceCard(
          icon: Icons.chat,
          title: 'Live Chat',
          description: 'Chat with our support team',
          action: 'Start Chat',
          color: Colors.orange,
        ),
        _buildServiceCard(
          icon: Icons.message, // Changed from Icons.whatsapp to Icons.message
          title: 'WhatsApp',
          description: '+91 9876543210',
          action: 'Message Us',
          color: Colors.green,
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            children: [
              Icon(Icons.store, size: 40, color: Colors.blue),
              SizedBox(height: 8),
              Text(
                'Store Hours',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Monday - Friday: 9:00 AM - 8:00 PM'),
              Text('Saturday: 10:00 AM - 6:00 PM'),
              Text('Sunday: Closed'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String description,
    required String action,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 30, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(action),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }
}