import 'package:aqarak/screans/register.dart';
import 'package:aqarak/screans/tap_screan.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import 'package:realestate/screans/homepage.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

Color color = Colors.blueAccent;

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String? email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تسجيل الدخول '),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Image.asset(
                'assets/images/R.png', // Replace with your image path

                height: 200, // Adjust the height as needed
              ),
              SizedBox(height: 15),
              Text('ادخل البريد الالكتروني ',
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(
                height: 10,
              ),

              TextFormField(
                style: Theme.of(context).textTheme.titleSmall,
                decoration: InputDecoration(
                    labelStyle: Theme.of(context).textTheme.titleMedium,
                    labelText: "البريدالالكتروني",
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    )),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => email = value,
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.contains('a')) {
                    return "الرجاء إدخال البريد الإلكتروني";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              // password
              TextFormField(
                style: Theme.of(context).textTheme.titleSmall,
                obscureText: true,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: color,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: const Color.fromARGB(255, 5, 139, 241)),
                  ),
                  suffix: Icon(
                    Icons.visibility,
                    color: const Color.fromARGB(255, 141, 141, 141),
                  ),
                  hintText: "أدخل كلمة المرور",
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => password = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return " الرجاء ادخال كلمه المرور الصحيحه";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState!.save();

                    // ignore: avoid_print
                    print('$email');
                    // ignore: avoid_print
                    print('$password');
                    // Process the registration data here
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('text_field13')),
                    );
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => TapScrean()));
                  }
                },
                child: Text(
                  'تاكيد التسجيل  ',
                  style: TextStyle(color: color),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Register(),
                        ));
                  },
                  child: Center(
                      child: Text(
                    "اذا لم يكن لديك حساب انشاء الان",
                    style: TextStyle(color: color, fontStyle: FontStyle.italic),
                  )))
            ],
          ),
        ),
      ),
    );
  }
}
