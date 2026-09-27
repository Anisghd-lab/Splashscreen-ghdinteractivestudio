import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:splashscreen_ghdinteractivestudio/splashscreen_ghdinteractivestudio.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppSplashScreen - Rendering & Customization', () {
    testWidgets('renders default app name, prefix and company name', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AppSplashScreen(),
        ),
      );

      expect(find.text('Lupus Arena'), findsOneWidget);
      expect(find.text('from'), findsOneWidget);
      expect(find.text('ghdinteractivestudio'), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('renders custom app logo and company logo', (tester) async {
      const appLogoKey = Key('custom_app_logo');
      const companyLogoKey = Key('custom_company_logo');

      await tester.pumpWidget(
        const MaterialApp(
          home: AppSplashScreen(
            appName: 'My Awesome App',
            appLogo: Icon(Icons.star, key: appLogoKey),
            companyPrefix: 'powered by',
            companyName: 'Studio XYZ',
            companyLogo: Icon(Icons.bolt, key: companyLogoKey),
          ),
        ),
      );

      expect(find.text('My Awesome App'), findsOneWidget);
      expect(find.text('powered by'), findsOneWidget);
      expect(find.text('Studio XYZ'), findsOneWidget);
      expect(find.byKey(appLogoKey), findsOneWidget);
      expect(find.byKey(companyLogoKey), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('respects dark and light theme modes', (tester) async {
      // Dark mode test
      await tester.pumpWidget(
        const MaterialApp(
          home: AppSplashScreen(
            themeMode: ThemeMode.dark,
          ),
        ),
      );

      final scaffoldDark = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffoldDark.backgroundColor, const Color(0xFF000000));

      await tester.pumpWidget(const SizedBox());

      // Light mode test
      await tester.pumpWidget(
        const MaterialApp(
          home: AppSplashScreen(
            themeMode: ThemeMode.light,
          ),
        ),
      );

      final scaffoldLight = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffoldLight.backgroundColor, const Color(0xFFFFFFFF));

      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('applies custom background color and gradient', (tester) async {
      const customBgColor = Color(0xFF123456);
      const customGradient = LinearGradient(colors: [Colors.red, Colors.blue]);

      await tester.pumpWidget(
        const MaterialApp(
          home: AppSplashScreen(
            backgroundColor: customBgColor,
            backgroundGradient: customGradient,
          ),
        ),
      );

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, customBgColor);

      final containerFinder = find.descendant(
        of: find.byType(Scaffold),
        matching: find.byType(Container),
      );
      final container = tester.widget<Container>(containerFinder.first);
      expect((container.decoration as BoxDecoration).gradient, customGradient);

      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('applies custom text styles and companyNameGradient', (tester) async {
      const customAppNameStyle = TextStyle(fontSize: 32.0, color: Colors.amber);

      await tester.pumpWidget(
        const MaterialApp(
          home: AppSplashScreen(
            appNameStyle: customAppNameStyle,
            companyNameGradient: AppSplashScreen.metaGradient,
          ),
        ),
      );

      final appNameText = tester.widget<Text>(find.text('Lupus Arena'));
      expect(appNameText.style?.fontSize, 32.0);
      expect(appNameText.style?.color, Colors.amber);

      expect(find.byType(ShaderMask), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
    });
  });

  group('AppSplashScreen - Animation Lifecycle & onFinish', () {
    testWidgets('calls onFinish after duration and exit transition', (tester) async {
      bool finished = false;

      await tester.pumpWidget(
        MaterialApp(
          home: AppSplashScreen(
            duration: const Duration(milliseconds: 1000),
            exitDuration: const Duration(milliseconds: 200),
            entranceDuration: const Duration(milliseconds: 300),
            onFinish: () {
              finished = true;
            },
          ),
        ),
      );

      expect(finished, isFalse);

      await tester.pump(const Duration(milliseconds: 500));
      expect(finished, isFalse);

      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      expect(finished, isTrue);

      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('waits for preloadFuture before finishing', (tester) async {
      bool finished = false;
      final completer = Completer<void>();

      await tester.pumpWidget(
        MaterialApp(
          home: AppSplashScreen(
            duration: const Duration(milliseconds: 500),
            exitDuration: const Duration(milliseconds: 100),
            preloadFuture: completer.future,
            onFinish: () {
              finished = true;
            },
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 600));
      expect(finished, isFalse);

      completer.complete();
      await tester.pump();
      await tester.pumpAndSettle();

      expect(finished, isTrue);

      await tester.pumpWidget(const SizedBox());
    });

    testWidgets('supports skipOnTap if enabled', (tester) async {
      bool finished = false;

      await tester.pumpWidget(
        MaterialApp(
          home: AppSplashScreen(
            duration: const Duration(seconds: 10),
            exitDuration: const Duration(milliseconds: 100),
            skipOnTap: true,
            onFinish: () {
              finished = true;
            },
          ),
        ),
      );

      expect(finished, isFalse);

      await tester.tap(find.byType(AppSplashScreen));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(finished, isTrue);

      await tester.pumpWidget(const SizedBox());
    });
  });

  group('AppSplashScreen - Route Helper', () {
    testWidgets('fadeRoute creates a valid PageRouteBuilder', (tester) async {
      final route = AppSplashScreen.fadeRoute<void>(
        page: const Scaffold(body: Text('Next Page')),
      );

      expect(route, isA<PageRouteBuilder>());
      expect(route.transitionDuration, const Duration(milliseconds: 400));
    });
  });
}
