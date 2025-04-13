import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:aqarak/main.dart';

class ThemeService {
  final lightTheme = ThemeData().copyWith(
      colorScheme: myColorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: myColorScheme.onPrimaryContainer,
        foregroundColor: myColorScheme.primaryContainer,
        
      ),
      cardTheme: const CardTheme().copyWith(
          color: myColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          elevation: 0,
          backgroundColor: myColorScheme.onPrimary,
          foregroundColor: myColorScheme.onPrimaryContainer
        ),
      ),
      textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: myColorScheme.onSecondaryContainer,
              fontSize: 20),
                titleMedium:TextStyle(
              fontWeight: FontWeight.bold,
              color: myColorScheme.onSecondaryContainer,
              fontSize: 16,fontStyle: FontStyle.italic),
              titleSmall:TextStyle(
              fontWeight: FontWeight.normal,
              color: myColorScheme.onSecondaryContainer,
              fontSize: 13,fontStyle: FontStyle.italic)));

  final darkTheme = ThemeData.dark().copyWith(
      colorScheme: myColorScheme,
      bottomSheetTheme: const BottomSheetThemeData()
          .copyWith(backgroundColor: myDarkColorScheme.onPrimaryContainer),
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: myDarkColorScheme.onPrimaryContainer,
        foregroundColor: myDarkColorScheme.onPrimary,
      ),
      cardTheme: const CardTheme().copyWith(
          color: myDarkColorScheme.onPrimaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          
          padding: const EdgeInsets.all(12),
          backgroundColor: myDarkColorScheme.primaryContainer,
          foregroundColor: myDarkColorScheme.onPrimaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          elevation: 0,
        ),
      ),
      textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: myDarkColorScheme.onPrimary,
              fontSize: 20,fontStyle: FontStyle.italic
              ),
              titleMedium:TextStyle(
              fontWeight: FontWeight.bold,
              color: myDarkColorScheme.onPrimary,
              fontSize: 16,fontStyle: FontStyle.italic),
              titleSmall:TextStyle(
              fontWeight: FontWeight.normal,
              color: myDarkColorScheme.onPrimary,
              fontSize: 13,fontStyle: FontStyle.italic)
              ));

  final _getStorage = GetStorage();
  final _darkThemeKey = "isDarkTheme";

  void saveThemeData(bool isDarkMode) {
    _getStorage.write(_darkThemeKey, isDarkMode);
  }

  bool isSavedDarkMode() {
    return _getStorage.read(_darkThemeKey) ?? false;
  }

  ThemeMode getThemeMode() {
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  void changeTheme() {
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeData(!isSavedDarkMode());
  }
  
}




