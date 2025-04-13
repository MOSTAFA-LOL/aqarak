
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:aqarak/Theme/theme.dart';
import 'package:aqarak/cubit/user_cubit.dart';
import 'package:aqarak/data/language.dart';
import 'package:aqarak/provider/book_provider.dart';
import 'package:aqarak/provider/favorite_prvider.dart';
import 'package:aqarak/screans/tap_screan.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(
      const MyApp());
}

var myColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 59, 96, 179),
);
var myDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 59, 96, 179),
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();

  static of(BuildContext context) {}
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(
    BuildContext context,
  ) =>
      MultiProvider(
          providers: [
        //     BlocProvider(
        // create: (context) => RealEstateBloc(ApiService1())..add(FetchProperties()),),
            BlocProvider(create: (context) => UserCubit()),
            ChangeNotifierProvider(create: (_) => BookProvider()),
            ChangeNotifierProvider(create: (_) => FavoritePrvider()),
          ],
          child: GetMaterialApp(
            
              title: 'Real Estate',
              theme: ThemeService().lightTheme,
              darkTheme: ThemeService().darkTheme,
              themeMode: ThemeService().getThemeMode(),
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                // AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: const [
                // Locale('en'), // English
                Locale('ar'), // Arabic
              ],
              locale: LocaleService().getLocale(),
              localeResolutionCallback: (locale, supportedLocales) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale?.languageCode) {
                    return supportedLocale;
                  }
                }
                
                return supportedLocales.first;
              },
              home: TapScrean()));
}
