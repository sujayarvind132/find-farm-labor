# Farm Labor Resource Finder - Flutter Mobile App

## 📱 Complete Setup Guide for Android & iOS

### **Step 1: Install Flutter**

#### On Windows:
1. Download Flutter SDK: https://flutter.dev/docs/get-started/install/windows
2. Extract to a folder (e.g., `C:\flutter`)
3. Add to PATH:
   - Right-click "This PC" → Properties → Advanced system settings
   - Environment Variables → New → `FLUTTER_HOME` = `C:\flutter`
   - Edit PATH → Add `C:\flutter\bin` and `C:\flutter\bin\cache\dart-sdk\bin`
4. Run: `flutter doctor` to verify installation

#### On Mac:
```bash
brew install flutter
export PATH="$PATH:`pwd`/flutter/bin"
flutter doctor
```

#### On Linux:
```bash
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"
flutter doctor
```

---

### **Step 2: Android Setup**

#### Install Android Studio:
1. Download: https://developer.android.com/studio
2. Install Android SDK (API level 31+)
3. Accept licenses: `flutter doctor --android-licenses`

#### Create Virtual Device:
1. Open Android Studio → Device Manager
2. Create new virtual device (Pixel 6, API 33+)
3. Launch emulator

---

### **Step 3: iOS Setup (Mac Only)**

1. Install Xcode: `xcode-select --install`
2. Install CocoaPods: `sudo gem install cocoapods`
3. Accept Xcode license: `sudo xcode-select --license accept`

---

### **Step 4: Create Flutter Project**

```bash
# Navigate to desired folder
cd ~/projects

# Create new project
flutter create farm_labor_finder

# Go into project
cd farm_labor_finder
```

---

### **Step 5: Set Up Project Structure**

Create these folders inside `lib/`:

```
lib/
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── otp_screen.dart
│   ├── farmer/
│   │   ├── farmer_home.dart
│   │   ├── job_posting_screen.dart
│   │   └── find_laborers_screen.dart
│   ├── laborer/
│   │   ├── laborer_home.dart
│   │   ├── available_jobs_screen.dart
│   │   └── profile_screen.dart
│   └── shared/
│       ├── job_details_screen.dart
│       └── laborer_details_screen.dart
├── models/
│   ├── app_state.dart
│   ├── job_model.dart
│   └── laborer_model.dart
├── services/
│   ├── auth_service.dart
│   ├── database_service.dart
│   └── location_service.dart
├── utils/
│   ├── constants.dart
│   ├── app_colors.dart
│   └── strings.dart
├── widgets/
│   ├── job_card.dart
│   ├── laborer_card.dart
│   └── custom_app_bar.dart
└── main.dart
```

---

### **Step 6: Install Dependencies**

```bash
# Update pubspec.yaml with provided dependencies
# Then run:
flutter pub get
```

---

### **Step 7: Run the App**

#### On Android Emulator:
```bash
flutter run
```

#### On Physical Android Phone:
1. Enable USB Debugging: Settings → Developer Options → USB Debugging
2. Connect phone via USB
3. Run: `flutter run`

#### On iOS Simulator (Mac):
```bash
open -a Simulator
flutter run
```

---

### **Step 8: Build APK (Android Release)**

```bash
# Debug APK (for testing)
flutter build apk --debug

# Release APK (for distribution)
flutter build apk --release

# Output: build/app/outputs/flutter-apk/app-release.apk
```

### **Install APK on Phone:**
```bash
flutter install build/app/outputs/flutter-apk/app-release.apk
```

Or manually:
- Transfer APK to phone
- Tap to install
- Allow installation from unknown sources

---

### **Step 9: Build IPA (iOS Release - Mac Only)**

```bash
flutter build ios --release

# Output: build/ios/iphoneos/Runner.app
```

---

## 🔐 **Firebase Setup (Optional - For Production)**

### Android:
1. Go to: https://console.firebase.google.com
2. Create new project
3. Add Android app
4. Download `google-services.json`
5. Place in: `android/app/`

### iOS:
1. Add iOS app in Firebase Console
2. Download `GoogleService-Info.plist`
3. Add to Xcode project

---

## 📊 **File Structure to Copy**

Create these files with the provided code:

1. **pubspec.yaml** - Dependencies configuration
2. **lib/main.dart** - Entry point
3. **lib/models/app_state.dart** - State management
4. **lib/screens/auth/login_screen.dart** - Login UI
5. **lib/screens/auth/otp_screen.dart** - OTP UI
6. **lib/screens/farmer/farmer_home.dart** - Farmer dashboard
7. **lib/screens/laborer/laborer_home.dart** - Laborer dashboard

---

## 🚀 **Testing Credentials**

- **Phone**: Any 10 digits (e.g., 9876543210)
- **OTP**: 1234
- **Demo Mode**: Click "Demo: Auto-verify" button

---

## 🎯 **Key Features Implemented**

✅ Phone number authentication with OTP
✅ Farmer dashboard with job posting
✅ Laborer dashboard with job browsing
✅ Job filtering by location and skills
✅ Laborer profiles and ratings
✅ Apply for jobs functionality
✅ Favorites system
✅ Dark/Light theme support
✅ Multi-language support (English, Hindi, Punjabi)
✅ Responsive UI for all screen sizes
✅ Local state management with Provider

---

## 🔄 **Next Steps for Backend Integration**

1. Set up Firebase Authentication
2. Create Firestore database
3. Integrate Google Maps API for location
4. Add Firebase Cloud Messaging for notifications
5. Implement payment gateway

---

## 📞 **Support**

For issues:
- Check `flutter doctor` output
- Clear cache: `flutter clean`
- Rebuild: `flutter pub get`
- Check logs: `flutter logs`

---

## 📦 **Distribution**

### Play Store (Android):
1. Create Google Play Developer account
2. Build release APK
3. Upload to Play Store
4. Set pricing and distribute

### App Store (iOS):
1. Create Apple Developer account
2. Build IPA
3. Use TestFlight for testing
4. Submit to App Store Review

---

**Happy coding! 🌾🚀**
