import 'package:carehome/chat_module/chat_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/sidebar.dart';
import 'Availability.dart';
import 'Booking.dart';
import 'Documents.dart';
import 'Request.dart';
import 'SplashScreen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  GlobalKey<ScaffoldState> key = GlobalKey();
  getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    getToken();
    return Container(
      color: Colors.white,
      child: Scaffold(
        key: key,
        endDrawer: const SidebarPage(),
        backgroundColor: Colors.blue.shade50.withOpacity(0.4),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10.w, right: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/final-01.png',
                        height: 60.h,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        'Care Home',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                            color: Colors.black),
                      ),
                      SizedBox(width: 6.w),
                      GestureDetector(
                        onTap: () {
                          key.currentState!.openEndDrawer();
                        },
                        child: Container(
                          child: const Icon(
                            Icons.menu,
                            color: Colors.blue,
                            size: 33,
                          ),
                          // Image.asset(
                          //   'assets/images/Group.png',
                          //   height: 30.h,
                          //   width: 30.w,
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingPage(),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade400.withOpacity(0.7),
                              spreadRadius: 1,
                              blurRadius: 10)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Image(
                              image: const AssetImage(
                                  'assets/images/upcoming shifts.png'),
                              height: 60.h,
                              width: 60.w,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          const Text(
                            'Confirmed Bookings',
                            style: TextStyle(
                              color: Color(0xff3b53a4),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          const Text(
                            'Show All',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 10.h)
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.w, top: 20.h),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'What do you want to do?',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookingPage()));
                        },
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 10.h),
                              child: Container(
                                padding: EdgeInsets.all(10.h),
                                height: 100.h,
                                width: 168.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.orange.shade200
                                            .withOpacity(0.3),
                                        offset: const Offset(8, 8),
                                        spreadRadius: 1,
                                        blurRadius: 10)
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Container(
                                    //   margin: EdgeInsets.all(5),
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.white,
                                    //   ),
                                    //   child:Image(image: AssetImage('assets/images/bookings.png')),height: 40.h,width: 40.w,),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey.shade400
                                                    .withOpacity(0.7),
                                                spreadRadius: 1,
                                                blurRadius: 5)
                                          ],
                                          shape: BoxShape.circle),
                                      padding: EdgeInsets.all(8.h),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 5.h),
                                      width: 43.w,
                                      height: 43.h,
                                      child: Image.asset(
                                        'assets/images/newbkicon.jpg',
                                      ),
                                    ),
                                    Text(
                                      'Bookings',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Availability()));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.h),
                          margin: const EdgeInsets.only(top: 10),
                          height: 100.h,
                          width: 168.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.green.shade200.withOpacity(0.3),
                                  offset: const Offset(8, 8),
                                  spreadRadius: 1,
                                  blurRadius: 10)
                            ],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Container(
                              //   margin: EdgeInsets.all(5),
                              //   decoration: BoxDecoration(
                              //     color: Colors.white,
                              //   ),
                              //   child:Image(image: AssetImage('assets/images/availability.png')),height: 40.h,width: 40.w,),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade400
                                              .withOpacity(0.7),
                                          spreadRadius: 1,
                                          blurRadius: 5)
                                    ],
                                    shape: BoxShape.circle),
                                padding: EdgeInsets.all(8.h),
                                margin: EdgeInsets.symmetric(vertical: 5.h),
                                width: 40.w,
                                height: 40.h,
                                child: SvgPicture.asset(
                                    'assets/images/availability icon.svg'),
                              ),
                              Text(
                                'Availability',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Request(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.h),
                          height: 100.h,
                          width: 168.w,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.pink.shade200.withOpacity(0.3),
                                spreadRadius: 1,
                                offset: const Offset(8, 8),
                                blurRadius: 10,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Container(
                              //   margin: EdgeInsets.all(5),
                              //   decoration: BoxDecoration(
                              //     color: Colors.white,
                              //   ),
                              //   child:Image(image: AssetImage('assets/images/refer a friend.png')),height: 40.h,width: 40.w,),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade400
                                              .withOpacity(0.7),
                                          spreadRadius: 1,
                                          blurRadius: 5)
                                    ],
                                    shape: BoxShape.circle),
                                padding: EdgeInsets.all(8.h),
                                margin: EdgeInsets.symmetric(vertical: 5.h),
                                width: 45.w,
                                height: 45.h,
                                child: Image.asset('assets/images/staff.png'),
                              ),

                              Text(
                                'Request a staff',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Documents()));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.h),
                          height: 100.h,
                          width: 168.w,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blue.shade200.withOpacity(0.3),
                                  offset: const Offset(8, 8),
                                  spreadRadius: 1,
                                  blurRadius: 10),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Container(
                              //   margin: EdgeInsets.all(5),
                              //   decoration: BoxDecoration(
                              //     color: Colors.white,
                              //   ),
                              //   child:Image(image: AssetImage('assets/images/documents.png')),height: 40.h,width: 40.w,),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade400
                                              .withOpacity(0.7),
                                          spreadRadius: 1,
                                          blurRadius: 5)
                                    ],
                                    shape: BoxShape.circle),
                                padding: EdgeInsets.all(8.h),
                                margin: EdgeInsets.symmetric(vertical: 5.h),
                                width: 40.w,
                                height: 40.h,
                                child: SvgPicture.asset(
                                    'assets/images/documents icon.svg'),
                              ),

                              Text(
                                'Documents',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BookingPage(ind: 1)));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade400.withOpacity(0.7),
                              spreadRadius: 1,
                              blurRadius: 10)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Image(
                              image: const AssetImage(
                                  'assets/images/unconfirm.jpg'),
                              height: 60.h,
                              width: 60.w,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          const Text(
                            'Unconfirmed Bookings',
                            style: TextStyle(
                                color: Color(0xff3b53a4),
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5.h),
                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          const Text(
                            'Show All',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 10.h)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.h)
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ChatApp(),
              ),
            );
          },
          child: const Icon(
            Icons.chat_outlined,
          ),
        ),
      ),
    );
  }
}
