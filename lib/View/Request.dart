// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:carehome/View/AuthController.dart';
import 'package:carehome/View/Home.dart';
import 'package:carehome/View/SplashScreen.dart';
import 'package:carehome/View/edit_staff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  var focus = 0;
  List title = [
    'Registered Nurse (RGN)',
    'Registered Mental Nurse (RMN)',
    'Senior Carer',
    'Health Care Assistant (HCA)',
    'Kitchen Assistant',
    'Chef'
  ];
  dynamic titleSelected;
  dynamic staffSelect;
  dynamic shiftSelected;
  List staff = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List shift = [
    'Day 07:00-19:00',
    'Night 19:00-07:00',
    'Day 08:00-20:00',
    'Night 20:00-08:00',
    '08:00-14:00',
    '08:00-16:00',
    '08:00-18:00',
    '10:00-14:00',
    '10:00-16:00',
    '10:00-18:00',
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
  // var posSelected = 'Registered Nurse (RGN)';

  final formKey = GlobalKey<FormState>();
  final scrollKey = GlobalKey();

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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const Home(),
                                  ),
                                );
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
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              'Request A Staff',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 70.w)
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
                          'Enter Required Staff Position',
                          style: TextStyle(color: Colors.black),
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
                          setState(() {
                            titleSelected = value!;
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
                        validator: (value) {
                          if (value == null) {
                            return 'Please select from this field';
                          }
                          return null;
                        },
                        hint: const Text(
                          'No. of Staff Required',
                          style: TextStyle(color: Colors.black),
                        ),
                        items: staff
                            .map((e) => DropdownMenuItem<int>(
                                  value: e,
                                  child: Text(e.toString()),
                                ))
                            .toList(),
                        onChanged: (var value) {
                          setState(() {
                            staffSelect = value!;
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
                          'Enter Shift Details',
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
                          setState(() {
                            shiftSelected = value!;
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
                      rangeSelectionMode: RangeSelectionMode.toggledOn,
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
                        var startingFrom = start.toString().split("%").first;
                        var request = http.Request(
                          'POST',
                          Uri.parse(
                              '$baseUrl/api/care-home/request-staff/save?position=${title.indexOf(titleSelected) + 1}&number_of_staff=$staffSelect&shift_detail=${shift.indexOf(shiftSelected) + 1}&start_date=${start.day}-${start.month}-${start.year}&end_date=${end.day}-${end.month}-${end.year}'),
                        );

                        request.headers.addAll(headers);
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return const SizedBox(
                              child: Center(
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.blue,
                              content: Text(
                                  '${jsonDecode(await response.stream.bytesToString())['message']}'),
                            ),
                          );
                          setState(() {});
                        } else {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '${jsonDecode(await response.stream.bytesToString())['message']}'),
                              backgroundColor: Colors.blue,
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
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.r),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Requested Staff Details: ',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        StreamBuilder<http.Response>(
                          stream: http.get(
                              // Uri.parse('$baseUrl/api/care-home/request-staff/get?position=${pos.indexOf(titleSelected) + 1}&number_of_staff=$staffSelect&shift_detail=${shift.indexOf(shiftSelected) + 1}&start_date=${start.day}-${start.month}-${start.year}&end_date=${end.day}-${end.month}-${end.year}'),
                              Uri.parse('$baseUrl/api/care-home/request-staff/get'),
                              headers: {
                                'Accept': 'application/json',
                                'Authorization': 'Bearer $token'
                              }).asStream(),
                          builder: (context, snapshot) {
                            // print('$baseUrl/api/care-home/request-staff/get?position=${pos.indexOf(titleSelected) + 1}&shift_detail=${shift}&start_date=${start.day}-${start.month}-${start.year}&end_date=${end.day}-${end.month}-${end.year}');
                            // print(snapshot.data?.request?.url);
                            if (snapshot.hasData) {
                              if (snapshot.data!.statusCode == 200) {
                                if (jsonDecode(snapshot.data!.body)['status'] ==
                                    200) {
                                  // print(jsonDecode(snapshot.data!.body));
                                  return Column(
                                    children: List.generate(
                                      jsonDecode(snapshot.data!.body)['data']
                                          .length,
                                      (index) => Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.h),
                                        child: jsonDecode(snapshot.data!.body)[
                                                        'data']
                                                    .length ==
                                                0
                                            ? Container()
                                            : Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding:
                                                    const EdgeInsets.all(12),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 4,
                                                  horizontal: 7,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color:
                                                          Colors.grey.shade400,
                                                      spreadRadius: 1,
                                                      blurRadius: 10,
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Text(
                                                                'Position: ',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              Text(
                                                                '${jsonDecode(snapshot.data!.body)['data'].elementAt(index)['position_name']}',
                                                                style:
                                                                    const TextStyle(),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pushReplacement(
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                                      return EditStaff(
                                                                        id: jsonDecode(snapshot.data!.body)['data']
                                                                            .elementAt(index)['id'],
                                                                        position:
                                                                            jsonDecode(snapshot.data!.body)['data'].elementAt(index)['position_name'],
                                                                        staffNo:
                                                                            jsonDecode(snapshot.data!.body)['data'].elementAt(index)['number_of_staff'],
                                                                        shiftDetail:
                                                                            jsonDecode(snapshot.data!.body)['data'].elementAt(index)['shift_detail_name'],
                                                                        startDate:
                                                                            jsonDecode(snapshot.data!.body)['data'].elementAt(index)['start_date'],
                                                                        endDate:
                                                                            jsonDecode(snapshot.data!.body)['data'].elementAt(index)['end_date'],
                                                                      );
                                                                    },
                                                                  ),
                                                                );
                                                              },
                                                              child: const Icon(
                                                                Icons.edit,
                                                                color:
                                                                    Colors.blue,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            'No of Staff : ',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16),
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              '${jsonDecode(snapshot.data!.body)['data'].elementAt(index)['number_of_staff']}',
                                                              style:
                                                                  const TextStyle(),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 4.h),
                                                    SizedBox(
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            'Shift Detail: ',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16),
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              '${jsonDecode(snapshot.data!.body)['data'].elementAt(index)['shift_detail_name']}',
                                                              style:
                                                                  const TextStyle(),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 4.h),
                                                    SizedBox(
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            'Start Date: ',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16),
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              // DateFormat.yMMMMd('en_US')
                                                              '${jsonDecode(snapshot.data!.body)['data'].elementAt(index)['start_date']}',
                                                              style:
                                                                  const TextStyle(),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Text(
                                                                'End Date: ',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              Text(
                                                                '${jsonDecode(snapshot.data!.body)['data'].elementAt(index)['end_date']}',
                                                                style:
                                                                    const TextStyle(),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () async {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                      iconColor:
                                                                          Colors
                                                                              .red,
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .warning_amber,
                                                                        size: 40
                                                                            .sp,
                                                                      ),
                                                                      title: const Center(
                                                                          child:
                                                                              Text('Are you sure?')),
                                                                      content: const Text(
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          'This record and its details will be permanently deleted!'),
                                                                      actions: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              child: Container(
                                                                                width: 100.w,
                                                                                height: 50.h,
                                                                                margin: EdgeInsets.only(left: 20, bottom: 12, right: 20.w),
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.blue,
                                                                                  borderRadius: BorderRadius.circular(10.r),
                                                                                  boxShadow: const [
                                                                                    BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 10),
                                                                                  ],
                                                                                ),
                                                                                child: const Center(
                                                                                  child: Text(
                                                                                    'No',
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                try {
                                                                                  var response = await AuthController().deleteStaff(jsonDecode(snapshot.data!.body)['data'].elementAt(index)['id']);
                                                                                  setState(() {
                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                      SnackBar(
                                                                                        backgroundColor: Colors.blue,
                                                                                        content: Text(
                                                                                          response.toString(),
                                                                                          style: const TextStyle(
                                                                                            color: Colors.white,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                    Navigator.of(context).pop();
                                                                                  });
                                                                                } catch (e) {
                                                                                  Navigator.of(context).pop();
                                                                                  setState(() {});
                                                                                  // Navigator.pushAndRemoveUntil(
                                                                                  //   context,
                                                                                  //   MaterialPageRoute(
                                                                                  //     builder: (context) => const Request(),
                                                                                  //   ),
                                                                                  //   (route) => false,
                                                                                  // );
                                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                                    const SnackBar(
                                                                                      backgroundColor: Colors.blue,
                                                                                      content: Text(
                                                                                        'Successfully Deleted',
                                                                                        style: TextStyle(
                                                                                          color: Colors.white,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                }
                                                                              },
                                                                              child: Container(
                                                                                width: 100.w,
                                                                                height: 50.h,
                                                                                margin: EdgeInsets.only(left: 20, bottom: 12, right: 20.w),
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.red,
                                                                                  borderRadius: BorderRadius.circular(10.r),
                                                                                  boxShadow: const [
                                                                                    BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 10),
                                                                                  ],
                                                                                ),
                                                                                child: const Center(
                                                                                  child: Text(
                                                                                    'Yes',
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                12.h),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              child: const Icon(
                                                                Icons.delete,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ),
                                    ).toList(),
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
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
