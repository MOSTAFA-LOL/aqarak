import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HouseDetalesScrean extends StatefulWidget {
  final Map<String, dynamic> property;
  final List<String> propertyImages;

  const HouseDetalesScrean({
    super.key,
    required this.property,
    required this.propertyImages,
  });

  @override
  _HouseDetalesScreanState createState() => _HouseDetalesScreanState();
}

class _HouseDetalesScreanState extends State<HouseDetalesScrean> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite(); // تحقق مما إذا كان العقار مفضلاً عند تحميل الصفحة
  }

  // تحقق مما إذا كان العقار موجودًا في المفضلة
  Future<void> _checkIfFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getString('favorites') ?? '[]';
    final List<dynamic> favorites = jsonDecode(favoritesJson);
    setState(() {
      _isFavorite = favorites.any((fav) => fav['id'] == widget.property['id']);
    });
  }

  // إضافة/إزالة العقار من المفضلة
  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getString('favorites') ?? '[]';
    List<dynamic> favorites = jsonDecode(favoritesJson);

    if (_isFavorite) {
      // إزالة العقار من المفضلة
      favorites.removeWhere((fav) => fav['id'] == widget.property['id']);
    } else {
      // إضافة العقار إلى المفضلة
      favorites.add({
        'id': widget.property['id'],
        'propertyTitle': widget.property['propertyTitle'],
        'status': widget.property['status'],
        'price': widget.property['price'],
        'propertyType': widget.property['propertyType'],
        'propertyImages': widget.propertyImages,
        'city': widget.property['city'],
        'totalRooms': widget.property['totalRooms'],
        'bathrooms': widget.property['bathrooms'],
        'bedrooms': widget.property['bedrooms'],
        'description': widget.property['description'],
        'area': widget.property['area'],
      });
    }

    await prefs.setString('favorites', jsonEncode(favorites));
    setState(() {
      _isFavorite = !_isFavorite;
    });

    // عرض رسالة تأكيد
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isFavorite ? 'تمت الإضافة إلى المفضلة' : 'تمت الإزالة من المفضلة'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.property['propertyTitle'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1A73E8),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: const Color.fromARGB(255, 194, 32, 32),
            ),
            onPressed: _toggleFavorite,
            tooltip: _isFavorite ? 'إزالة من المفضلة' : 'إضافة إلى المفضلة',
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 250,
            child: widget.propertyImages.isNotEmpty
                ? PageView.builder(
                    itemCount: widget.propertyImages.length,
                    itemBuilder: (context, index) {
                      final image = widget.propertyImages[index];
                      return Stack(
                        children: [
                          Image.network(
                            image.isNotEmpty ? image : 'https://via.placeholder.com/150',
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/placeholder.png',
                                height: 250,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.5),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 16,
                            left: 16,
                            child: Text(
                              widget.property['propertyTitle'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${index + 1}/${widget.propertyImages.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                : Image.asset(
                    'assets/images/bec1a4fa3ce5cd83809725ef5dc9e9a9.jpg',
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow(
                  icon: Icons.attach_money,
                  label: 'السعر',
                  value: '\$${widget.property['price']}',
                  color: Colors.green,
                ),
                const SizedBox(height: 16),
                _buildDetailRow(
                  icon: Icons.location_on,
                  label: 'العنوان',
                  value: widget.property['address'] ?? 'غير متوفر',
                ),
                const SizedBox(height: 16),
                _buildDetailRow(
                  icon: Icons.meeting_room,
                  label: 'عدد الغرف',
                  value: '${widget.property['totalRooms'] ?? 'غير متوفر'}',
                ),
                const SizedBox(height: 16),
                _buildDetailRow(
                  icon: Icons.bathtub,
                  label: 'عدد الحمامات',
                  value: '${widget.property['bathrooms'] ?? 'غير متوفر'}',
                ),
                const SizedBox(height: 16),
                _buildDetailRow(
                  icon: Icons.stairs,
                  label: 'رقم الطابق',
                  value: '${widget.property['floorNumber'] ?? 'غير متوفر'}',
                ),
                const SizedBox(height: 16),
                _buildDetailRow(
                  icon: Icons.square_foot,
                  label: 'المساحة',
                  value: '${widget.property['area'] ?? 'غير متوفر'} متر مربع',
                ),
                const SizedBox(height: 16),
                const Text(
                  'الوصف',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A73E8),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.property['description'] ?? 'لا يوجد وصف متاح',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    Color? color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: color ?? const Color(0xFF1A73E8),
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}