import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

const String baseUrl = 'https://admin.pixelcare.co.uk';

// https://pixelcare.stackbuffers.com
class AuthController {
  createAccount(
      {var name, var email, var password, scaffoldKey, context}) async {
    var response = await http.post(Uri.parse(
        '$baseUrl/api/user/store?name=$name&email=$email&password=$password'));
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['message'] == 'Register Successfuly.') {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool('Logined', true);
        pref.setString('userPersonalInfo', response.body);
        pref.setString('token', jsonDecode(response.body)['token']);
      }
      return jsonDecode(response.body)['message'];
    } else {
      // print(response.body);
      return 'Registeration Failed';
    }
  }

  loginAccount({var email, var password, scaffoldKey, context}) async {
    var response = await http.post(
        Uri.parse('$baseUrl/api/care-home/user/login'),
        body: {'email': email.toString(), 'password': password.toString()});
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['message'] == 'Login Successfuly.') {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool('Logined', true);
        // print(jsonDecode(response.body)['token']);
        pref.setString('token', jsonDecode(response.body)['token']);
        pref.setString('userPersonalInfo', response.body);
      }
      return jsonDecode(response.body)['message'];
    } else {
      return 'Registeration Failed';
    }
  }

  updatePassword(
      {var oldPassword,
      var newPassword,
      var password,
      scaffoldKey,
      context}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    var response = await http.post(
        Uri.parse(
            '$baseUrl/api/user/update/password?old_password=$oldPassword&new_password=$newPassword'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    } else {
      return 'Registeration Failed';
    }
  }

  Future<UserModel> getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    final url = Uri.parse('$baseUrl/api/care-home/user/profile');
    final response = await http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      // print(jsonDecode(response.body));
    }
    // print(UserModel.fromJson(jsonDecode(response.body)));
    return UserModel.fromJson(jsonDecode(response.body));
  }

  deleteStaff(id) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = pref.getString('token');
      var headers = {'Authorization': 'Bearer $token'};
      var request = http.Request(
        'DELETE',
        Uri.parse(
          '$baseUrl/api/care-home/request-staff/delete/$id',
        ),
      );

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // print(jsonDecode(await response.stream.bytesToString())['message'].toString());
      return jsonDecode(await response.stream.bytesToString())['message'];
    } catch (e) {
      rethrow;
    }
  }
}
