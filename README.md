# 🌾 Krishi Sahayak - Farm Labor Resource Finder

**A native Flutter mobile application** that connects farmers with laborers, enabling direct job matching without middlemen.

![Android](https://img.shields.io/badge/Android-3DDC84?style=flat&logo=android)
![iOS](https://img.shields.io/badge/iOS-000000?style=flat&logo=ios)
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart)

---

## 📱 Features

### 🔐 Authentication
- ✅ Phone number login with OTP verification
- ✅ Role selection (Farmer/Laborer)
- ✅ Multi-language support (English, Hindi, Punjabi)
- ✅ Demo mode (OTP: 1234)

### 👨‍🌾 Farmer Features
- ✅ Create job postings with work type, wage, location
- ✅ Manage active jobs and view applications
- ✅ Browse nearby available laborers
- ✅ Filter laborers by distance and skills
- ✅ Save favorite laborers
- ✅ View laborer ratings and reviews
- ✅ Contact laborers directly

### 🧑‍🌾 Laborer Features
- ✅ Browse nearby farm job opportunities
- ✅ Filter jobs by location and work type
- ✅ Apply for jobs with one tap
- ✅ View applied job status
- ✅ Manage worker profile
- ✅ Set skills and availability
- ✅ Contact farmers
- ✅ Track earnings and ratings

### 🎨 UI/UX
- ✅ Material Design 3
- ✅ Dark/Light mode toggle
- ✅ Responsive design for all screen sizes
- ✅ Smooth animations and transitions
- ✅ Large buttons for rural accessibility
- ✅ Bottom navigation for easy access
- ✅ Loading states and error handling

---

## 🚀 Quick Start

### Prerequisites
- Flutter 3.0+ ([Install](https://flutter.dev/docs/get-started/install))
- Android Studio / Xcode
- Android Emulator or Physical Device / iOS Simulator

### Installation

```bash
# Clone or download the project
cd farm_labor_finder

# Get dependencies
flutter pub get

# Run the app
flutter run
```

**Demo Credentials:**
- Phone: `9876543210` (any 10 digits)
- OTP: `1234`

---

## 📁 Project Structure

```
farm_labor_finder/
├── lib/
│   ├── screens/
│   │   ├── auth/
│   │   │   ├── login_screen.dart
│   │   │   └── otp_screen.dart
│   │   ├── farmer/
│   │   │   └── farmer_home.dart
│   │   └── laborer/
│   │       └── laborer_home.dart
│   ├── models/
│   │   └── app_state.dart
│   └── main.dart
├── pubspec.yaml
└── README.md
```

---

## 📦 Dependencies

```yaml
dependencies:
  flutter: sdk: flutter
  provider: ^6.0.0              # State management
  pin_code_fields: ^7.4.0        # OTP input
  google_fonts: ^6.1.0           # Typography
  intl: ^0.19.0                  # Localization
  geolocator: ^9.0.2             # Location services
  image_picker: ^1.0.0           # Image handling
  flutter_local_notifications: ^16.3.0  # Notifications
```

---

## 🎯 Usage

### For Farmers:
1. **Login** with phone number and OTP
2. **Create Job** - Post harvesting, planting, irrigation jobs
3. **Find Laborers** - Browse nearby workers by skills
4. **Save Favorites** - Keep track of reliable workers
5. **Manage Applications** - View who applied for jobs

### For Laborers:
1. **Login** with phone number and OTP
2. **Browse Jobs** - See nearby job opportunities
3. **Apply** - Submit applications with one tap
4. **Profile** - Set skills, wage expectations, availability
5. **Track** - Monitor applied jobs and earnings

---

## 🔧 Customization

### Change App Name:
```bash
# Android
Edit: android/app/src/main/AndroidManifest.xml

# iOS
Edit: ios/Runner/Info.plist
```

### Change Colors:
Edit `lib/main.dart` theme section:
```dart
theme: ThemeData(
  primaryColor: const Color(0xFF2d7d3d),  // Change this
  // ...
)
```

### Add Firebase:
1. Create Firebase project
2. Add dependencies to pubspec.yaml
3. Configure Android & iOS apps
4. Use Firebase Auth and Firestore

---

## 📊 State Management

Using **Provider** for reactive state management:

```dart
// Access app state
final appState = Provider.of<AppState>(context);

// Create job
appState.createJob(jobData);

// Apply for job
appState.applyForJob(jobId);

// Save favorite
appState.addToFavorites(laborerData);
```

---

## 🏗️ Building for Release

### Android APK:
```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Android App Bundle (Play Store):
```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

### iOS IPA:
```bash
flutter build ios --release
# Output: build/ios/iphoneos/Runner.app
```

---

## 📈 Performance Optimization

- ✅ Local state management (no unnecessary rebuilds)
- ✅ Lazy loading for lists
- ✅ Image caching
- ✅ Efficient filtering algorithms
- ✅ Minimal dependencies

---

## 🔒 Security

- ✅ OTP-based authentication
- ✅ Phone number verification
- ✅ Local data storage with SQLite
- ✅ No sensitive data in code
- ✅ HTTPS for all API calls

---

## 🌍 Supported Languages

- 🇬🇧 English
- 🇮🇳 Hindi (हिंदी)
- 🇮🇳 Punjabi (ਪੰਜਾਬੀ)

Add more languages in `lib/utils/strings.dart`

---

## 🚀 Future Enhancements

- [ ] Real-time notifications
- [ ] Payment integration
- [ ] Chat functionality
- [ ] Advanced matching algorithm
- [ ] GPS-based auto-location
- [ ] Offline support
- [ ] Video KYC
- [ ] Attendance tracking
- [ ] Weather-based job alerts
- [ ] Multi-currency support

---

## 🐛 Troubleshooting

### "flutter: not found"
```bash
export PATH="$PATH:$(pwd)/flutter/bin"
```

### "Gradle build failed"
```bash
flutter clean
flutter pub get
flutter build apk
```

### "No simulator found"
```bash
flutter emulators
flutter emulators launch <emulator_name>
```

### "App crashes on launch"
```bash
flutter logs
flutter run -v  # Verbose mode
```

---

## 📞 Support & Contact

For issues, suggestions, or contributions:
- GitHub Issues
- Email: support@krishisahayak.in
- WhatsApp: Available in app

---

## 📄 License

This project is open-source and available under the MIT License.

---

## 👥 Contributors

- **Development**: Flutter Team
- **Design**: UI/UX Design Team
- **Testing**: QA Team

---

## 🙏 Acknowledgments

- Flutter community for amazing framework
- Provider package for state management
- Google for Material Design
- All contributors and testers

---

**Made with ❤️ for Indian farmers and laborers**

🌾 Krishi Sahayak - Bridging the gap between farmers and labor 🌾
