import 'dart:convert';
import 'package:aqarak/navbar/search.dart';
import 'package:aqarak/screans/housedetalesscrean.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: Image.network(
                        'https://res.cloudinary.com/dizj9rluo/image/upload/v1744113485/defaultPerson_e7w75t.jpg',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'صباح الخير',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'اسم المالك',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'اقسام العقارات',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: propertyTypes
                        .map((type) => _buildPropertyTypeButton(
                              context: context,
                              type: type,
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'توصيات',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
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
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : errorMessage != null
                          ? Center(child: Text(errorMessage!))
                          : users.isEmpty
                              ? const Center(child: Text('لا توجد بيانات متاحة'))
                              : card(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget card() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 22,
        crossAxisSpacing: 11,
        mainAxisExtent: 422,
      ),
      itemCount: users.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final user = users[index];
        final name = user['propertyTitle'];
        final status = user['status'];
        final price = user['price'];
        final propertyType = user['propertyType'];
        final image = user['propertyImages']['\$values'][1];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => HouseDetalesScrean(
                  property: user,
                  propertyImages: List<String>.from(user['propertyImages']['\$values'] ?? []),
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  Image.network(
                    image.isNotEmpty ? image : 'https://via.placeholder.com/150',
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                          ],
                          stops: const [0, 1],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status == 'For Rent' ? 'للإيجار' : 'للبيع',
                        style: const TextStyle(
                          color: Color.fromARGB(157, 18, 126, 4),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          strutStyle: const StrutStyle(),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          propertyType,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white.withOpacity(0.9)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$$price',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white.withOpacity(0.9)),
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
        builder: (_) => Search(
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