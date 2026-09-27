# Changelog

## 1.0.0 - Initial Release

- Initial release of `splashscreen_ghdinteractivestudio` (`AppSplashScreen`).
- Meta / Instagram inspired splash screen transitions and animations.
- Center entrance: progressive zoom (`scaleBegin: 0.85 -> 1.0`) combined with smooth ease-out fade.
- Centered typography with refined letter spacing.
- Bottom footer with `"from [company]"` layout and subtle synchronized fade-in.
- Support for custom `appLogo`, `companyLogo`, and gradient text (`companyNameGradient`).
- Automatic Dark/Light mode detection and contrast adaptation (`themeMode`).
- Fluid exit transition (`showExitTransition: true`) with fade and slight scale before invoking `onFinish`.
- Preload task synchronization (`preloadFuture`).
- Built-in route transition helper (`AppSplashScreen.fadeRoute`).
- Built-in gradient presets (`metaGradient`, `instagramGradient`, `arcaneGradient`).
- Zero external dependencies.
