import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<dynamic> favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getString('favorites') ?? '[]';
    setState(() {
      favorites = jsonDecode(favoritesJson);
    });
  }

// Future<void> _removeFavorite(Map<String, dynamic> property) async {
//   final prefs = await SharedPreferences.getInstance();
//   final favoritesJson = prefs.getString('favorites') ?? '[]';
//   List<dynamic> updatedFavorites = jsonDecode(favoritesJson);
//   updatedFavorites.removeWhere((fav) => fav['id'] == property['id']);
//   await prefs.setString('favorites', jsonEncode(updatedFavorites));
//   setState(() {
//     favorites = updatedFavorites;
//   });
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: const Text('تمت الإزالة من المفضلة'),
//       backgroundColor: Colors.green,
//       duration: const Duration(seconds: 2),
//     ),
//   );
// }
Future<void> _removeFavorite(int index) async {
    final prefs = await SharedPreferences.getInstance();
    favorites.removeAt(index);
    await prefs.setString('reservations', jsonEncode(favorites));
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
          'العقارات المفضلة',
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
      body:
          favorites.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'لا توجد عقارات مفضلة بعد',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'أضف عقارات إلى قائمة المفضلة الخاصة بك!',
                      style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 12),

                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final property = favorites[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
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
                                  value:
                                      loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress
                                                  .expectedTotalBytes!
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
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                        ),
                        onPressed:
                            () => showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    title: const Text('تأكيد الحذف'),
                                    content: const Text(
                                      'هل أنت متأكد من حذف هذا الحجز؟',
                                    ),
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
                                          _removeFavorite(index);
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'حذف',
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                          ),
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
