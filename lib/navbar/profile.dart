// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:aqarak/Theme/theme.dart';
import 'package:aqarak/navbar/bookpage.dart';
import 'package:aqarak/navbar/saved.dart';
import 'package:aqarak/provider/book_provider.dart';
import 'package:aqarak/screans/Privacy%20Policy.dart';
import 'package:aqarak/screans/Terms%20of%20Service.dart';
import 'package:aqarak/screans/auth.dart';
import 'package:aqarak/screans/contact_us.dart';
import 'package:aqarak/cubit/user_cubit.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Profile extends StatefulWidget {
  const Profile({
    super.key,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Color color = Colors.blueAccent;
  @override
  Widget build(BuildContext context) {
    final moonIcon = CupertinoIcons.moon_stars;
    // final sunIcon = CupertinoIcons.sun_max;
    BookProvider.of(context);
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'الملف الشخصي',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  
                  IconButton(
                      onPressed: () {
                        ThemeService().changeTheme();
                      },
                      icon: Icon(
                        moonIcon,
                        color: color,
                      )),
                ],
              ),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                      margin: const EdgeInsets.all(8),
                      child: CircleAvatar(
                        radius: 40, // Adjusted for better proportionality
                        backgroundImage: NetworkImage(
                          (context.read<UserCubit>().currentUserImage?.isNotEmpty ?? false)
                              ? context.read<UserCubit>().currentUserImage!
                              : 'https://res.cloudinary.com/dizj9rluo/image/upload/v1744113485/defaultPerson_e7w75t.jpg',
                        ),
                        backgroundColor: Colors.grey.shade200, // Fallback color
                      ),
                    )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                context.read<UserCubit>().currentUserName ?? ' اسم المستخدم',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 12,
              ),
              Divider(),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Bookpage(),
                          ));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          // ignore: deprecated_member_use
                          color: color,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'حجوزاتي',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(
                          width: 211,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: color,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavoritesScreen(),
                          ));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.bookmark_added,
                          // ignore: deprecated_member_use
                          color: color,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'المحفوظات',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(
                          width: 200,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: color,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Divider(),
              SizedBox(
                height: 5,
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Terms_of_service(),
                          ));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          // ignore: deprecated_member_use
                          color: color,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'شروط الخدمة',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(width: 188),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: color,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrivacyPolicyPage(),
                          ));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          // ignore: deprecated_member_use
                          color: color,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'سياسة الخصوصية',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(
                          width: 168,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: color,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactUsScreen(),
                          ));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.call,
                          // ignore: deprecated_member_use
                          color: color,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'اتصل بنا',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(
                          width: 214,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: color,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.language,
                        // ignore: deprecated_member_use
                        color: color,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        'اللغه  🇪🇬',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(
                        width: 211,
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: color,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AuthScrean(),
                          ));
                      
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,

                          // ignore: deprecated_member_use
                          color: Colors.redAccent.withOpacity(.7),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'تسجيل الخروج',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
 //محاذاه الي اليمين
          