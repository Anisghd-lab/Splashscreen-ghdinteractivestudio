# Splashscreen GHD Interactive Studio (`AppSplashScreen`)

[![CI](https://github.com/Anisghd-lab/Splashscreen-ghdinteractivestudio/actions/workflows/ci.yml/badge.svg)](https://github.com/Anisghd-lab/Splashscreen-ghdinteractivestudio/actions/workflows/ci.yml)
[![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-blue.svg)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-purple.svg)](https://opensource.org/licenses/MIT)

Un widget Flutter réutilisable, autonome et hautement personnalisable inspiré du **splash screen officiel de Meta / Instagram**, avec des transitions et des animations 60/120 fps ultra-fluides.

---

## ✨ Fonctionnalités

- 🎯 **Animation centrale signature Meta :** Effet de zoom progressif (scale `0.85` vers `1.0`) combiné à un Fade-In (`Curves.easeOutCubic`) et typographie moderne avec espacement de lettres (`letterSpacing`).
- 🏢 **Footer synchronisé :** Positionné en bas au centre dans un `SafeArea` (`EdgeInsets.only(bottom: 32)`), avec préfixe (`"from"`) et nom de studio/entreprise (`"ghdinteractivestudio"`).
- 🌓 **Support Dark / Light automatique :** Auto-détection du mode système ou forçage manuel avec contraste parfait des textes et fonds adaptés.
- 🎨 **Dégradés & Logos personnalisés :** Support pour logos custom (`appLogo`, `companyLogo`) et dégradés de marque (`companyNameGradient`) avec presets inclus (`metaGradient`, `instagramGradient`, `arcaneGradient`).
- ⚡ **Transition de sortie ultra-fluide :** Fondu et zoom doux en sortie avant d'appeler `onFinish` ou de naviguer vers la route cible.
- ⏳ **Préchargement asynchrone (`preloadFuture`) :** Attend à la fois la durée minimale et la fin d'une tâche de chargement (Firebase, cache, etc.).
- 🚀 **Zéro dépendance externe :** Repose 100% sur les primitives natives de Flutter (`AnimationController`, `ScaleTransition`, `FadeTransition`, `SafeArea`, `AnnotatedRegion`).

---

## 📦 Installation

Ajoutez la dépendance dans votre `pubspec.yaml` :

```yaml
dependencies:
  splashscreen_ghdinteractivestudio:
    git:
      url: https://github.com/Anisghd-lab/Splashscreen-ghdinteractivestudio.git
      ref: main
```

Puis importez le package :

```dart
import 'package:splashscreen_ghdinteractivestudio/splashscreen_ghdinteractivestudio.dart';
```

---

## 🚀 Exemples d'utilisation

### 1. Exemple simple (style par défaut Meta / Lupus Arena)

```dart
import 'package:flutter/material.dart';
import 'package:splashscreen_ghdinteractivestudio/splashscreen_ghdinteractivestudio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) => AppSplashScreen(
          appName: 'Lupus Arena',
          companyPrefix: 'from',
          companyName: 'ghdinteractivestudio',
          companyNameGradient: AppSplashScreen.arcaneGradient,
          duration: const Duration(milliseconds: 2500),
          onFinish: () {
            Navigator.of(context).pushReplacement(
              AppSplashScreen.fadeRoute(
                page: const HomeScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
```

---

### 2. Avec logo d'application et tâche asynchrone (`preloadFuture`)

```dart
AppSplashScreen(
  appName: 'Mon Application',
  appLogo: Image.asset(
    'assets/images/logo.png',
    width: 80,
    height: 80,
  ),
  companyPrefix: 'from',
  companyName: 'ghdinteractivestudio',
  companyLogo: const Icon(Icons.bolt, size: 18, color: Colors.white70),
  // Attend au minimum 2.5 secondes ET l'initialisation complète
  preloadFuture: Firebase.initializeApp(),
  duration: const Duration(milliseconds: 2500),
  onFinish: () => Navigator.pushReplacementNamed(context, '/home'),
)
```

---

### 3. Transition de route fluide avec `AppSplashScreen.fadeRoute`

Pour éliminer toute coupure brutale entre le splash screen et l'écran principal :

```dart
Navigator.of(context).pushReplacement(
  AppSplashScreen.fadeRoute(
    page: const HomeScreen(),
    duration: const Duration(milliseconds: 400),
  ),
);
```

---

## ⚙️ Paramètres du Constructeur

| Paramètre | Type | Valeur par défaut | Description |
| :--- | :--- | :--- | :--- |
| `appName` | `String` | `'Lupus Arena'` | Nom de l'application affiché au centre. |
| `appLogo` | `Widget?` | `null` | Logo ou icône optionnel placé au-dessus du nom. |
| `appNameStyle` | `TextStyle?` | `null` | Style de texte personnalisé pour `appName`. |
| `companyPrefix` | `String` | `'from'` | Préfixe affiché au-dessus du nom de l'entreprise. |
| `companyPrefixStyle`| `TextStyle?` | `null` | Style de texte pour le préfixe. |
| `companyName` | `String` | `'ghdinteractivestudio'` | Nom de l'entreprise ou studio dans le footer. |
| `companyNameStyle`| `TextStyle?` | `null` | Style de texte personnalisé pour le nom d'entreprise. |
| `companyLogo` | `Widget?` | `null` | Logo ou icône affiché à côté du nom de l'entreprise. |
| `companyNameGradient`| `Gradient?` | `null` | Dégradé textuel (ex: `metaGradient`, `instagramGradient`). |
| `onFinish` | `FutureOr<void> Function()?`| `null` | Callback appelé après la fin du splash screen et de la sortie. |
| `preloadFuture` | `Future<void>?` | `null` | Tâche asynchrone à attendre obligatoirement avant la sortie. |
| `duration` | `Duration` | `Duration(milliseconds: 2500)` | Durée d'affichage avant le déclenchement de la transition de sortie. |
| `entranceDuration` | `Duration` | `Duration(milliseconds: 900)` | Durée de l'animation d'apparition centrale et du footer. |
| `exitDuration` | `Duration` | `Duration(milliseconds: 350)` | Durée de la transition fluide de sortie. |
| `themeMode` | `ThemeMode` | `ThemeMode.system` | `ThemeMode.system`, `ThemeMode.dark` ou `ThemeMode.light`. |
| `backgroundColor` | `Color?` | `null` | Couleur de fond personnalisée (défaut `#000000` sombre, `#FFFFFF` clair). |
| `backgroundGradient`| `Gradient?` | `null` | Dégradé de fond optionnel sur tout l'écran. |
| `scaleBegin` | `double` | `0.85` | Facteur de zoom initial de l'élément central vers 1.0. |
| `curve` | `Curve` | `Curves.easeOutCubic` | Courbe d'animation de l'entrée. |
| `exitCurve` | `Curve` | `Curves.easeInOutCubic` | Courbe d'animation de sortie. |
| `showExitTransition` | `bool` | `true` | Joue le fondu/zoom de sortie avant d'appeler `onFinish`. |
| `centerSpacing` | `double` | `16.0` | Espacement vertical entre `appLogo` et `appName`. |
| `footerSpacing` | `double` | `4.0` | Espacement vertical entre `companyPrefix` et `companyName`. |
| `companyLogoSpacing`| `double` | `8.0` | Espacement horizontal entre `companyLogo` et `companyName`. |
| `footerBottomPadding`| `double` | `32.0` | Marge inférieure du footer au sein du `SafeArea`. |
| `skipOnTap` | `bool` | `false` | Permet d'accélérer la transition en touchant l'écran. |

---

## 🧪 Tests

Pour exécuter la suite complète de tests unitaires et de widgets :

```bash
flutter test
```

---

## 📄 Licence

Distribué sous la licence [MIT](LICENSE). Copyright (c) 2026 GHD Interactive Studio.
