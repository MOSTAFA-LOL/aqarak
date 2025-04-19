import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bookpage extends StatefulWidget {
  const Bookpage({super.key});

  @override
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
    reservations.removeAt(index);
    await prefs.setString('reservations', jsonEncode(reservations));
    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('تم حذف الحجز بنجاح!'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
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
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1A73E8), Color(0xFF4A90E2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 2,
      ),
      body: reservations.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_border,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'لا توجد عقارات محجوزة بعد',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ابدأ بإضافة عقارات إلى قائمتك!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: reservations.length,
              itemBuilder: (context, index) {
                final property = reservations[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        property['propertyImages'][0] ??
                            'https://via.placeholder.com/150',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey[200],
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/placeholder.png',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    title: Text(
                      property['propertyTitle'] ?? 'عنوان غير متوفر',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          'السعر: \$${property['price'] ?? 'غير متوفر'}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'المساحة: ${property['area'] ?? 'غير متوفر'} م²',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          title: const Text('تأكيد الحذف'),
                          content: const Text('هل أنت متأكد من حذف هذا الحجز؟'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                'إلغاء',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                _deleteReservation(index);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'حذف',
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            ),
                          ],
                        ),
                      ),
                      tooltip: 'حذف الحجز',
                    ),
                  ),
                );
              },
            ),
    );
  }
}