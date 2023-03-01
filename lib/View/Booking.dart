// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'dart:convert';
import 'dart:io';

import 'package:carehome/View/AuthController.dart';
import 'package:carehome/View/pdfView.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'SplashScreen.dart';

class BookingPage extends StatefulWidget {
  BookingPage({Key? key, this.ind}) : super(key: key);
  int? ind = 0;
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int index = 0;
  var shift = '';
  var week = 0;
  var start = DateTime.now();
  var end = DateTime.now();
  var focused = DateTime.now();
  var _selectedDay = DateTime.now();
  var _focusedDay = DateTime.now();
  var selected = 1;
  var enable = false;
  var focus = 0;
  List title = ['Daily', 'Weekly', 'Customize'];
  var titleSelected = 'Daily';
  var shift1 = '';
  var week1 = 0;
  var start1 = DateTime.now();
  var end1 = DateTime.now();
  var focused1 = DateTime.now();
  var _selectedDay1 = DateTime.now();
  var _focusedDay1 = DateTime.now();
  var selected1 = 1;
  var enable1 = false;
  var focus1 = 0;
  List title1 = ['Daily', 'Weekly', 'Customize'];
  // List title1 = ['Daily', 'Weekly', 'Monthly', 'Customize'];
  var titleSelected1 = 'Daily';
  List pos = [
    'All',
    'Registered Nurse (RGN)',
    'Registered Mental Nurse (RMN)',
    'Senior Carer',
    'Health Care Assistant (HCA)',
    'Kitchen Assistant',
    'Chef'
  ];
  var posSelected = 'All';
  List pos1 = [
    'All',
    'Registered Nurse (RGN)',
    'Registered Mental Nurse (RMN)',
    'Senior Carer',
    'Health Care Assistant (HCA)',
    'Kitchen Assistant',
    'Chef'
  ];
  var pos1Selected = 'All';

  var day = true;
  var night = false;
  bool all = false;

  var day1 = true;
  var night1 = false;
  bool all1 = false;
  @override
  void initState() {
    index = widget.ind ?? 0;
    // TODO: implement initState
    super.initState();
  }

