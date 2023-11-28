import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:lm_labs_app/src/features/sample_feature/presentation/sample_item_details_view.dart';
import 'package:lm_labs_app/src/features/sample_feature/presentation/sample_item_list_view.dart';
import 'package:lm_labs_app/src/features/settings/application/settings_service.dart';
import 'package:lm_labs_app/src/features/settings/presentation/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);

    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController
    // for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return MaterialApp(
      // Providing a restorationScopeId allows the Navigator built by the
      // MaterialApp to restore the navigation stack when a user leaves and
      // returns to the app after it has been killed while running in the
      // background.
      restorationScopeId: 'app',

      // Provide the generated AppLocalizations to the MaterialApp. This
      // allows descendant Widgets to display the correct translations
      // depending on the user's locale.
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('fr', ''), // French, no country code
      ],

      title: 'LM Labs App',

      // Define a light and dark color theme. Then, read the user's
      // preferred ThemeMode (light, dark, or system default) from the
      // SettingsController to display the correct theme.
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,

      // Define a function to handle named routes in order to support
      // Flutter web url navigation and deep linking.
      onGenerateRoute: (routeSettings) => MaterialPageRoute<void>(
        settings: routeSettings,
        builder: (context) {
          switch (routeSettings.name) {
            case SettingsView.routeName:
              return const SettingsView();
            case SampleItemDetailsView.routeName:
              return const SampleItemDetailsView();
            case SampleItemListView.routeName:
            default:
              return const SampleItemListView();
          }
        },
      ),
      builder: (context, child) => I18n(
        child: child!,
      ),
    );
  }
}
