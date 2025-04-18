// ignore_for_file: avoid_print



import 'package:aqarak/screans/tap_screan.dart';
import 'package:flutter/material.dart';



class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
//التحكم في حاله النموذج مما يساعد علب تنظيم التحقق من المدخلا
  final _formKey = GlobalKey<FormState>();
  // Variables to store input values
  String? name, email, phone, password, confirmPassword;
    Color color = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'انشاء حساب جديد '
        ),
        centerTitle: true,),
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
              SizedBox(height: 11,),
              // Name Field
              TextFormField(
                cursorColor: color,
                style:Theme.of(context).textTheme.titleMedium,
                strutStyle: StrutStyle(),
                decoration: InputDecoration(
                  labelStyle: Theme.of(context).textTheme.titleMedium,
                  labelText: 'الاسم ',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                onSaved: (value) => name = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'الرجاء إدخال الاسم';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Email Field
              TextFormField(
                style:Theme.of(context).textTheme.titleSmall,
                decoration: InputDecoration(
                  labelStyle: Theme.of(context).textTheme.titleMedium,
                  labelText: 'البريد الالكتروني',
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => email = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "الرجاء إدخال البريد الإلكتروني";
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'الرجاء ادخال بريدك الالكتروني مره اخري ';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Phone Number Field
              TextFormField(
                style:Theme.of(context).textTheme.titleSmall,
                decoration: InputDecoration(
                  labelStyle:Theme.of(context).textTheme.titleMedium,
                  labelText: 'رقم الهاتف',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                keyboardType: TextInputType.phone,
                onSaved: (value) => phone = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'الرجاء إدخال رقم الهاتف';
                  }
                  if (value.length >= 12) {
                    return 'لابد ان يكون الرقم 12 ';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Password Field
              TextFormField(
                style:Theme.of(context).textTheme.titleSmall,
                decoration: InputDecoration(
                    labelStyle: Theme.of(context).textTheme.titleMedium,
                    labelText: 'كلمه المرور',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    )),
                obscureText: true,
                onSaved: (value) => password = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال كلمة المرور"';
                  }
                  if (value.length < 6) {
                    return 'كلمه المرور اقل شي 6 حروف';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Confirm Password Field
              TextFormField(
                decoration: InputDecoration(
                    labelStyle: Theme.of(context).textTheme.titleMedium,
                    labelText: 'تأكيد كلمة المرور"',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    )),
                obscureText: true,
                onSaved: (value) => confirmPassword = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء تأكيد كلمة المرور';
                  }
                  // The password value will be available after onSaved has run
                  if (_formKey.currentState != null) {
                    _formKey.currentState!.save();
                    if (password != null && value != password) {
                      return 'كلمه المرور ليست متطابقه';
                    }
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState!.save();
                    print('$name');
                    print('$email');
                    print('$phone');
                    print('$password');
                    // Process the registration data here
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('تم تاكيد الحساب ')),
                    );
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => TapScrean()));
                  }
                },
                child: Text('انشاء حسابك الخاص بك',
                style: TextStyle(color: color),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
