



import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LocaleService {
  final _storage = GetStorage();
  final _key = 'locale';

  Locale getLocale() {
    final langCode = _storage.read(_key) ?? 'ar';
    return Locale(langCode);
  }

    setLocale(Locale locale) async {
    await _storage.write(_key, locale.languageCode);
  }
}

  
