import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  // Authentication
  bool isLoggedIn = false;
  bool isOtpSent = false;
  String currentPhone = '';
  String userRole = ''; // 'farmer' or 'laborer'
  String preferredLanguage = 'en'; // 'en', 'hi', 'pa'

  // User Info
  Map<String, dynamic> currentUser = {};

  // Theme
  bool isDarkMode = false;

  // Jobs & Laborers
  List<Map<String, dynamic>> jobs = [];
  List<Map<String, dynamic>> laborers = [];
  List<Map<String, dynamic>> favorites = [];
  List<int> appliedJobs = [];

  // Initialize mock data
  void initializeMockData() {
    jobs = [
      {
        'id': 1,
        'title': 'Wheat Harvesting',
        'type': 'harvesting',
        'workersNeeded': 5,
        'wage': 500,
        'duration': 'daily',
        'startDate': '2025-01-05',
        'location': 'Narnaund, Haryana',
        'distance': 2,
        'description': 'Need experienced workers for wheat harvesting. Daily work, 8 hours.',
        'farmerName': 'Raj Kumar',
        'farmerRating': 4.8,
        'applications': 3
      },
      {
        'id': 2,
        'title': 'Irrigation System Setup',
        'type': 'irrigation',
        'workersNeeded': 3,
        'wage': 600,
        'duration': 'weekly',
        'startDate': '2025-01-08',
        'location': 'Nuh, Haryana',
        'distance': 15,
        'description': 'Setting up drip irrigation system. Need skilled workers.',
        'farmerName': 'Priya Sharma',
        'farmerRating': 4.6,
        'applications': 5
      },
      {
        'id': 3,
        'title': 'Sugarcane Planting',
        'type': 'planting',
        'workersNeeded': 8,
        'wage': 450,
        'duration': 'daily',
        'startDate': '2025-01-10',
        'location': 'Firozpur Jhirka, Haryana',
        'distance': 22,
        'description': 'Large sugarcane plantation. Need energetic workers.',
        'farmerName': 'Harman Singh',
        'farmerRating': 4.3,
        'applications': 2
      },
      {
        'id': 4,
        'title': 'Tractor Operation & Plowing',
        'type': 'machinery',
        'workersNeeded': 2,
        'wage': 800,
        'duration': 'daily',
        'startDate': '2025-01-06',
        'location': 'Punsara, Haryana',
        'distance': 8,
        'description': 'Skilled tractor operators needed for field plowing.',
        'farmerName': 'Vikas Patel',
        'farmerRating': 4.9,
        'applications': 7
      },
      {
        'id': 5,
        'title': 'Vegetable Picking & Packaging',
        'type': 'harvesting',
        'workersNeeded': 10,
        'wage': 400,
        'duration': 'daily',
        'startDate': '2025-01-07',
        'location': 'Narnaund, Haryana',
        'distance': 3,
        'description': 'Organic vegetable farm needs workers for picking and packaging.',
        'farmerName': 'Anjali Sharma',
        'farmerRating': 4.7,
        'applications': 4
      },
    ];

    laborers = [
      {
        'id': 1,
        'name': 'Rajesh Kumar',
        'skills': ['harvesting', 'planting'],
        'wage': 450,
        'rating': 4.7,
        'reviews': 12,
        'distance': 2,
        'availability': 'daily',
        'experience': '5 years',
        'avatar': '👨‍🌾'
      },
      {
        'id': 2,
        'name': 'Meera Singh',
        'skills': ['harvesting', 'irrigation'],
        'wage': 400,
        'rating': 4.9,
        'reviews': 18,
        'distance': 5,
        'availability': 'daily',
        'experience': '8 years',
        'avatar': '👩‍🌾'
      },
      {
        'id': 3,
        'name': 'Akshay Sharma',
        'skills': ['machinery', 'planting'],
        'wage': 750,
        'rating': 4.6,
        'reviews': 9,
        'distance': 8,
        'availability': 'weekly',
        'experience': '6 years',
        'avatar': '👨‍🔧'
      },
      {
        'id': 4,
        'name': 'Priya Devi',
        'skills': ['harvesting', 'livestock'],
        'wage': 380,
        'rating': 4.8,
        'reviews': 15,
        'distance': 3,
        'availability': 'daily',
        'experience': '4 years',
        'avatar': '👩‍🌾'
      },
      {
        'id': 5,
        'name': 'Harman Patel',
        'skills': ['machinery', 'irrigation'],
        'wage': 700,
        'rating': 4.5,
        'reviews': 11,
        'distance': 10,
        'availability': 'weekly',
        'experience': '7 years',
        'avatar': '👨‍🔧'
      },
      {
        'id': 6,
        'name': 'Sunita Yadav',
        'skills': ['planting', 'harvesting'],
        'wage': 420,
        'rating': 4.4,
        'reviews': 8,
        'distance': 6,
        'availability': 'daily',
        'experience': '3 years',
        'avatar': '👩‍🌾'
      }
    ];
  }

  // Auth Methods
  void sendOTP(String phone) {
    currentPhone = phone;
    isOtpSent = true;
    notifyListeners();
  }

  void verifyOTP(String otp) {
    if (otp == '1234' || otp.length == 4) {
      isLoggedIn = true;
      isOtpSent = false;
      notifyListeners();
    }
  }

  void setUserRole(String role, String language) {
    userRole = role;
    preferredLanguage = language;
    initializeMockData();
    notifyListeners();
  }

  void logout() {
    isLoggedIn = false;
    isOtpSent = false;
    currentPhone = '';
    userRole = '';
    currentUser = {};
    appliedJobs = [];
    notifyListeners();
  }

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }

  // Job Methods
  void createJob(Map<String, dynamic> jobData) {
    final newJob = {
      ...jobData,
      'id': jobs.length + 1,
      'farmerName': 'You',
      'farmerRating': 4.8,
      'applications': 0,
      'distance': 5,
    };
    jobs.add(newJob);
    notifyListeners();
  }

  void applyForJob(int jobId) {
    if (!appliedJobs.contains(jobId)) {
      appliedJobs.add(jobId);
      notifyListeners();
    }
  }

  void addToFavorites(Map<String, dynamic> laborer) {
    favorites.add(laborer);
    notifyListeners();
  }

  void removeFromFavorites(int laborerId) {
    favorites.removeWhere((l) => l['id'] == laborerId);
    notifyListeners();
  }

  List<Map<String, dynamic>> getAppliedJobs() {
    return jobs.where((job) => appliedJobs.contains(job['id'])).toList();
  }
}
