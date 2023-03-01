// ignore_for_file: use_build_context_synchronously

import 'package:carehome/View/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AuthController.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> formkey = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  bool isChecked = false;
  bool isPasswordHidden = true;

  checkPassword() async {
    SharedPreferences p = await SharedPreferences.getInstance();

    if (p.getString("password") != null && p.getString("Uemail") != null) {
      email.text = p.getString("Uemail")!;
      password.text = p.getString("password")!;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    checkPassword();
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.green;
    }

    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 50.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  const Text('Excited to welcome you'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20.w, top: 20.w),
                    child: Text(
                      'Email',
                      style: TextStyle(fontSize: 18.sp),
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
                          fontSize: 14.sp,
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
                      'Password',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
                    child: TextFormField(
                      obscureText: isPasswordHidden,
                      obscuringCharacter: "*",
                      controller: password,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please fillout this field';
                        }
                      },
                      decoration: InputDecoration(
                        suffix: InkWell(
                            onTap: () {
                              isPasswordHidden = !isPasswordHidden;
                              setState(() {});
                            },
                            child: Icon(
                              isPasswordHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color(0xffF5591f),
                            )),
                        hintStyle: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
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
                        hintText: 'Enter Password',
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Container(
                        child: Text(
                          'Remember Password!',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 133, 55),
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 18.w),
                      Container(
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: const Color(0xff3b53a4),
                            fontSize: 17.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.3.h),
              Column(
                children: [
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
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
                          var data = await controller.loginAccount(
                            context: context,
                            email: email.text,
                            password: password.text,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.blue,
                              content: Text('${data}'),
                            ),
                          );
                          if (data == 'Login Successfuly.') {
                            if (isChecked) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString("password", password.text);
                              prefs.setString("Uemail", email.text);
                            }
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Home(),
                              ),
                              (route) => false,
                            );
                          } else {
                            Navigator.of(context).pop();
                          }
                        }
                        //
                      },
                      child: Container(
                        height: 60.h,
                        width: 600.w,
                        decoration: BoxDecoration(
                          color: email.text != "" && password.text != ""
                              ? Colors.pink
                              : const Color(0xfffaeaea),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: email.text != "" && password.text != ""
                                  ? Colors.white
                                  : Colors.black,
                            ),
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
      )),
    );
  }
}
