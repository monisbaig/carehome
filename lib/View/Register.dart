// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AuthController.dart';
import 'Home.dart';
import 'SignUp.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formkey = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  var agree = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 70.h),
                Padding(
                  padding: EdgeInsets.only(top: 40.h),
                  child: Column(
                    children: [
                      Text(
                        'Create Account',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26.sp,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      const Text('Create account and get started'),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Container(
                        margin: EdgeInsets.only(left: 20.w, top: 20.w),
                        child: Text(
                          'Name',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
                      child: TextFormField(
                        controller: name,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please fillout this field';
                          }
                        },
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: const Color(0xffACA9A9),
                          ),
                          fillColor: const Color(0xffEEEEEE),
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
                          hintText: 'Enter name',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.w, top: 20.w),
                      child: Text(
                        'Email',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
                      child: TextFormField(
                        controller: email,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please fillout this field';
                          }
                        },
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: const Color(0xffACA9A9),
                          ),
                          fillColor: const Color(0xffEEEEEE),
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
                          hintText: 'Enter email',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.w, top: 20.w),
                      child: Text(
                        'password',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
                      child: TextFormField(
                        controller: password,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please fillout this field';
                          }
                        },
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: const Color(0xffACA9A9),
                          ),
                          fillColor: const Color(0xffEEEEEE),
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
                          hintText: 'Enter password',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.w, top: 20.w),
                      child: Text(
                        'Confirm Password',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
                      child: TextFormField(
                        controller: confirmpassword,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please fillout this field';
                          } else if (password.text != confirmpassword.text) {
                            return "password doesn't match";
                          }
                        },
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: const Color(0xffACA9A9),
                          ),
                          fillColor: const Color(0xffEEEEEE),
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
                          hintText: 'Retype Password',
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 10.h, left: 20.w),
                            child: Checkbox(
                              value: agree,
                              onChanged: (value) {
                                setState(() {
                                  agree = value!;
                                });
                              },
                              activeColor: Colors.grey,
                              checkColor: Colors.white,
                            )),
                        Container(
                          margin: EdgeInsets.only(left: 10.w, top: 10.h),
                          child: Text(
                            'I agree to the Terms & Conditions',
                            style: TextStyle(
                              color: const Color(0xffACA9A9),
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                        visible: agree == false,
                        child: Container(
                          margin: EdgeInsets.only(left: 30.w, top: 10.h),
                          child: Row(
                            children: [
                              Text(
                                'Please agree to the Terms & Conditions',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
                SizedBox(height: 70.h),
                Column(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()),
                          );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 16.sp),
                        )),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20.w, right: 20.w, bottom: 20.h),
                      child: InkWell(
                        onTap: () async {
                          AuthController controller = AuthController();
                          if (formkey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return Container(
                                    child: const Center(
                                        child: CircularProgressIndicator(
                                  color: Color(0xfffaeaea),
                                )));
                              },
                            );
                            if (agree == true) {
                              var data = await controller.createAccount(
                                  context: context,
                                  email: email.text,
                                  password: password.text,
                                  name: name.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('$data'),
                                  backgroundColor: Colors.blue,
                                ),
                              );
                              if (data == 'Register Successfuly.') {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Home()),
                                );
                              } else {
                                Navigator.of(context).pop();
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please agree to terms and conditions'),
                                  backgroundColor: Colors.blue,
                                ),
                              );
                            }
                          }
                          //
                        },
                        child: Container(
                          height: 60.h,
                          width: 600.w,
                          decoration: BoxDecoration(
                            color: const Color(0xfffaeaea),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
