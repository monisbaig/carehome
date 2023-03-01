// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

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

class Availability extends StatefulWidget {
  const Availability({Key? key}) : super(key: key);

  @override
  State<Availability> createState() => _AvailabilityState();
}

class _AvailabilityState extends State<Availability> {
  List title = ['Daily', 'Weekly', 'Customize'];
  // List title = ['Daily', 'Weekly', 'Monthly', 'Customize'];
  var titleSelected = 'Daily';
  var selectedDate = 0;
  var shift = '';
  var week = 0;
  var day = true;
  var night = false;
  bool all = false;
  var start = DateTime.now();
  var end = DateTime.now();
  var focused = DateTime.now();
  var _selectedDay = DateTime.now();
  var _focusedDay = DateTime.now();
  var selected = 1;
  var enable = false;
  var focus = 0;
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
  FocusNode dropkey = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.blue.shade50.withOpacity(0.4),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.blue,
                child: Column(
                  children: [
                    const SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.all(20.h),
                            // decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     borderRadius: BorderRadius.circular(2.r),
                            //     boxShadow: const [
                            //       BoxShadow(
                            //           color: Colors.black12,
                            //           spreadRadius: 1,
                            //           blurRadius: 10)
                            //     ]),
                            padding: EdgeInsets.all(5.h),
                            child: const Icon(
                              Icons.keyboard_arrow_left_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          'Available Staff',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 60.w,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
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
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Listener(
                    onPointerDown: (_) => FocusScope.of(context).unfocus(),
                    child: DropdownButtonFormField<String>(
                        value: titleSelected,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please select from this field';
                          }
                          return null;
                        },
                        items: title
                            .map(
                              (e) => DropdownMenuItem<String>(
                                value: e,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(e),
                                  ],
                                ),
                              ),
                            )
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
                              end = DateTime.now().add(const Duration(days: 7));
                              start = DateTime.now();
                            } else if (value.contains('Monthly')) {
                              shift = day ? '3,Day' : '3,Night';
                              end =
                                  DateTime.now().add(const Duration(days: 31));
                              start = DateTime.now();
                            } else if (value.contains('Customize')) {
                              end = DateTime.now();
                              start = DateTime.now();
                              shift = day ? '4,Day' : '4,Night';
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
                        )),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
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
                        all ? Icons.check_box : Icons.check_box_outline_blank,
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
                margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 10),
                    ]),
                child: TableCalendar(
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  rangeStartDay: start,
                  rangeEndDay: end,
                  firstDay: DateTime.utc(2010, 10, 16),
                  rowHeight: 50.h,
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                        color: focus == 2
                            ? Colors.blue.shade300
                            : focus == 1
                                ? Colors.pink.shade300
                                : Colors.grey),
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
                  weekNumbersVisible: false,
                  headerStyle: const HeaderStyle(formatButtonVisible: false),
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
                margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 8.h),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Active Staff',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                            onTap: () {
                              downloadPDF(start: start, end: end, shift: shift);
                            },
                            child: const Icon(
                              Icons.save_alt,
                              color: Colors.blue,
                            ))
                      ],
                    ),
                    SizedBox(height: 10.h),
                    StreamBuilder<http.Response>(
                      stream: http.get(
                          Uri.parse(
                              '$baseUrl/api/care-home/available-staff/get?position=${pos.indexOf(posSelected)}&shift=${all == true ? 0 : posSelected == 'All' ? 0 : day == true ? "1" : "2"}&start_date=${start.day}-${start.month}-${start.year}&end_date=${end.day}-${end.month}-${end.year}'),
                          headers: {
                            'Accept': 'application/json',
                            'Authorization': 'Bearer $token'
                          }).asStream(),
                      builder: (context, snapshot) {
                        print(snapshot.data?.request?.url);
                        if (snapshot.hasData) {
                          if (snapshot.data!.statusCode == 200) {
                            if (jsonDecode(snapshot.data!.body)['status'] ==
                                200) {
                              print(jsonDecode(snapshot.data!.body));
                              return Column(
                                children: List.generate(
                                    jsonDecode(snapshot.data!.body)['data']
                                        .length,
                                    (index) => Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.h),
                                          child:
                                              jsonDecode(snapshot.data!.body)[
                                                              'data']
                                                          .length ==
                                                      0
                                                  ? Container()
                                                  : SizedBox(
                                                      height: 30.h,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
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
                                                          GestureDetector(
                                                            onTap: () async {
                                                              if (jsonDecode(snapshot
                                                                              .data!
                                                                              .body)[
                                                                          'data']
                                                                      .elementAt(
                                                                          index)["button"]["action"] ==
                                                                  1) {
                                                                print(snapshot
                                                                    .data!
                                                                    .body);

                                                                var headers = {
                                                                  'Authorization':
                                                                      'Bearer $token'
                                                                };
                                                                var request =
                                                                    http.Request(
                                                                        'PUT',
                                                                        Uri.parse(
                                                                            '$baseUrl/api/care-home/available-staff/job/assigned?care_home_job_id=${jsonDecode(snapshot.data!.body)['data'].elementAt(index)['care_home_job_id']}&user_id=${jsonDecode(snapshot.data!.body)['data'].elementAt(index)['id']}'));

                                                                request.headers
                                                                    .addAll(
                                                                        headers);

                                                                http.StreamedResponse
                                                                    response =
                                                                    await request
                                                                        .send();
                                                                var data =
                                                                    await response
                                                                        .stream
                                                                        .bytesToString();
                                                                setState(() {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content: Text(
                                                                          '${jsonDecode(data)['message']}'),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .blue,
                                                                    ),
                                                                  );
                                                                });
                                                                Future.delayed(const Duration(
                                                                        seconds:
                                                                            1))
                                                                    .then(
                                                                        (value) {
                                                                  setState(
                                                                      () {});
                                                                });
                                                              } else {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  const SnackBar(
                                                                    content: Text(
                                                                        'Can not Assign shift'),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .blue,
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: jsonDecode(snapshot.data!.body)['data'].elementAt(index)["button"]["text"].contains("Assigned")
                                                                      ? Colors.grey
                                                                      : jsonDecode(snapshot.data!.body)['data'].elementAt(index)["button"]["text"].contains("Rejected")
                                                                          ? Colors.red
                                                                          : Colors.blue,
                                                                  borderRadius: BorderRadius.circular(8.r)),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              child: Text(
                                                                '${jsonDecode(snapshot.data!.body)['data'].elementAt(index)["button"]["text"]}',
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                        )),
                              );
                            } else {
                              return const SizedBox(
                                child: Text(
                                  'You are not authorized login again',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              );
                            }
                          } else {
                            return const SizedBox(
                              child: Text(
                                'please check your internet connection',
                                style: TextStyle(color: Colors.grey),
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
                      },
                    ),

                    // Column(
                    //     children: List.generate(5, (index) => Padding(padding: EdgeInsets.symmetric(vertical: 8.h),child:
                    //     Container(
                    //       height: 30.h,
                    //       child: Row(
                    //         children: [
                    //           Image(image:AssetImage('assets/images/user.png'),),
                    //           SizedBox(width: 10.w,),
                    //           Text('Farooq ahmed')
                    //         ],
                    //       ),
                    //     ),))
                    // )
                  ],
                ),
              ),

              //  Padding(
              //   padding:  EdgeInsets.all(20.w),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //
              //       // Container(
              //       //   height: MediaQuery.of(context).size.height*0.68,
              //       //   width: MediaQuery.of(context).size.width*0.55,
              //       //   decoration: BoxDecoration(
              //       //       color: Colors.white,
              //       //       borderRadius: BorderRadius.circular(5.r),
              //       //       boxShadow: [
              //       //         BoxShadow(
              //       //             color: Colors.black12,
              //       //             spreadRadius: 1,
              //       //             blurRadius: 10
              //       //         )
              //       //       ]
              //       //   ),
              //       //   child: SingleChildScrollView(
              //       //     child: Column(
              //       //       children: List.generate(4, (index) =>  Container(
              //       //         margin: EdgeInsets.symmetric(vertical: 8.h),
              //       //         padding: EdgeInsets.all(10.h),
              //       //         child: Row(
              //       //           children: [
              //       //             Image(image:AssetImage('assets/images/user.png'),height: 30.h),
              //       //             SizedBox(width: 10.w,),
              //       //             Column(
              //       //               crossAxisAlignment: CrossAxisAlignment.start,
              //       //               children: [
              //       //                 Container(
              //       //                   width:140.w,
              //       //                     child: Text('Farooq ahmed')),
              //       //                 Text('RCN',style: TextStyle(color: Colors.grey),)
              //       //               ],
              //       //             ),
              //       //           ],
              //       //         ),
              //       //       ),),
              //       //     ),
              //       //   ),
              //       // ),
              //       // Container(
              //       //   height: MediaQuery.of(context).size.height*0.68,
              //       //   width: MediaQuery.of(context).size.width*0.3,
              //       //   decoration: BoxDecoration(
              //       //       color: Colors.white,
              //       //       borderRadius: BorderRadius.circular(5.r),
              //       //       boxShadow: [
              //       //         BoxShadow(
              //       //             color: Colors.black12,
              //       //             spreadRadius: 1,
              //       //             blurRadius: 10
              //       //         )
              //       //       ]
              //       //   ),
              //       //   padding: EdgeInsets.symmetric(vertical: 10.h),
              //       //   child: SingleChildScrollView(
              //       //     child: Column(
              //       //       children: [
              //       //         Text('JAN',style: TextStyle(fontSize:20.sp),),
              //       //         Text('2022',style: TextStyle(fontSize:20.sp),),
              //       //         GestureDetector(
              //       //             onTap: (){
              //       //               setState(() {
              //       //                 week==0?week=1:week=0;
              //       //               });
              //       //             },
              //       //             child: Text(week==0?'week 1 & 2 >':'< week 3 & 4',style: TextStyle(fontSize:14.sp),)),
              //       //         Column(
              //       //           children: List.generate(30, (index) => GestureDetector(
              //       //             onTap: (){
              //       //               setState(() {
              //       //                 selectedDate=index;
              //       //               });
              //       //             },
              //       //             child: Container(
              //       //                 padding: EdgeInsets.all(5.h),
              //       //                 decoration: BoxDecoration(
              //       //                   shape: BoxShape.circle,
              //       //                   color:selectedDate==index ?Colors.pink.shade100:Colors.transparent
              //       //                 ),
              //       //                 child: Text('${index+1}')),
              //       //           )),
              //       //         )
              //       //       ],
              //       //     ),
              //       //   ),
              //       // )
              //
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future<File?> downloadPDF({shift, start, end}) async {
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
    final url = Uri.parse(
        '$baseUrl/api/care-home/available-staff/download?position=${pos.indexOf(posSelected) + 1}&shift=${day == true ? "1" : "2"}&start_date=${start.day}-${start.month}-${start.year}&end_date=${end.day}-${end.month}-${end.year}');
    final headers = {
      "Authorization": "Bearer $token",
    };
    final response = await http.get(url, headers: headers);
    Navigator.pop(context);
    if (response.statusCode == 200) {
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
      print('');
      files.exists() == false
          ? ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('PDF NOT FOUND'),
                backgroundColor: Colors.blue,
              ),
            )
          : Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PDFScreen(
                  path: files.path,
                  url:
                      '$baseUrl/api/care-home/available-staff/download?position=${pos.indexOf(posSelected)}&shift=${day == true ? "1" : "2"}&start_date=${start.day}-${start.month}-${start.year}&end_date=${end.day}-${end.month}-${end.year}',
                ),
              ),
            );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PDF NOT FOUND'),
          backgroundColor: Colors.blue,
        ),
      );
    }
    return null;
  }
}
