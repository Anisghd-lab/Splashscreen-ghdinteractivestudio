import 'package:flutter/material.dart';
import 'package:splashscreen_ghdinteractivestudio/splashscreen_ghdinteractivestudio.dart';

void main() {
  runApp(const SplashDemoApp());
}

class SplashDemoApp extends StatefulWidget {
  const SplashDemoApp({super.key});

  @override
  State<SplashDemoApp> createState() => _SplashDemoAppState();
}

class _SplashDemoAppState extends State<SplashDemoApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen Demo',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: Builder(
        builder: (context) => AppSplashScreen(
          appName: 'Lupus Arena',
          companyPrefix: 'from',
          companyName: 'ghdinteractivestudio',
          companyNameGradient: AppSplashScreen.arcaneGradient,
          duration: const Duration(milliseconds: 2500),
          themeMode: _themeMode,
          onFinish: () {
            Navigator.of(context).pushReplacement(
              AppSplashScreen.fadeRoute(
                page: HomeScreen(
                  onToggleTheme: _toggleTheme,
                  currentThemeMode: _themeMode,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode currentThemeMode;

  const HomeScreen({
    super.key,
    required this.onToggleTheme,
    required this.currentThemeMode,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: onToggleTheme,
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline_rounded,
                size: 80,
                color: Colors.greenAccent,
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome to the App!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                'The splash screen finished cleanly and navigated here using the ultra-smooth fadeRoute transition.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                icon: const Icon(Icons.replay_rounded),
                label: const Text('Replay Splash Screen'),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    AppSplashScreen.fadeRoute(
                      page: Builder(
                        builder: (ctx) => AppSplashScreen(
                          appName: 'Lupus Arena',
                          companyPrefix: 'from',
                          companyName: 'ghdinteractivestudio',
                          companyNameGradient: AppSplashScreen.arcaneGradient,
                          duration: const Duration(milliseconds: 2500),
                          themeMode: currentThemeMode,
                          onFinish: () {
                            Navigator.of(ctx).pushReplacement(
                              AppSplashScreen.fadeRoute(
                                page: HomeScreen(
                                  onToggleTheme: onToggleTheme,
                                  currentThemeMode: currentThemeMode,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
