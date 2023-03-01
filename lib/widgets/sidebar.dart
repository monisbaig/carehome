import 'package:carehome/View/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../View/SignUp.dart';

class SidebarPage extends StatefulWidget {
  const SidebarPage({Key? key}) : super(key: key);

  @override
  State<SidebarPage> createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xfffaeaea),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
                height: 70.h,
                width: 700.w,
                decoration: BoxDecoration(
                  color: const Color(0xfff9bfc8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset('assets/images/final-01.png'),
              ),
              SizedBox(height: 30.h),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
                child: Text(
                  'Profile',
                  style: TextStyle(
                    color: const Color(0xff969bc5),
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              GestureDetector(
                onTap: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.setBool('Logined', false);
                  pref.setString('token', 'asdf');
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpPage(),
                    ),
                    (route) => false,
                  );
                },
                child: Text(
                  'Logout',
                  style: TextStyle(
                    color: const Color(0xff969bc5),
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
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
