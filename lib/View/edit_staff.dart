import 'dart:convert';

import 'package:carehome/View/AuthController.dart';
import 'package:carehome/View/Request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

import 'SplashScreen.dart';

class EditStaff extends StatefulWidget {
  EditStaff({
    super.key,
    this.id,
    required this.position,
    required this.staffNo,
    required this.shiftDetail,
    required this.startDate,
    required this.endDate,
  });
  int? id;
  String? position;
  String? staffNo;
  String? shiftDetail;
  String? startDate;
  String? endDate;

  @override
  State<EditStaff> createState() => _EditStaffState();
}

class _EditStaffState extends State<EditStaff> {
  var focus = 0;
  List title = [
    'Registered Nurse (RGN)',
    'Registered Mental Nurse (RMN)',
    'Senior Carer',
    'Health Care Assistant (HCA)',
    'Kitchen Assistant',
    'Chef'
  ];
  List staff = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List shift = [
    '08:00-14:00',
    '08:00-16:00',
    '08:00-18:00',
    '10:00-14:00',
    '10:00-16:00',
    '10:00-18:00',
    'Day 08:00-20:00',
    'Night 20:00-08:00'
  ];
  var start = DateTime.now();
  var end = DateTime.now();
  var focused = DateTime.now();
  var _selectedDay = DateTime.now();
  var _focusedDay = DateTime.now();

  var day = true;
  List pos = [
    'Registered Nurse (RGN)',
    'Registered Mental Nurse (RMN)',
    'Senior Carer',
    'Health Care Assistant (HCA)',
    'Kitchen Assistant',
    'Chef'
  ];
  var posSelected = 'Registered Nurse (RGN)';
  final formKey = GlobalKey<FormState>();
  var titleSelected;
  var staffSelect;
  var shiftSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.blue.shade50.withOpacity(0.4),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    color: Colors.blue,
                    child: Column(
                      children: [
                        SizedBox(height: 35.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.all(20.h),
                              padding: EdgeInsets.all(5.h),
                              child: Text(
                                'Update Staff Data',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: Colors.black),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: titleSelected,
                        hint: const Text(
                          'Enter your position',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select from this field';
                          }
                          return null;
                        },
                        items: title
                            .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (String? value) {
                          titleSelected = value!;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 5,
                          ),
                          hintStyle: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                            color: const Color(0xffACA9A9),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          // enabled: false,
                          errorStyle: const TextStyle(height: 0.1),
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
                    padding:
                        EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: Colors.black),
                      ),
                      child: DropdownButtonFormField<int>(
                        value: staffSelect,
                        hint: const Text(
                          'No. of staff required',
                          style: TextStyle(color: Colors.black),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select from this field';
                          }
                          return null;
                        },
                        items: staff
                            .map((e) => DropdownMenuItem<int>(
                                  value: e,
                                  child: Text(e.toString()),
                                ))
                            .toList(),
                        onChanged: (var value) {
                          staffSelect = value!;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          errorStyle: const TextStyle(height: 0.1),
                          hintStyle: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                            color: const Color(0xffACA9A9),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          // enabled: false,
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
                    padding:
                        EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: Colors.black),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: shiftSelected,
                        hint: const Text(
                          'Enter shift Details',
                          style: TextStyle(color: Colors.black),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select from this field';
                          }
                          return null;
                        },
                        items: shift
                            .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (String? value) {
                          shiftSelected = value!;
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
                          // enabled: false,
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
                  Container(
                    margin: EdgeInsets.all(20.w),
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
                      headerStyle:
                          const HeaderStyle(formatButtonVisible: false),
                      rangeStartDay: start,
                      rangeEndDay: end,
                      firstDay: DateTime.utc(2010, 10, 16),
                      rowHeight: 60.h,
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
                      rangeSelectionMode: RangeSelectionMode.toggledOn,
                      onRangeSelected: (first, second, third) {
                        setState(() {
                          start = first!;
                          end = third;
                          print(first);
                          print(third);
                        });
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        print('yes');
                        setState(
                          () {
                            _selectedDay = selectedDay;
                            _focusedDay =
                                focusedDay; // update `_focusedDay` here as well
                          },
                        );
                      },
                    ),
                  ),
                  // const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      final isValid = formKey.currentState!.validate();
                      if (isValid) {
                        var headers = {'Authorization': 'Bearer $token'};
                        var startingfrom = start.toString().split("%").first;
                        print(title.indexOf(titleSelected) + 1);
                        var request = http.Request(
                          'POST',
                          Uri.parse(
                              '$baseUrl/api/care-home/request-staff/edit?id=${widget.id}&position=${title.indexOf(titleSelected) + 1}&number_of_staff=$staffSelect&shift_detail=${shift.indexOf(shiftSelected) + 1}&start_date=${start.day}-${start.month}-${start.year}&end_date=${end.day}-${end.month}-${end.year}'),
                        );
                        print(request.url);

                        request.headers.addAll(headers);
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Container(
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xfffaeaea),
                                ),
                              ),
                            );
                          },
                        );
                        http.StreamedResponse response = await request.send();

                        if (response.statusCode == 200) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.blue,
                                  content: Text(
                                      '${jsonDecode(await response.stream.bytesToString())['message']}'),
                                ),
                              )
                              .setState;
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const Request(),
                            ),
                          );
                        } else {
                          // print(response.statusCode);
                          // print(response.reasonPhrase);
                          // print(response.stream);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.blue,
                              content: Text(
                                  '${jsonDecode(await response.stream.bytesToString())['message']}'),
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      width: 320.w,
                      height: 50.h,
                      margin:
                          EdgeInsets.only(left: 20, bottom: 12, right: 20.w),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 1,
                              blurRadius: 10),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
