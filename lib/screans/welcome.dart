
import 'package:aqarak/screans/auth.dart';

import 'package:flutter/material.dart';


class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

Color color = Colors.blueAccent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: content(),
      
    );
  }

  Widget content() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Image.asset(
            'assets/images/colorkit.jpg',
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          "للتسويق العقاري",
            style: TextStyle(
                color: const Color.fromARGB(193, 17, 22, 32),
                fontWeight: FontWeight.bold,
                fontSize: 40)),
        SizedBox(
          height: 10,
        ),
        Text(
          "لربطك بمنزل أحلامك",
          // ignore: deprecated_member_use
          style: TextStyle(fontSize: 22,
            // ignore: deprecated_member_use
            color: Colors.black87.withOpacity(.6)),
        ),
        SizedBox(
          height: 50,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => AuthScrean()));
          },
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.blueAccent)),
          child: Text('مرحبًا',
              style: TextStyle(
                  color: const Color.fromARGB(235, 253, 253, 253),
                  fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}