  FocusNode dropkey = FocusNode();
  FocusNode dropkey1 = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        child: SizedBox(
          //height: 844.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.blue,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: EdgeInsets.all(20.h),
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(2.r),
                                //   // boxShadow: const [
                                //   //   BoxShadow(
                                //   //       color: Colors.black12,
                                //   //       spreadRadius: 1,
                                //   //       blurRadius: 10),
                                //   // ],
                                // ),
                                padding: EdgeInsets.all(5.h),
                                child: const Icon(
                                  Icons.keyboard_arrow_left_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 85.w),
                            Text(
                              'Bookings',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                            //   child: const Icon(
                            //     CupertinoIcons.search,
                            //     color: Colors.white,
                            //   ),
                            // )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                    child: SizedBox(
                      height: 60.h,
                      width: 700.w,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  index = 0;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: index == 0
                                      ? Colors.pink
                                      : Colors.grey.shade100,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade400,
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                    )
                                  ],
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Confirmed',
                                    style: TextStyle(
                                        color: index == 0
                                            ? Colors.white
                                            : Colors.black87,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  index = 1;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: index == 1
                                      ? Colors.pink
                                      : Colors.grey.shade100,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade400,
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                    )
                                  ],
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Unconfirmed',
                                    style: TextStyle(
                                      color: index == 1
                                          ? Colors.white
                                          : Colors.black87,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: index == 0,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20.w, right: 20.w, top: 20.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.black),
                            ),
                            child: DropdownButtonFormField<String>(
                              value: posSelected,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please select from this field';
                                }
                                return null;
                              },
                              items: pos
                                  .map((e) => DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  posSelected = value!;
                                });
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                hintStyle: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp,
                                  color: const Color(0xffACA9A9),
                                ),
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20.w, right: 20.w, top: 20.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Listener(
                              onPointerDown: (_) =>
                                  FocusScope.of(context).unfocus(),
                              child: DropdownButtonFormField<String>(
                                value: titleSelected,
                                focusNode: dropkey,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please select from this field';
                                  }
                                  return null;
                                },
                                items: title
                                    .map((e) => DropdownMenuItem<String>(
                                          value: e,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(e),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (String? value) {
                                  titleSelected = value!;
                                  setState(() {
                                    if (value.contains('Daily')) {
                                      shift = day ? '1,Day' : '1,Night';
                                      end = DateTime.now();
                                      start = DateTime.now();
                                    } else if (value.contains('Weekly')) {
                                      shift = day ? '2,Day' : '2,Night';
                                      end = DateTime.now()
                                          .add(const Duration(days: 7));
                                      start = DateTime.now();
                                    } else if (value.contains('Monthly')) {
                                      shift = day ? '2,Day' : '2,Night';
                                      end = DateTime.now()
                                          .add(const Duration(days: 30));
                                      start = DateTime.now();
                                    } else if (value.contains('Customize')) {
                                      shift = day ? '2,Day' : '2,Night';
                                      end = DateTime.now();
                                    }
                                    dropkey.unfocus();
                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  hintStyle: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp,
                                    color: const Color(0xffACA9A9),
                                  ),
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                          child: Row(
                            children: [
                              Checkbox(
                                  value: day,
                                  onChanged: (val) {
                                    setState(() {
                                      if (val == true) {
                                        night = false;
                                        day = val!;
                                        all = false;
                                      }
                                      shift = shift.replaceAll("Night", "Day");
                                    });
                                  }),
                              const Text('Day'),
                              Checkbox(
                                  value: night,
                                  onChanged: (val) {
                                    setState(() {
                                      if (val == true) {
                                        day = false;
                                        night = val!;
                                        all = false;
                                      }
                                      shift = shift.replaceAll("Day", "Night");
                                    });
                                  }),
                              const Text('Night'),
                              SizedBox(width: 10.w),
                              TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    all = !all;
                                    day = false;
                                    night = false;
                                  });
                                },
                                icon: Icon(
                                  all
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                  color: all ? Colors.blue : Colors.grey,
                                ),
                                label: const Text(
                                  'All Shifts',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: 10.w, left: 20.w, right: 20.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 1,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: TableCalendar(
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            rangeStartDay: start,
                            rangeEndDay: end,
                            headerStyle:
                                const HeaderStyle(formatButtonVisible: false),
                            firstDay: DateTime.utc(2010, 10, 16),
                            rowHeight: 50.h,
                            calendarStyle: CalendarStyle(
                              selectedDecoration: BoxDecoration(
                                color: focus == 2
                                    ? Colors.blue.shade300
                                    : focus == 1
                                        ? Colors.pink.shade300
                                        : Colors.grey,
                              ),
                            ),
                            selectedDayPredicate: (date) {
                              if (date == _focusedDay) {
                                return true;
                              } else {
                                return false;
                              }
                            },
                            lastDay: DateTime.utc(2030, 3, 14),
                            focusedDay: _focusedDay,
                            currentDay: _selectedDay,
                            rangeSelectionMode: titleSelected == 'Customize'
                                ? RangeSelectionMode.toggledOn
                                : RangeSelectionMode.toggledOff,
                            onRangeSelected: (first, second, third) {
                              setState(() {
                                start = first!;
                                end = third;
                                // print(first);
                                // print(third);
                              });
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              // print('yes');
                              setState(() {
                                _selectedDay = selectedDay;
                                _focusedDay =
                                    focusedDay; // update `_focusedDay` here as well
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.h, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.r),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 1,
                                  blurRadius: 10)
                            ],
                          ),
                          padding: EdgeInsets.all(10.h),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Confirmed Staff',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        downloadPDF(
                                            start: start,
                                            end: end,
                                            shift: shift,
                                            urls:
                                                '$baseUrl/api/care-home/care-home-jobs/download/confirmed?position=${pos.indexOf(posSelected)}&shift=${all == true ? 0 : posSelected == 'All' ? 0 : day == true ? "1" : "2"}&start_date=$start&end_date=$end&page=1');
                                      },
                                      child: const Icon(
                                        Icons.save_alt,
                                        color: Colors.blue,
                                      ))
                                ],
                              ),
                              StreamBuilder<http.Response>(
                                  stream: http.get(
                                      Uri.parse(
                                        '$baseUrl/api/care-home/care-home-jobs/get/confirmed?position=${pos.indexOf(posSelected)}&shift=${all == true ? 0 : posSelected == 'All' ? 0 : day == true ? "1" : "2"}&start_date=$start&end_date=$end&page=1',
                                      ),
                                      headers: {
                                        'Accept': 'application/json',
                                        'Authorization': 'Bearer $token'
                                      }).asStream(),
                                  builder: (context, snapshot) {
                                    print(snapshot.data?.request?.url);
                                    if (snapshot.hasData) {
                                      if (snapshot.data!.statusCode == 200) {
                                        if (jsonDecode(snapshot.data!.body)[
                                                'status'] ==
                                            200) {
                                          print(
                                              jsonDecode(snapshot.data!.body));
                                          return Column(
                                            children: List.generate(
                                                jsonDecode(snapshot.data!.body)[
                                                        'data']
                                                    .length,
                                                (index) => Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 8.h),
                                                      child: jsonDecode(snapshot
                                                                          .data!
                                                                          .body)[
                                                                      'data']
                                                                  .length ==
                                                              0
                                                          ? Container()
                                                          : SizedBox(
                                                              height: 30.h,
                                                              child: Row(
                                                                children: [
                                                                  const Image(
                                                                    image: AssetImage(
                                                                        'assets/images/user.png'),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10.w,
                                                                  ),
                                                                  Text(
                                                                      '${jsonDecode(snapshot.data!.body)['data'].elementAt(index)['name']}'),
                                                                ],
                                                              ),
                                                            ),
                                                    )),
                                          );
                                        } else {
                                          return const SizedBox(
                                            child: Text(
                                              'You are not authorized login again',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          );
                                        }
                                      } else {
                                        return const SizedBox(
                                          child: Text(
                                            'please check your internet connection',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        );
                                      }
                                    } else {
                                      return SizedBox(
                                        height: 30.h,
                                        width: 30.h,
                                        child: const CircularProgressIndicator(
                                          color: Colors.blue,
                                        ),
                                      );
                                    }
                                  }),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: index == 1,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20.w, right: 20.w, top: 20.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.black),
                            ),
                            child: DropdownButtonFormField<String>(
                              value: pos1Selected,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please select from this field';
                                }
                                return null;
                              },
                              items: pos1
                                  .map((e) => DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  pos1Selected = value!;
                                });
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                hintStyle: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp,
                                  color: const Color(0xffACA9A9),
                                ),
                                errorStyle: const TextStyle(height: 0.1),
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20.w, right: 20.w, top: 20.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Listener(
                              onPointerDown: (_) =>
                                  FocusScope.of(context).unfocus(),
                              child: DropdownButtonFormField<String>(
                                value: titleSelected1,
                                focusNode: dropkey1,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please select from this field';
                                  }
                                  return null;
                                },
                                items: title1
                                    .map((e) => DropdownMenuItem<String>(
                                          value: e,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(e),
                                              // Row(
                                              //   children: [
                                              //     Checkbox(
                                              //         value: day1,
                                              //         onChanged: (val) {
                                              //           setState(() {
                                              //             day1 = true;
                                              //           });
                                              //         }),
                                              //     const Text('Day'),
                                              //     Checkbox(
                                              //         value: !day1,
                                              //         onChanged: (val) {
                                              //           setState(() {
                                              //             day1 = false;
                                              //           });
                                              //         }),
                                              //     const Text('Night'),
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (String? value) {
                                  titleSelected1 = value!;
                                  setState(() {
                                    if (value.contains('Daily')) {
                                      shift1 = day1 ? '1,Day' : '1,Night';
                                      end1 = DateTime.now();
                                    } else if (value.contains('Weekly')) {
                                      shift1 = day1 ? '2,Day' : '2,Night';
                                      end1 = DateTime.now()
                                          .add(const Duration(days: 7));
                                    } else if (value.contains('Monthly')) {
                                      shift1 = day1 ? '2,Day' : '2,Night';
                                      end1 = DateTime.now()
                                          .add(const Duration(days: 31));
                                    } else if (value.contains('Customize')) {
                                      shift1 = day1 ? '2,Day' : '2,Night';
                                      end1 = DateTime.now();
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  hintStyle: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp,
                                    color: const Color(0xffACA9A9),
                                  ),
                                  errorStyle: const TextStyle(height: 0.1),
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                          child: Row(
                            children: [
                              Checkbox(
                                  value: day1,
                                  onChanged: (val) {
                                    setState(() {
                                      if (val == true) {
                                        night1 = false;
                                        day1 = val!;
                                        all1 = false;
                                      }
                                      shift = shift.replaceAll("Night", "Day");
                                    });
                                  }),
                              const Text('Day'),
                              Checkbox(
                                  value: night1,
                                  onChanged: (val) {
                                    setState(() {
                                      if (val == true) {
                                        day1 = false;
                                        night1 = val!;
                                        all1 = false;
                                      }
                                      shift = shift.replaceAll("Day", "Night");
                                    });
                                  }),
                              const Text('Night'),
                              SizedBox(width: 10.w),
                              TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    all1 = !all1;
                                    day1 = false;
                                    night1 = false;
                                  });
                                },
                                icon: Icon(
                                  all1
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                  color: all1 ? Colors.blue : Colors.grey,
                                ),
                                label: const Text(
                                  'All Shifts',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: 10.w, left: 20.w, right: 20.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 1,
                                    blurRadius: 10)
                              ]),
                          child: TableCalendar(
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            rangeStartDay: start1,
                            rangeEndDay: end1,
                            headerStyle:
                                const HeaderStyle(formatButtonVisible: false),
                            firstDay: DateTime.utc(2010, 10, 16),
                            rowHeight: 50.h,
                            calendarStyle: CalendarStyle(
                              selectedDecoration: BoxDecoration(
                                  color: focus1 == 2
                                      ? Colors.blue.shade300
                                      : focus1 == 1
                                          ? Colors.pink.shade300
                                          : Colors.grey),
                            ),
                            selectedDayPredicate: (date) {
                              if (date == _focusedDay1) {
                                return true;
                              } else {
                                return false;
                              }
                            },
                            lastDay: DateTime.utc(2030, 3, 14),
                            focusedDay: _focusedDay1,
                            currentDay: _selectedDay1,
                            rangeSelectionMode: titleSelected == 'Customize'
                                ? RangeSelectionMode.toggledOn
                                : RangeSelectionMode.toggledOff,
                            onRangeSelected: (first, second, third) {
                              setState(() {
                                start1 = first!;
                                end1 = third;
                                // print(first);
                                // print(third);
                              });
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              // print('yes');
                              setState(() {
                                _selectedDay1 = selectedDay;
                                _focusedDay1 =
                                    focusedDay; // update `_focusedDay` here as well
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.h, vertical: 8.h),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.r),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 1,
                                    blurRadius: 10)
                              ]),
                          padding: EdgeInsets.all(10.h),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    index == 0
                                        ? "Confirmed Staff"
                                        : 'Unconfirmed Staff',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        downloadPDF(
                                            start: start1,
                                            end: end1,
                                            shift: shift1,
                                            urls:
                                                '$baseUrl/api/care-home/care-home-jobs/download/unconfirmed?position=${pos1.indexOf(pos1Selected)}&shift=${all1 == true ? 0 : pos1Selected == 'All' ? 0 : day1 == true ? "1" : "2"}&start_date=$start&end_date=$end&page=1');
                                      },
                                      child: const Icon(
                                        Icons.save_alt,
                                        color: Colors.blue,
                                      ))
                                ],
                              ),
                              StreamBuilder<http.Response>(
                                  stream: http.get(
                                      Uri.parse(
                                        '$baseUrl/api/care-home/care-home-jobs/get/unconfirmed?position=${pos1.indexOf(pos1Selected)}&shift=${all1 == true ? 0 : pos1Selected == 'All' ? 0 : day1 == true ? "1" : "2"}&start_date=$start&end_date=$end&page=1',
                                      ),
                                      headers: {
                                        'Accept': 'application/json',
                                        'Authorization': 'Bearer $token'
                                      }).asStream(),
                                  builder: (context, snapshot) {
                                    print(snapshot.data?.request?.url);
                                    if (snapshot.hasData) {
                                      if (snapshot.data!.statusCode == 200) {
                                        if (jsonDecode(snapshot.data!.body)[
                                                'status'] ==
                                            200) {
                                          print(
                                              jsonDecode(snapshot.data!.body));
                                          return Column(
                                            children: List.generate(
                                                jsonDecode(snapshot.data!.body)[
                                                        'data']
                                                    .length,
                                                (index) => Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 8.h),
                                                      child: jsonDecode(snapshot
                                                                          .data!
                                                                          .body)[
                                                                      'data']
                                                                  .length ==
                                                              0
                                                          ? Container()
                                                          : SizedBox(
                                                              height: 30.h,
                                                              child: Row(
                                                                children: [
                                                                  const Image(
                                                                    image: AssetImage(
                                                                        'assets/images/user.png'),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10.w,
                                                                  ),
                                                                  Text(
                                                                      '${jsonDecode(snapshot.data!.body)['data'].elementAt(index)['name']}'),
                                                                ],
                                                              ),
                                                            ),
                                                    )),
                                          );
                                        } else {
                                          return const SizedBox(
                                            child: Text(
                                              'You are not authorized login again',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          );
                                        }
                                      } else {
                                        return const SizedBox(
                                          child: Text(
                                            'please check your internet connection',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        );
                                      }
                                    } else {
                                      return SizedBox(
                                        height: 30.h,
                                        width: 30.h,
                                        child: const CircularProgressIndicator(
                                          color: Colors.blue,
                                        ),
                                      );
                                    }
                                  }),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<File?> downloadPDF({shift, start, end, urls}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const SizedBox(
            child: Center(
                child: CircularProgressIndicator(
          color: Color(0xfffaeaea),
        )));
      },
    );
    Dio dioClient = Dio();
    final url = Uri.parse('$urls');
    final headers = {
      "Authorization": "Bearer $token",
    };
    final response = await http.get(url, headers: headers);
    Navigator.pop(context);

    if (response != null) {
      final Directory? appDir = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();
      String tempPath = appDir!.path;
      final String fileName = '${DateTime.now().microsecondsSinceEpoch}.pdf';
      File file = File('$tempPath/$fileName');
      if (!await file.exists()) {
        await file.create();
      }
      var files = await file.writeAsBytes(response.bodyBytes);
      // print('');
      files.exists() == false
          ? ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('PDF NOT FOUND'),
                backgroundColor: Colors.blue,
              ),
            )
          : Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => PDFScreen(
                    path: files.path,
                    url: url,
                  )));
    }
    return null;
  }
}
