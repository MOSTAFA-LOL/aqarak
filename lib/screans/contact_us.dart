import 'package:flutter/material.dart';
import 'package:emailjs/emailjs.dart' as emailjs;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aqarak/cubit/user_cubit.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _inquiryTypeController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    try {
      emailjs.init(const emailjs.Options(
        publicKey: 'SbM6lp_8WtqxEQPLm',
      ));
      print('EmailJS initialized successfully');
    } catch (e) {
      print('Error initializing EmailJS: $e');
    }
    // Fill user data if available
    final userCubit = context.read<UserCubit>();
    _nameController.text = userCubit.currentUserName ?? '';
    _emailController.text = userCubit.currentUserEmail ?? '';
    _phoneController.text = userCubit.currentUserPhone ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _inquiryTypeController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<bool> sendEmail(Map<String, dynamic> templateParams) async {
    try {
      // Using the most basic EmailJS template variables
      final params = {
        'to_name': 'Admin',
        'from_name': templateParams['name'],
        'from_email': templateParams['email'],
        'phone_number': templateParams['phone'],
        'subject': templateParams['inquiry_type'],
        'message_html': templateParams['message'],
      };

      print('Sending email with params: $params'); // Debug log

      await emailjs.send(
        'service_fyj452h',
        'template_q25l7nr',
        params,
        const emailjs.Options(
          publicKey: 'SbM6lp_8WtqxEQPLm',
        ),
      );
      print('SUCCESS!');
      return true;
    } catch (error) {
      if (error is emailjs.EmailJSResponseStatus) {
        print('EmailJS Error Details:');
        print('Status: ${error.status}');
        print('Text: ${error.text}');
      }
      print('Full error: $error');
      return false;
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final templateParams = {
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'inquiry_type': _inquiryTypeController.text,
        'message': _messageController.text,
        'from_name': _nameController.text,
        'reply_to': _emailController.text,
      };
      bool result = await sendEmail(templateParams);
      if (result) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('تم الارسال'),
              content: Text('تم ارسال رسالتك بنجاح'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('حسنا'),
                ),
              ],
            ),
          );
        }
      } else {
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('خطأ'),
              content: Text('حدث خطأ أثناء إرسال الرسالة'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('حسنا'),
                ),
              ],
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اتصل بنا'),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContactInfo(),
            SizedBox(height: 30),
            _buildContactForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'معلومات عننا',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[800],
            ),
          ),
          SizedBox(height: 15),
          _buildContactRow(Icons.location_on, '123 Main Street, City, Country'),
          _buildContactRow(Icons.phone, '+1 234 567 890'),
          _buildContactRow(Icons.email, 'contact@example.com'),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey, size: 20),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'تواصل معنا',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'الاسم',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك ادخل اسمك';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'البريد الالكتروني',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك ادخل ايميلك';
                  }
                  if (!value.contains('@')) {
                    return 'من فضلك ادخل ايميل صحيح';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'رقم الهاتف',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك ادخل رقم هاتفك';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _inquiryTypeController,
                decoration: InputDecoration(
                  labelText: 'نوع الاستفسار',
                  prefixIcon: Icon(Icons.category),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك ادخل نوع الاستفسار';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(
                  labelText: 'رسالتك',
                  prefixIcon: Icon(Icons.message),
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك اكتب رسالتك';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'ارسال',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}