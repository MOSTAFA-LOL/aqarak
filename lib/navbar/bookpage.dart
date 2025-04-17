import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bookpage extends StatefulWidget {
  const Bookpage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookpageState createState() => _BookpageState();
}

class _BookpageState extends State<Bookpage> {
  List<dynamic> reservations = [];

  @override
  void initState() {
    super.initState();
    _loadReservations();
  }

  Future<void> _loadReservations() async {
    final prefs = await SharedPreferences.getInstance();
    final reservationsJson = prefs.getString('reservations') ?? '[]';
    setState(() {
      reservations = jsonDecode(reservationsJson);
    });
  }

  Future<void> _deleteReservation(int index) async {
    final prefs = await SharedPreferences.getInstance();
    reservations.removeAt(index); // إزالة العنصر من القائمة
    await prefs.setString(
      'reservations',
      jsonEncode(reservations),
    ); // تحديث SharedPreferences
    setState(() {
      // تحديث واجهة المستخدم
    });

    // عرض رسالة تأكيد
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم حذف الحجز بنجاح!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'العقارات المحجوزة',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1A73E8),
        elevation: 0,
      ),
      body:
          reservations.isEmpty
              ? const Center(
                child: Text(
                  'لا توجد عقارات محجوزة بعد',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
              : ListView.builder(
                itemCount: reservations.length,
                itemBuilder: (context, index) {
                  final property = reservations[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      leading: Image.network(
                        property['propertyImages'][0] ??
                            'https://via.placeholder.com/150',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/placeholder.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      title: Text(
                        property['propertyTitle'] ?? 'عنوان غير متوفر',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'السعر: \$${property['price'] ?? 'غير متوفر'}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'المساحة: ${property['area'] ?? 'غير متوفر'} م²',
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed:
                                () => showDialog(
                                  context: context,
                                  builder:
                                      (context) => AlertDialog(
                                        title: const Text('تأكيد الحذف'),
                                        content: const Text(
                                          'هل أنت متأكد من حذف هذا الحجز؟',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed:
                                                () => Navigator.pop(context),
                                            child: const Text('إلغاء'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              _deleteReservation(index);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('حذف'),
                                          ),
                                        ],
                                      ),
                                ),
                            tooltip: 'حذف الحجز',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
