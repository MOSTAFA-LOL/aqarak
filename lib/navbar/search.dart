// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:aqarak/screans/housedetalesscrean.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final String propertyKey;
  final String propertyValue;
  final String propertyImage;

  const Search({
    super.key,
    required this.propertyKey,
    required this.propertyValue,
    required this.propertyImage,
  });

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<dynamic> users = [];
  List<dynamic> filteredUsers = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchUsers(); // جلب البيانات عند تحميل الصفحة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('بحث عن ${widget.propertyKey}'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: PropertySearchDelegate(users: users, onSearch: (results) {
                  filteredUsers = results;
                }),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
          child: Column(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     GestureDetector(
              //       onTap: fetchUsers,
              //       child: const Text(
              //         'عرض المزيد',
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 16,
              //           color: Colors.blueAccent,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                width: double.infinity,
                child: Text(
                  '${widget.propertyValue} ${widget.propertyKey}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 7),
              SizedBox(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : errorMessage != null
                        ? Center(child: Text(errorMessage!))
                        : (filteredUsers.isNotEmpty ? filteredUsers : users).isEmpty
                            ? const Center(child: Text('لا توجد عقارات متاحة لهذا القسم',style: TextStyle(color:Colors.blueAccent)))
                            : secondcard(filteredUsers.isNotEmpty ? filteredUsers : users),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget secondcard(List<dynamic> data) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        mainAxisExtent: 288,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final user = data[index];
        final name = user['propertyTitle'];
        final status = user['status'];
        final price = user['price'];
        final propertyType = user['propertyType'];
        // final city = user['city'];
        // final totalRooms = user['totalRooms'];
        // final bathrooms = user['bathrooms'];
        // final bedrooms = user['bedrooms'];
        // final description = user['description'];
        // final area = user['area'];
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
                  // ignore: deprecated_member_use
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
                            // ignore: deprecated_member_use
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
                              // ignore: deprecated_member_use
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
                              // ignore: deprecated_member_use
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
        final allUsers = json['\$values'];
        // تصفية العقارات بناءً على نوع العقار (propertyKey)
        final filtered = allUsers.where((user) {
          return user['propertyType'].toString().toLowerCase() == widget.propertyKey.toLowerCase();
        }).toList();
        setState(() {
          users = filtered;
          filteredUsers = filtered; // تهيئة البحث بنفس البيانات المصفاة
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

// كلاس مخصص لتفعيل البحث (بدون تغييرات كبيرة)
class PropertySearchDelegate extends SearchDelegate {
  final List<dynamic> users;
  final Function(List<dynamic>) onSearch;

  PropertySearchDelegate({required this.users, required this.onSearch});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          onSearch(users);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = users.where((user) {
      final title = user['propertyTitle'].toString().toLowerCase();
      final city = user['city'].toString().toLowerCase();
      final propertyType = user['propertyType'].toString().toLowerCase();
      final searchQuery = query.toLowerCase();
      return title.contains(searchQuery) || city.contains(searchQuery) || propertyType.contains(searchQuery);
    }).toList();

    onSearch(results);

    return results.isEmpty
        ? const Center(child: Text('لا توجد نتائج مطابقة',style: TextStyle(color:Colors.blueAccent)))
        : GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              mainAxisExtent: 288,
            ),
            itemCount: results.length,
            itemBuilder: (context, index) {
              final user = results[index];
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
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
                                  // ignore: deprecated_member_use
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
                              ),
                              const SizedBox(height: 8),
                              Text(
                                propertyType,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    // ignore: deprecated_member_use
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
                                    // ignore: deprecated_member_use
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

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = users.where((user) {
      final title = user['propertyTitle'].toString().toLowerCase();
      final city = user['city'].toString().toLowerCase();
      final propertyType = user['propertyType'].toString().toLowerCase();
      final searchQuery = query.toLowerCase();
      return title.contains(searchQuery) || city.contains(searchQuery) || propertyType.contains(searchQuery);
    }).toList();

    return suggestions.isEmpty
        ? const Center(child: Text('لا توجد اقتراحات',style: TextStyle(color:Colors.blueAccent),))
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final user = suggestions[index];
              final name = user['propertyTitle'];
              final propertyType = user['propertyType'];
              final city = user['city'];

              return ListTile(
                title: Text(name, style: Theme.of(context).textTheme.titleMedium,),
                subtitle: Text('$propertyType - $city',
                  style: Theme.of(context).textTheme.titleMedium,),
                onTap: () {
                  query = name;
                  showResults(context);
                },
              );
            },
          );
  }
}