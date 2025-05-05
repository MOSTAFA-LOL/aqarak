import 'dart:convert';
import 'package:aqarak/navbar/search.dart';
import 'package:aqarak/screans/housedetalesscrean.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class PropertyType {
  final String key;
  final String value;
  final String image;
  final String buttonImage;
  final String buttonLabel;
  final double imageWidth;

  const PropertyType({
    required this.key,
    required this.value,
    required this.image,
    required this.buttonImage,
    required this.buttonLabel,
    required this.imageWidth,
  });
}

class _HomepageState extends State<Homepage> {
  List<dynamic> users = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchUsers();
    
  }

  @override
  Widget build(BuildContext context) {
    final List<PropertyType> propertyTypes = [
      const PropertyType(
        key: 'Villa',
        value: 'Found 7',
        image: 'assets/images/OIF (1).jpg',
        buttonImage: 'assets/images/Villa.png',
        buttonLabel: 'فيلا',
        imageWidth: 33,
      ),

      const PropertyType(
        key: 'Apartment',
        value: 'Found 6',
        image: 'assets/images/OIF (1).jpg',
        buttonImage: 'assets/images/Apartment.png',
        buttonLabel: 'شقق',
        imageWidth: 30,
      ),
      const PropertyType(
        key: 'Office',
        value: 'Found 11',
        image: 'assets/images/OIF (1).jpg',
        buttonImage: 'assets/images/Office_1.png',
        buttonLabel: 'مكاتب',
        imageWidth: 22,
      ),
      const PropertyType(
        key: 'Shop',
        value: 'Found 4',
        image: 'assets/images/Shop.avif',
        buttonImage: 'assets/images/Shop_1.png',
        buttonLabel: 'محلات',
        imageWidth: 27,
      ),
    ];

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal:
                  MediaQuery.of(context).size.width *
                  0.04, // 4% of screen width
              vertical:
                  MediaQuery.of(context).size.height *
                  0.02, // 2% of screen height
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: CircleAvatar(
                        radius: 25, // Adjusted for better proportionality
                        backgroundImage: NetworkImage(
                          'https://res.cloudinary.com/dizj9rluo/image/upload/v1744113485/defaultPerson_e7w75t.jpg',
                        ),
                        backgroundColor: Colors.grey.shade200, // Fallback color
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'صباح الخير',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'اسم المالك',
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16, // Slightly smaller for balance
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'اقسام العقارات',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        propertyTypes
                            .map(
                              (type) => _buildPropertyTypeButton(
                                context: context,
                                type: type,
                              ),
                            )
                            .toList(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'توصيات',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: fetchUsers,
                      child: const Text(
                        'عرض المزيد',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 340,
                  child:
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : errorMessage != null
                          ? Center(child: Text(errorMessage!))
                          : users.isEmpty
                          ? const Center(child: Text('لا توجد بيانات متاحة'))
                          : card(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ترشيحات اخري',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: fetchUsers,
                      child: const Text(
                        'عرض المزيد',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 340,
                  child:
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : errorMessage != null
                          ? Center(child: Text(errorMessage!))
                          : users.isEmpty
                          ? const Center(child: Text('لا توجد بيانات متاحة'))
                          : card2(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget card() {
    return SizedBox(
      height:
          MediaQuery.of(context).size.height *
          0.45, // Responsive height (45% of screen)
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final name = user['propertyTitle'] ?? 'Unknown Property';
          final status = user['status'] ?? 'Unknown';
          final price = user['price']?.toString() ?? 'N/A';
          final propertyType = user['propertyType'] ?? 'Unknown Type';
          final image =
              user['propertyImages']?['\$values']?[1] ??
              'https://via.placeholder.com/150';

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => HouseDetalesScrean(
                        property: user,
                        propertyImages: List<String>.from(
                          user['propertyImages']?['\$values'] ?? [],
                        ),
                      ),
                ),
              );
            },
            child: Container(
              width:
                  MediaQuery.of(context).size.width *
                  0.5, // 50% of screen width for responsiveness
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    // Image with caching
                    CachedNetworkImage(
                      imageUrl: image,
                      height: 220, // Slightly reduced for better proportion
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                      errorWidget:
                          (context, url, error) => Image.network(
                            'https://via.placeholder.com/150',
                            fit: BoxFit.cover,
                          ),
                    ),
                    // Gradient overlay
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                            stops: const [0.5, 1.0],
                          ),
                        ),
                      ),
                    ),
                    // Status badge
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Text(
                          status == 'For Rent' ? 'للإيجار' : 'للبيع',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    // Property details
                    Positioned(
                      left: 12,
                      right: 12,
                      bottom: 12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            propertyType,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$$price',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget card2() {
    return SizedBox(
      height:
          MediaQuery.of(context).size.height *
          0.45, // Responsive height (45% of screen)
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final name = user['propertyTitle'] ?? 'Unknown Property';
          final status = user['status'] ?? 'Unknown';
          final price = user['price']?.toString() ?? 'N/A';
          final propertyType = user['propertyType'] ?? 'Unknown Type';
          final image =
              user['propertyImages']?['\$values']?[0] ??
              'https://via.placeholder.com/150';

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => HouseDetalesScrean(
                        property: user,
                        propertyImages: List<String>.from(
                          user['propertyImages']?['\$values'] ?? [],
                        ),
                      ),
                ),
              );
            },
            child: Container(
              width:
                  MediaQuery.of(context).size.width *
                  0.5, // 50% of screen width for responsiveness
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    // Image with caching
                    CachedNetworkImage(
                      imageUrl: image,
                      height: 220, // Slightly reduced for better proportion
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                      errorWidget:
                          (context, url, error) => Image.network(
                            'https://via.placeholder.com/150',
                            fit: BoxFit.cover,
                          ),
                    ),
                    // Gradient overlay
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                            stops: const [0.5, 1.0],
                          ),
                        ),
                      ),
                    ),
                    // Status badge
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Text(
                          status == 'For Rent' ? 'للإيجار' : 'للبيع',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    // Property details
                    Positioned(
                      left: 12,
                      right: 12,
                      bottom: 12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            propertyType,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$$price',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPropertyTypeButton({
    required BuildContext context,
    required PropertyType type,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: 100,
        child: ElevatedButton(
          onPressed: () => _navigateToSearch(context, type),
          style: Theme.of(context).elevatedButtonTheme.style,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                type.buttonImage,
                width: type.imageWidth,
                color: Theme.of(context).primaryColorLight,
              ),
              const SizedBox(height: 8),
              Text(
                type.buttonLabel,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToSearch(BuildContext context, PropertyType property) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => Search(
              propertyKey: property.key,
              propertyValue: property.value,
              propertyImage: property.image,
            ),
      ),
    );
  }

  void fetchUsers() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      const url = 'http://mohamedtahoon.runasp.net/api/Properties';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          users = json['\$values'].reversed.take(16).toList();

          isLoading = false;
        });
      } else {
        throw Exception('Failed to load properties');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'حدث خطأ أثناء جلب البيانات: $e';
      });
    }
  }

  
}
