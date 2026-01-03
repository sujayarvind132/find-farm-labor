import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/app_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController phoneController;
  String selectedRole = '';
  String selectedLanguage = 'en';

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF2d7d3d),
              const Color(0xFF1e5a2d),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                const Text(
                  '🌾',
                  style: TextStyle(fontSize: 80),
                ),
                const SizedBox(height: 16),

                // Title
                const Text(
                  'Krishi Sahayak',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),

                // Subtitle
                const Text(
                  'Farm Labor Resource Finder',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 40),

                // Form Card
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Phone Input
                        const Text(
                          'Phone Number',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          decoration: InputDecoration(
                            hintText: 'Enter 10-digit number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.phone),
                            counterText: '',
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Role Selection
                        const Text(
                          'Select Your Role',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: selectedRole.isEmpty ? null : selectedRole,
                          hint: const Text('Select your role'),
                          items: [
                            DropdownMenuItem(
                              value: 'farmer',
                              child: Row(
                                children: const [
                                  Text('👨‍🌾 '),
                                  Text('Farmer - Looking for Labor'),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'laborer',
                              child: Row(
                                children: const [
                                  Text('🧑‍🌾 '),
                                  Text('Laborer - Looking for Work'),
                                ],
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() => selectedRole = value ?? '');
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Language Selection
                        const Text(
                          'Preferred Language',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: selectedLanguage,
                          items: [
                            const DropdownMenuItem(
                              value: 'en',
                              child: Text('🇬🇧 English'),
                            ),
                            const DropdownMenuItem(
                              value: 'hi',
                              child: Text('🇮🇳 Hindi (हिंदी)'),
                            ),
                            const DropdownMenuItem(
                              value: 'pa',
                              child: Text('🇮🇳 Punjabi (ਪੰਜਾਬੀ)'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() => selectedLanguage = value ?? 'en');
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.language),
                          ),
                        ),
                        const SizedBox(height: 28),

                        // Send OTP Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (phoneController.text.length != 10 ||
                                  selectedRole.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please fill all fields correctly'),
                                  ),
                                );
                                return;
                              }
                              appState.setUserRole(selectedRole, selectedLanguage);
                              appState.sendOTP(phoneController.text);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2d7d3d),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Send OTP',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Demo Button
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              if (phoneController.text.isEmpty) {
                                phoneController.text = '9876543210';
                              }
                              if (selectedRole.isEmpty) {
                                selectedRole = 'farmer';
                              }
                              appState.setUserRole(selectedRole, selectedLanguage);
                              appState.sendOTP(phoneController.text);
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color(0xFF2d7d3d),
                                width: 2,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Demo: Auto-verify (OTP: 1234)',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2d7d3d),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
