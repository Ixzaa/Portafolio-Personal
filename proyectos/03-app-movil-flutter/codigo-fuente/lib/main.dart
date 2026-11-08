import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'models/recordatorio.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecordatoriosProvider()),
      ],
      child: const MediCareApp(),
    ),
  );
}

class MediCareApp extends StatelessWidget {
  const MediCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediCare Móvil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: const Color(0xFF06B6D4),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF06B6D4),
          secondary: Color(0xFF38BDF8),
          surface: Color(0xFF1E293B),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
