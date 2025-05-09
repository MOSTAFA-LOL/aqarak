import 'dart:convert';
import 'package:aqarak/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getString('favorites') ?? '[]';
    final List<dynamic> favorites = jsonDecode(favoritesJson);
    setState(() {
      _isFavorite = favorites.any((fav) => fav['id'] == widget.property['id']);
    });
  }

  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getString('favorites') ?? '[]';
    List<dynamic> favorites = jsonDecode(favoritesJson);

    favorites.add({
      'id': widget.property['id'],
      'propertyTitle': widget.property['propertyTitle'] ?? 'عنوان غير متوفر',
      'status': widget.property['status'] ?? 'غير متوفر',
      'price': widget.property['price'] ?? 'غير متوفر',
      'propertyType': widget.property['propertyType'] ?? 'غير متوفر',
      'propertyImages': widget.propertyImages,
      'city': widget.property['city'] ?? 'غير متوفر',
      'totalRooms': widget.property['totalRooms'] ?? 'غير متوفر',
      'bathrooms': widget.property['bathrooms'] ?? 'غير متوفر',
      'bedrooms': widget.property['bedrooms'] ?? 'غير متوفر',
      'description': widget.property['description'] ?? 'لا يوجد وصف متاح',
      'area': widget.property['area'] ?? 'غير متوفر',
    });

    await prefs.setString('favorites', jsonEncode(favorites));
    setState(() {
      _isFavorite = !_isFavorite;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isFavorite ? 'تمت الإضافة إلى المفضلة' : 'تمت الإزالة من المفضلة',
          ),
          backgroundColor: _isFavorite ? Colors.green : Colors.redAccent,
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  Future<void> _reserveProperty() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        'user_id',
        'user123',
      ); // Replace with actual user ID
      final reservationsJson = prefs.getString('reservations') ?? '[]';
      final List<dynamic> reservations = jsonDecode(reservationsJson);

      reservations.add({
        'propertyTitle': widget.property['propertyTitle'] ?? 'عنوان غير متنوفر',
        'status': widget.property['status'] ?? 'غير متوفر',
        'price': widget.property['price'] ?? 'غير متوفر',
        'propertyImages': widget.propertyImages,
        'area': widget.property['area'] ?? 'غير متوفر',
      });

      await prefs.setString('reservations', jsonEncode(reservations));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم حجز العقار بنجاح!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
      print('Reserve error: $e');
      print('Property: ${widget.property}');
    }
  }

  Future<void> _reserveProperty1() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    // جلب التوكن من SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    // ignore: use_build_context_synchronously
    final token = context.read<UserCubit>().currentUserToken;
    // ignore: unused_local_variable
    final id = context.read<UserCubit>().currentUserId;

    // نافذة تأكيد
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            widget.property['status'] == 'For Rent'
                ? 'تأكيد طلب الإيجار'
                : 'تأكيد طلب الشراء',
            textAlign: TextAlign.right,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'هل أنت متأكد من رغبتك في ${widget.property['status'] == 'For Rent' ? 'إيجار' : 'شراء'} هذا العقار؟',
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 10),
              Text(
                'سيتم التواصل معك قريباً لتأكيد الطلب',
                style: TextStyle(color: Colors.grey[600]),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A73E8),
              ),
              child: const Text('تأكيد'),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    try {
      final propertyOrder = {
        'userToken': token,
        'property': {
          ...widget.property,
          'createdAt': widget.property['createdAt'] ?? DateTime.now().toIso8601String(),
        },
        'TypeOrder': 'Pending',
        'clientId': id,
      };
      print(propertyOrder);
      
      // تحديد الجدول حسب حالة العقار
      final tableName = widget.property['status'] == 'For Rent' ? 'RentOrders' : 'PurchaseOrders';
      final response = await supabase.from(tableName).insert([
        propertyOrder,
      ]);

      if (response.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'حدث خطأ أثناء إتمام العملية: ${response.error!.message}',
            ),
            backgroundColor: Colors.red,
          ),
        );  
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                widget.property['status'] == 'For Rent'
                    ? 'تم تقديم طلب الإيجار بنجاح! سيتم التواصل معك قريباً'
                    : 'تم تقديم طلب الشراء بنجاح! سيتم التواصل معك قريباً',
              ),
            backgroundColor:  Colors.green,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              widget.property['status'] == 'For Rent'
                  ? 'تم تقديم طلب الإيجار بنجاح! سيتم التواصل معك قريباً'
                  : 'تم تقديم طلب الشراء بنجاح! سيتم التواصل معك قريباً',
            ),
          backgroundColor:  Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.property['propertyTitle'] ?? 'عنوان غير متوفر',
          style: const TextStyle(
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
        actions: [
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                key: ValueKey<bool>(_isFavorite),
                color: Colors.redAccent,
              ),
            ),
            onPressed: _toggleFavorite,
            tooltip: _isFavorite ? 'إزالة من المفضلة' : 'إضافة إلى المفضلة',
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              SizedBox(
                height: 280,
                child:
                    widget.propertyImages.isNotEmpty
                        ? Stack(
                          children: [
                            PageView.builder(
                              itemCount: widget.propertyImages.length,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentImageIndex = index;
                                });
                              },
                              itemBuilder: (context, index) {
                                final image = widget.propertyImages[index];
                                return Stack(
                                  children: [
                                    Image.network(
                                      image.isNotEmpty
                                          ? image
                                          : 'https://res.cloudinary.com/dizj9rluo/image/upload/v1744113485/defaultPerson_e7w75t.jpg',
                                      height: 280,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (
                                        context,
                                        child,
                                        loadingProgress,
                                      ) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Container(
                                          height: 280,
                                          color: Colors.grey[200],
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              value:
                                                  loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                      : null,
                                            ),
                                          ),
                                        );
                                      },
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return Image.asset(
                                          'assets/images/placeholder.png',
                                          height: 280,
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
                                              Colors.black.withOpacity(0.6),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 16,
                                      left: 16,
                                      child: Text(
                                        widget.property['propertyTitle'] ??
                                            'عنوان غير متوفر',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            Positioned(
                              bottom: 16,
                              right: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${_currentImageIndex + 1}/${widget.propertyImages.length}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  widget.propertyImages.length,
                                  (index) => Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    width: _currentImageIndex == index ? 10 : 6,
                                    height:
                                        _currentImageIndex == index ? 10 : 6,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          _currentImageIndex == index
                                              ? Colors.white
                                              : Colors.white.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                        : Image.asset(
                          'assets/images/placeholder.png',
                          height: 280,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${widget.property['price'] ?? 'غير متوفر'}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    widget.property['status'] == 'For Rent'
                                        ? Colors.blueAccent
                                        : Colors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                widget.property['status'] == 'For Rent'
                                    ? 'للإيجار'
                                    : 'للبيع',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
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
                          value:
                              '${widget.property['totalRooms'] ?? 'غير متوفر'}',
                        ),
                        const SizedBox(height: 16),
                        _buildDetailRow(
                          icon: Icons.bathtub,
                          label: 'عدد الحمامات',
                          value:
                              '${widget.property['bathrooms'] ?? 'غير متوفر'}',
                        ),
                        const SizedBox(height: 16),
                        _buildDetailRow(
                          icon: Icons.stairs,
                          label: 'رقم الطابق',
                          value:
                              '${widget.property['floorNumber'] ?? 'غير متوفر'}',
                        ),
                        const SizedBox(height: 16),
                        _buildDetailRow(
                          icon: Icons.square_foot,
                          label: 'المساحة',
                          value:
                              '${widget.property['area'] ?? 'غير متوفر'} متر مربع',
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
                        const SizedBox(height: 20),
                        _buildFacilitiesSection(),
                        const SizedBox(height: 20),
                        // _buildGallerySection(),
                        const SizedBox(height: 10),
                        // _buildOverviewSection(),
                        _buildMapSection(context),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: ElevatedButton(
                onPressed: (){
                  _reserveProperty();
                  _reserveProperty1();
                  
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color(0xFF1A73E8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  shadowColor: Colors.black.withOpacity(0.3),
                ),
                child: Text(
                  widget.property['status'] == 'For Rent'
                      ? 'استأجر الآن'
                      : 'اشتري الآن',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset(
              'assets/images/map.png',
              fit: BoxFit.cover,
              errorBuilder:
                  (_, __, ___) =>
                      const Center(child: Icon(Icons.error_outline)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الاراء',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Sleek, modern 2-bedroom apartment with open businesses '
          'that read artists and educators.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildFacilitiesSection() {
    final facilities = [
      'جراج سيارات ',
      'حمامات سباحه',
      'صالات رياضيه',
      'مطاعم',
      'شبكه اتصالات ',
      'مركز للحيوانات ',
      'مراكز رياضيه ',
      'مغسله ',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المميزات',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 3,
          children:
              facilities
                  .map(
                    (facility) => Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green.shade600,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          facility,
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }

  Widget _buildGallerySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الموقع',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 12),
        _buildLocationItem('مصر الجديده 100 شارع شبرا '),
        _buildLocationItem('77 منطقه الكوربه '),
        _buildLocationItem('10 شارع وسط البلد'),
        _buildLocationItem('مديني'),
        _buildLocationItem('مدينه الرحاب '),
      ],
    );
  }

  Widget _buildLocationItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(Icons.location_on, color: Colors.red.shade600, size: 18),
          const SizedBox(width: 8),
          Text(text, style: TextStyle(color: Colors.grey.shade600)),
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
        Icon(icon, color: color ?? const Color(0xFF1A73E8), size: 24),
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
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
