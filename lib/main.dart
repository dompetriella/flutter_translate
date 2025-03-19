import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/l10n/app_localizations.dart';
import 'package:flutter_translate/l10n/app_localizations_en.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String currentLanguageCode = AppLocalizationsEn().localeName;

  void updateLanguageCode(String newLanguageCode) {
    setState(() {
      currentLanguageCode = newLanguageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Localization Demo',

      // an easy way to
      locale: Locale(currentLanguageCode),

      // AppLocalizations comes from adding the .arb files in lib/l10n
      // and running flutter gen-l10n

      // these delegates allow for widgets auto translate
      // this would include widgets like TimePicker that have pre-baked text
      localizationsDelegates: AppLocalizations.localizationsDelegates,

      // these can be added manually with Locale('en') for example
      // however these are auto generated based on your .arb files in lib/l10n
      supportedLocales: AppLocalizations.supportedLocales,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(
        currentLanguageCode: currentLanguageCode,
        updateLanguageCode: updateLanguageCode,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String currentLanguageCode;
  final ValueChanged<String> updateLanguageCode;
  const HomePage({
    super.key,
    required this.currentLanguageCode,
    required this.updateLanguageCode,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String getLanguageFromLanguageCode(String languageCode) {
      switch (languageCode) {
        case 'en':
          return AppLocalizations.of(context).englishName;
        case 'es':
          return AppLocalizations.of(context).spanishName;
        case 'ja':
          return AppLocalizations.of(context).japaneseName;
        case 'uk':
          return AppLocalizations.of(context).ukrainianName;
        case 'ar':
          return AppLocalizations.of(context).arabicName;
        default:
          return 'no language';
      }
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            children:
                AppLocalizations.supportedLocales.map((locale) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio(
                          value: locale.languageCode,
                          groupValue: widget.currentLanguageCode,
                          onChanged: (language) {
                            widget.updateLanguageCode(language!);
                          },
                        ),
                        Text(getLanguageFromLanguageCode(locale.languageCode)),
                        SizedBox(width: 8),
                      ],
                    ),
                  );
                }).toList(),
          ),
          Center(
            child: Column(
              children: [
                // You can access generated localizations with
                // the AppLocalizations.of(context) and its .arb key
                Text(AppLocalizations.of(context).helloWorld),
                IconButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 30)),
                    );
                  },
                  icon: Icon(Icons.calendar_month),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
