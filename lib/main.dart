import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/otp_screen.dart';
import 'screens/farmer/farmer_home.dart';
import 'screens/laborer/laborer_home.dart';
import 'models/app_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const FarmLaborApp(),
    ),
  );
}

class FarmLaborApp extends StatelessWidget {
  const FarmLaborApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Krishi Sahayak - Farm Labor Finder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2d7d3d),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2d7d3d),
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2d7d3d),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: const Color(0xFF2d7d3d),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2d7d3d),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const AppRouter(),
    );
  }
}

class AppRouter extends StatelessWidget {
  const AppRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) {
        if (!appState.isLoggedIn) {
          if (appState.isOtpSent && appState.currentPhone.isNotEmpty) {
            return OtpScreen(phone: appState.currentPhone);
          }
          return const LoginScreen();
        }

        if (appState.userRole == 'farmer') {
          return const FarmerHomeScreen();
        } else {
          return const LaborerHomeScreen();
        }
      },
    );
  }
}
