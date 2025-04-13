import 'package:flutter/material.dart';



import 'package:aqarak/main.dart';

class Languagemenu extends StatefulWidget {
  const Languagemenu({super.key});

  @override
  State<Languagemenu> createState() => _Languagemenu();
}

class _Languagemenu extends State<Languagemenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Locale>(
      // value: AppLocalizations.of(context)?.locale,
      onChanged: (Locale? value) {
        if (value != null) {
          setState(() {
            MyApp.of(context)!.setLocale(value);
          });
        }
      },
      items: const [
        DropdownMenuItem(value: Locale('en'), child: Text('English 🇺🇸 ')),
        DropdownMenuItem(value: Locale('ar'), child: Text('🇪🇬 العربية ' )),
        
      ],
    );
  }
}

// extension on AppLocalizations {
//   get locale => null;
// }
