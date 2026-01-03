#!/bin/bash
# Quick Start Script for Farm Labor Finder Flutter App

echo "🌾 Farm Labor Resource Finder - Flutter Mobile App"
echo "=================================================="
echo ""

# Check Flutter installation
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter not installed!"
    echo "Visit: https://flutter.dev/docs/get-started/install"
    exit 1
fi

echo "✅ Flutter found"
flutter --version
echo ""

# Get dependencies
echo "📦 Installing dependencies..."
flutter pub get

echo ""
echo "🔨 Building app..."

# Ask for platform
echo "Which platform would you like to run on?"
echo "1) Android Emulator"
echo "2) iOS Simulator (Mac only)"
echo "3) Physical Android Device"
read -p "Choose (1-3): " choice

case $choice in
    1)
        echo "🚀 Starting Android Emulator..."
        flutter run
        ;;
    2)
        echo "🚀 Starting iOS Simulator..."
        open -a Simulator
        sleep 2
        flutter run
        ;;
    3)
        echo "📱 Connect your Android device via USB"
        echo "Enable USB Debugging in Settings > Developer Options"
        read -p "Press Enter when device is connected..."
        flutter run
        ;;
    *)
        echo "❌ Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "✅ App launched!"
echo "Demo Credentials:"
echo "  Phone: 9876543210"
echo "  OTP: 1234"
echo ""
