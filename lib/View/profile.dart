import 'package:carehome/View/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'AuthController.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double rating = 1.0;

  Widget textField({required String text, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      height: 60.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey.shade100,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade400, spreadRadius: 1, blurRadius: 10)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          Icon(
            icon,
            size: 20.sp,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: AuthController().getUserData(),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? const Padding(
                        padding: EdgeInsets.only(top: 350),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20.h, left: 10.w),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const Home(),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios_outlined,
                                    size: 22.sp,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    'Profile',
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 60.r,
                                    backgroundColor: Colors.grey.shade300,
                                    backgroundImage: NetworkImage(
                                      '${snapshot.data?.data?.image}',
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    '${snapshot.data!.data!.groupName}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    '${snapshot.data!.data!.accountantEmail}',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 10.h, left: 20.w, right: 20.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 15.h),
                                textField(
                                  text: '${snapshot.data!.data!.name}',
                                  icon: Icons.person,
                                ),
                                SizedBox(height: 10.h),
                                textField(
                                  text: '${snapshot.data!.data!.address}',
                                  icon: Icons.home,
                                ),
                                SizedBox(height: 10.h),
                                textField(
                                  text: '${snapshot.data!.data!.postalCode}',
                                  icon: Icons.post_add,
                                ),
                                SizedBox(height: 10.h),
                                textField(
                                  text: '${snapshot.data!.data!.contactNumber}',
                                  icon: Icons.contact_mail,
                                ),
                                SizedBox(height: 10.h),
                                textField(
                                  text: '${snapshot.data!.data!.managerName}',
                                  icon: Icons.manage_accounts,
                                ),
                                SizedBox(height: 10.h),
                                SizedBox(height: 20.h),
                              ],
                            ),
                          ),
                        ],
                      );
              }),
        ),
      ),
    );
  }
}
