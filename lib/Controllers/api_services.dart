import 'dart:io';
import 'dart:convert';
import 'dart:io';

import 'package:dio/io.dart';

// import 'package:dio/dio.dart' hide Response, FormData, MultipartFile;
import 'package:dio/dio.dart';
import 'package:political/untils/user_simple_preferences.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:political/untils/export_file.dart';
import 'package:intl/intl.dart';

class ApiService extends GetxService {
//  http://192.168.1.197:5000

//  String baseUrl = "http://192.168.1.197:5000/";
  String baseUrl = "https://twgpost.in/";
  //  String baseUrl = "https://dev.thewisguystech.com/";  //old
  String live_baseUrl = "https://twgpost.in/";
//  String baseUrl = "http://192.168.1.197:5000/"; // main
  // main
  // https://uat-hub.perfios.com/api/kyc/v3/dl
  // https://uat-hub.perfios.com/api/kyc/v2/rc
// https://uat-hub.perfios.com/api/kyc/v3/pan-profile-detailed
  final errorDict = {
    "data": [
      {"error": "Please check your internet connection."}
    ],
    "status": "error"
  };
  ////////////TWG APIS SERVICES
  ///Live apis
  Future<dynamic> livegetRequest({
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(live_baseUrl + endpoint);
    try {
      // var header = {
      //   "Authorization": '${UserSimplePreferences.getToken()}',
      //   //  "accept": 'application/json'
      // };
      var response = await http.get(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //PostRequestCoupons
  Future postRequestSignUpCouponsFormData({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['coupon_code'] = payload['coupon_code'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

/////////////////////////////////
  // post like
  Future postlikeRequest({
    // required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url =
        Uri.parse("https://hook.eu2.make.com/q6d7xfn8lp48epolqhr71h7hb6ssvff2");
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      // dio.options.headers["Authorization"] =
      //     'Bearer ${UserSimplePreferences.getToken()}';
      var response = await dio.post("$url", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

//////////////////////// post issues
  Future postIssuesRequest({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
    File? image,
    File? video,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['volunter_id'] = payload['volunter_id'] ?? ""
        ..fields['name'] = payload['name'] ?? ""
        ..fields['mobile_number'] = payload['mobile_number'] ?? ""
        ..fields['subject'] = payload['subject'] ?? ""
        ..fields['content'] = payload['content'] ?? ""
        ..fields['village'] = payload['village'] ?? ""
        ..fields['mandal'] = payload['mandal'] ?? ""
        ..fields['constitution'] = payload['constitution'] ?? ""

        ////
        ..fields['city'] = payload['city'] ?? ""
        ..fields['pincode'] = payload['pincode'] ?? ""
        ..fields['state'] = payload['state'] ?? ""
        ..fields['issue_type'] = payload['issue_type'] ?? "";

      if (image != null && image.existsSync()) {
        request.files.add(await http.MultipartFile.fromPath(
          'attachment',
          image.path,
          contentType: MediaType('image', 'png'),
        ));
      }

      // Add video if not null
      if (video != null && video.existsSync()) {
        request.files.add(await http.MultipartFile.fromPath(
          'attachment', // Field name expected by the API
          video.path,
          contentType:
              MediaType('video', 'mp4'), // Specify the content type for video
        ));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

//
  Future postRequestDonorSignupFormDatabloodBank({
    File? image,
    File? video,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url =
        Uri.parse("https://hook.eu2.make.com/q6d7xfn8lp48epolqhr71h7hb6ssvff2");

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['language'] = payload['language'] ?? ''
        ..fields['imageTitle'] = payload['imageTitle'] ?? ''
        ..fields['videoTitle'] = payload['videoTitle'] ?? ''
        ..fields['createdTime'] = payload['createdTime'] ?? ''
        ..fields['userId'] = payload['userId'] ?? ''
        ..fields['adminId'] = payload['adminId'] ?? '';

      // Add image if not null
      if (image != null && image.existsSync()) {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          image.path,
          contentType: MediaType('image', 'png'),
        ));
      }

      // Add video if not null
      if (video != null && video.existsSync()) {
        request.files.add(await http.MultipartFile.fromPath(
          'video', // Field name expected by the API
          video.path,
          contentType:
              MediaType('video', 'mp4'), // Specify the content type for video
        ));
      }

      // Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        return {
          "message": "Request failed with status: ${response.statusCode}"
        };
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    } catch (e) {
      return {"message": "An error occurred: $e"};
    }
  }

// ////////
//   Future postRequestDonorSignupFormDatabloodBank({
//     required File image,
//     required File video,
//     required Map<dynamic, dynamic> payload,
//     Map<String, String>? customHeaders,
//   }) async {
//     Uri url =
//         Uri.parse("https://hook.eu2.make.com/q6d7xfn8lp48epolqhr71h7hb6ssvff2");

//     try {
//       var request = http.MultipartRequest('POST', url)
//         ..fields['language'] = payload['language'] ?? ''
//         ..fields['imageTitle'] = payload['imageTitle'] ?? ''
//         ..fields['videoTitle'] = payload['videoTitle'] ?? ''
//         ..fields['createdTime'] = payload['createdTime'] ?? ''
//         ..fields['userEmail'] = payload['userEmail'] ?? '';
//       request.files.add(await http.MultipartFile.fromPath(
//         'image',
//         image.path,
//         contentType: MediaType('image', 'png'),
//       ));
//       request.files.add(await http.MultipartFile.fromPath(
//         'video', // Field name expected by the API
//         video.path,
//         contentType:
//             MediaType('video', 'mp4'), // Specify the content type for video
//       ));
//       var streamedResponse = await request.send();
//       var response = await http.Response.fromStream(streamedResponse);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return response.body;
//       }
//     } on DioError catch (e) {
//       debugPrint("$e");
//       if (e.response?.statusCode == 404) {
//         return e.response?.data;
//       } else if (e.response?.statusCode == 401) {
//         return e.response?.data;
//       } else if (e.response?.statusCode == 400) {
//         return e.response?.data;
//       } else {
//         return {"message": "Something went wrong!"};
//       }
//     }
//   }

  // for video
  Future postRequestDonorSignupFormDatabloodBankvideo({
    required File video,

    // required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url =
        Uri.parse("https://hook.eu2.make.com/q6d7xfn8lp48epolqhr71h7hb6ssvff2");

    try {
      var request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath(
        'video', // Field name expected by the API
        video.path,
        contentType:
            MediaType('video', 'mp4'), // Specify the content type for video
      ));
      // request.files.add(await http.MultipartFile.fromPath(
      //   'image',
      //   image.path,
      //   contentType: MediaType('image', 'png'),
      // ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

/////////////////////////
  /////
  Future postRequestSignInFormData({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['user_email'] = payload['user_email']
        ..fields['user_password'] = payload['user_password'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //// Post ScheduleList
  Future postRequestScheduleData({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['user_id'] = payload['user_id'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

//// ai text
  Future postRequestAiTextData({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
//  "user_id": userprofilecontroller.profileData["user_details"]["id"],
    //    "custom_message": paylodd["customMesg"]
    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['user_id'] = payload['user_id']
        ..fields['custom_message'] = payload['custom_message'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

/////
  // post view
  Future postRequestPostViewData({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['log_id'] = payload['log_id'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // multipost pagenation
  Future postRequestMultipostPagenation({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['user_id'] = payload['user_id']
        ..fields['page'] = payload['page']
        ..fields['limit'] = payload['limit'];
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // post view
  Future postRequestScheduleViewData({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['post_id'] = payload['post_id'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  ///
  ///
  Future postRequestDeleteLogData({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['log_id'] = payload['log_id'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  ///

// edit profile
  Future postRequestEditProfileFormData({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['sap_user_id'] = payload['sap_user_id']
        ..fields['sap_user_fname'] = payload['sap_user_fname']
        ..fields['sap_user_lname'] = payload['sap_user_lname']
        ..fields['sap_user_email'] = payload['sap_user_email'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //Password
  Future postRequestEditProfilePasswordFormData({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['sap_user_id'] = payload['sap_user_id']
        ..fields['sap_user_fname'] = payload['sap_user_fname']
        ..fields['sap_user_lname'] = payload['sap_user_lname']
        ..fields['sap_user_email'] = payload['sap_user_email']
        ..fields['sap_user_password'] = payload['sap_user_password'];

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //
  Future<dynamic> getRequest({
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      var header = {
        "Authorization": '${UserSimplePreferences.getToken()}',
        //  "accept": 'application/json'
      };
      var response = await http.get(url, headers: header);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //////////////////////////////////////////////////////////
  Future putRequest({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response = await dio.put("$url", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  String imagebaseUrl = "http://43.205.34.80:8001/";
  Future putProfileRequest({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      var header = {
        "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      };
      var response = await http.put(url, headers: header, body: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  /////////////
  Future patchRequestEditProfile({
    required File profilePic,
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}';

      request.files.add(await http.MultipartFile.fromPath(
        'profilePic',
        profilePic.path,
        contentType: MediaType('image', 'png'),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

// Upload Resume
  Future patchRequestUploadResume({
    required File profilePic,
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}';

      request.files.add(await http.MultipartFile.fromPath(
        'resume',
        profilePic.path,
        contentType: MediaType('image', 'png'),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

// Upload Resume
  Future patchRequestUploadLetters({
    required File profilePic,
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}';

      request.files.add(await http.MultipartFile.fromPath(
        'experienceLetter',
        profilePic.path,
        contentType: MediaType('image', 'png'),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

// (File license, File pan, File adhar,
//       File authenticationImage, File rc)
  /////////////////////////////Upload DOcs Captain
  Future patchRequestUploadDocs({
    required File license,
    required File pan,
    required File adhar,
    required File authenticationImage,
    required File rc,
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}';

      request.files.add(await http.MultipartFile.fromPath(
        'license',
        license.path,
        contentType: MediaType('image', 'png'),
      ));
      request.files.add(await http.MultipartFile.fromPath(
        'pan',
        pan.path,
        contentType: MediaType('image', 'png'),
      ));
      request.files.add(await http.MultipartFile.fromPath(
        'adhar',
        adhar.path,
        contentType: MediaType('image', 'png'),
      ));
      request.files.add(await http.MultipartFile.fromPath(
        'authenticationImage',
        authenticationImage.path,
        contentType: MediaType('image', 'png'),
      ));
      request.files.add(await http.MultipartFile.fromPath(
        'rc',
        rc.path,
        contentType: MediaType('image', 'png'),
      ));
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //////////////////////////////////////////////////////////////////////////////
  Future patchRequestUploadVrefiDocs({
    required File pan,
    required File adhar,
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}';

      request.files.add(await http.MultipartFile.fromPath(
        'pan',
        pan.path,
        contentType: MediaType('image', 'png'),
      ));
      request.files.add(await http.MultipartFile.fromPath(
        'adhar',
        adhar.path,
        contentType: MediaType('image', 'png'),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }
  ////////////////////////////////////////////////////////////////

  ///////////////////User Upload DOcs
  Future patchRequestUserUploadDocs({
    required File authenticationImage,
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}';

      request.files.add(await http.MultipartFile.fromPath(
        'authenticationImage',
        authenticationImage.path,
        contentType: MediaType('image', 'png'),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //////////////////////////////////////CaptainDutyAPi///////////////////////////
  Future patchRequestCaptainDuty({
    required File profilePic,
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}';

      request.files.add(await http.MultipartFile.fromPath(
        'captainLiveImage',
        profilePic.path,
        contentType: MediaType('image', 'png'),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }
  ////////////////////////////////////////////////////////////////////////////////

  //////////
  ///
  Future patchRequestEditProfilebank({
    required File profilePic,
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('PATCH', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}'
        ..fields['bloodBankName'] = payload['bloodBankName'];
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        profilePic.path,
        contentType: MediaType('image', 'png'), // or other image type
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  Future postRequestwithImageandToken({
    required File profilePic,
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //////////////////////////////////////////////////////////////////////

    ///////////////////////////////////////////////////////////
    try {
      var request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] =
            'Bearer ${UserSimplePreferences.getToken()}'
        ..fields['leaveType'] = payload['leaveType']
        ..fields['dateRange'] = payload['dateRange']
        ..fields['reason'] = payload['reason'];

      request.files.add(await http.MultipartFile.fromPath(
        'documente',
        profilePic.path,
        contentType: MediaType('image', 'png'), // or other image type
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  ///Post  request form data
  Future postRequestDonorSignupFormData({
    required File image,
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    //   //   'first_name': payload['firstName'],
    //   //   'last_name': payload['lastName'],
    try {
      var request = http.MultipartRequest('POST', url)
        // ..headers['Authorization'] =
        //     'Bearer ${UserSimplePreferences.getToken()}'  // termsAndCondition
        ..fields['email'] = payload['email']
        ..fields['password'] = payload['password']
        ..fields['firstName'] = payload['firstName']
        ..fields['lastName'] = payload['lastName']
        ..fields['empId'] = payload['empId']
        ..fields['dateOfBirth'] = payload['dateOfBirth']
        ..fields['role'] = payload['role']
        ..fields['gender'] = payload['gender']
        ..fields['companyName'] = payload['companyName']
        ..fields['termsAndCondition'] = payload['termsAndCondition'];

      request.files.add(await http.MultipartFile.fromPath(
        'authenticationImage',
        image.path,
        contentType: MediaType('image', 'png'), // or other image type
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      // else {
      //   print('Failed to update profile: ${response.reasonPhrase}');
      //   print('Response body: ${response.body}');
      // }
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
      // var header = {
      //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      // };
      // var response = await http.patch(url, headers: header, body: payload);
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return response.body;
      // }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

///////////////////////
//{
  // "dropLangitude": "17.413973667114202",
//  "dropLongitude": "78.37360815684931",
  // "pickupLangitude": "17.419151642685726",
  // "pickupLongitude": "78.3889548353466",
//  "pickupAddress": "Raidurg",
  // "dropAddress": "Sutherland",
  // "price": "250",
  // "orderPlaceTime": "08:09 AM",
  // "orderPlaceDate": "04-07-2024",
  // "vehicleType": "bike"
//}
///////////////////
  // UserBookRide with Image
  ////////////////////////////////////////////////////////////////////////////////////////

  Future postRequestUserBookFormData({
    required File image,
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    required String token,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['dropLangitude'] = payload['dropLangitude']
        ..fields['dropLongitude'] = payload['dropLongitude']
        ..fields['pickupLangitude'] = payload['pickupLangitude']
        ..fields['pickupLongitude'] = payload['pickupLongitude']
        ..fields['pickupAddress'] = payload['pickupAddress']
        ..fields['dropAddress'] = payload['dropAddress']
        ..fields['price'] = payload['price']
        ..fields['orderPlaceTime'] = payload['orderPlaceTime']
        ..fields['orderPlaceDate'] = payload['orderPlaceDate']
        ..fields['vehicleType'] = payload['vehicleType'];

      request.files.add(await http.MultipartFile.fromPath(
        'userAuthenticationImage',
        image.path,
        contentType: MediaType('image', 'png'), // or other image type
      ));

      // Add the token to the headers
      request.headers['Authorization'] = 'Bearer $token';

      // Add custom headers if any
      if (customHeaders != null) {
        request.headers.addAll(customHeaders);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        debugPrint('Failed to update profile: ${response.reasonPhrase}');
        debugPrint('Response body: ${response.body}');
        return {"message": "Failed to update profile"};
      }
    } catch (e) {
      debugPrint("$e");
      if (e is DioError) {
        if (e.response?.statusCode == 404) {
          return e.response?.data;
        } else if (e.response?.statusCode == 401) {
          return e.response?.data;
        } else if (e.response?.statusCode == 400) {
          return e.response?.data;
        } else {
          return {"message": "Something went wrong!"};
        }
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////
  // Future postRequestUserBookFormData({
  //   required File image,
  //   required String endpoint,
  //   required Map<dynamic, dynamic> payload,
  //   Map<String, String>? customHeaders,
  // }) async {
  //   Uri url = Uri.parse(baseUrl + endpoint);
  //   //   //   'first_name': payload['firstName'],
  //   //   //   'last_name': payload['lastName'],
  //   try {
  //     var request = http.MultipartRequest('POST', url)

  //       ..fields['dropLangitude'] = payload['dropLangitude']
  //       ..fields['dropLongitude'] = payload['dropLongitude']
  //       ..fields['pickupLangitude'] = payload['pickupLangitude']
  //       ..fields['pickupLongitude'] = payload['pickupLongitude']
  //       ..fields['pickupAddress'] = payload['pickupAddress']
  //       ..fields['dropAddress'] = payload['dropAddress']
  //       ..fields['price'] = payload['price']
  //       ..fields['orderPlaceTime'] = payload['orderPlaceTime']
  //       ..fields['orderPlaceDate'] = payload['orderPlaceDate']
  //       ..fields['vehicleType'] = payload['vehicleType'];

  //     request.files.add(await http.MultipartFile.fromPath(
  //       'userAuthenticationImage',
  //       image.path,
  //       contentType: MediaType('image', 'png'), // or other image type
  //     ));

  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return response.body;
  //     }
  //     // else {
  //     //   print('Failed to update profile: ${response.reasonPhrase}');
  //     //   print('Response body: ${response.body}');
  //     // }
  //     // if (response.statusCode == 200 || response.statusCode == 201) {
  //     //   return response.body;
  //     // }
  //     // var header = {
  //     //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
  //     // };
  //     // var response = await http.patch(url, headers: header, body: payload);
  //     // if (response.statusCode == 200 || response.statusCode == 201) {
  //     //   return response.body;
  //     // }
  //   } on DioError catch (e) {
  //     debugPrint("$e");
  //     if (e.response?.statusCode == 404) {
  //       return e.response?.data;
  //     } else if (e.response?.statusCode == 401) {
  //       return e.response?.data;
  //     } else if (e.response?.statusCode == 400) {
  //       return e.response?.data;
  //     } else {
  //       return {"message": "Something went wrong!"};
  //     }
  //   }
  // }

  ///

  //]
  // Future postRequestDonorSignupFormDatabloodBank({
  //   required File image,
  //   required String endpoint,
  //   required Map<dynamic, dynamic> payload,
  //   Map<String, String>? customHeaders,
  // }) async {
  //   Uri url = Uri.parse(baseUrl + endpoint);
  //   //   //   'first_name': payload['firstName'],
  //   //   //   'last_name': payload['lastName'],
  //   try {
  //     var request = http.MultipartRequest('POST', url)
  //       // ..headers['Authorization'] =
  //       //     'Bearer ${UserSimplePreferences.getToken()}'
  //       ..fields['bloodBankName'] = payload['bloodBankName']
  //       // ..fields['lastName'] = payload['lastName']
  //       ..fields['mobile'] = payload['mobile']
  //       ..fields['email'] = payload['email']
  //       // ..fields['dateOfBirth'] = payload['dateOfBirth']
  //       // ..fields['bloodGroup'] = payload['bloodGroup']
  //       // ..fields['gender'] = payload['gender']
  //       // ..fields['locations'] = payload['locations']
  //       ..fields['address'] = payload['address']
  //       ..fields['longitude'] = payload['longitude']
  //       ..fields['latitude'] = payload['latitude']
  //       // ..fields['signupTime'] = payload['signupTime']
  //       ..fields['termAndCondition'] = payload['termAndCondition'];

  //     request.files.add(await http.MultipartFile.fromPath(
  //       'image',
  //       image.path,
  //       contentType: MediaType('image', 'png'), // or other image type
  //     ));

  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return response.body;
  //     }
  //     // else {
  //     //   print('Failed to update profile: ${response.reasonPhrase}');
  //     //   print('Response body: ${response.body}');
  //     // }
  //     // if (response.statusCode == 200 || response.statusCode == 201) {
  //     //   return response.body;
  //     // }
  //     // var header = {
  //     //   "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
  //     // };
  //     // var response = await http.patch(url, headers: header, body: payload);
  //     // if (response.statusCode == 200 || response.statusCode == 201) {
  //     //   return response.body;
  //     // }
  //   } on DioError catch (e) {
  //     debugPrint("$e");
  //     if (e.response?.statusCode == 404) {
  //       return e.response?.data;
  //     } else if (e.response?.statusCode == 401) {
  //       return e.response?.data;
  //     } else if (e.response?.statusCode == 400) {
  //       return e.response?.data;
  //     } else {
  //       return {"message": "Something went wrong!"};
  //     }
  //   }
  // }

  //

  //////////
  //  var request = http.MultipartRequest('PATCH', url)
  //     ..headers['Authorization'] = 'Bearer $authToken'
  //     ..fields['first_name'] = firstName
  //     ..fields['last_name'] = lastName;

  //   // Add the profile picture file
  //   if (profilePic != null) {
  //     request.files.add(await http.MultipartFile.fromPath(
  //       'profile_pic',
  //       profilePic.path,
  //       contentType: MediaType('image', 'jpeg'), // or other image type
  //     ));
  //   }

  //   // Send the request
  //   var response = await request.send();
  ////////

  Future postRequest({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response = await dio.post("$url", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

// DonorRegister
  Future postRequestDonorRegister({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = '*/*';

      var response = await dio.post("$url", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // Postno Token

  Future<Map<String, dynamic>> postRequestNotoken({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint
        // "http://womenrapido.nuhvin.com/auth/send-otp"
        ); // Replace with your baseUrl + endpoint if needed

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }

    try {
      var response = await http.post(
        url,
        headers: headers,
        body: json.encode(payload),
      );

      // Handle 301 status code
      if (response.statusCode == 301 || response.statusCode == 302) {
        String? newUrl = response.headers['location'];
        if (newUrl != null) {
          url = Uri.parse(newUrl);
          response = await http.post(
            url,
            headers: headers,
            body: json.encode(payload),
          );
        }
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        return handleError(response);
      }
    } catch (e) {
      debugPrint("$e");
      return {"message": "Something went wrong!"};
    }
  }

  Map<String, dynamic> handleError(http.Response response) {
    if (response.statusCode == 404 ||
        response.statusCode == 401 ||
        response.statusCode == 400) {
      return json.decode(response.body);
    } else {
      return {"message": "Something went wrong!"};
    }
  }

//   import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

  // Future<Map<String, dynamic>> postRequestNotoken({
  //   required String endpoint,
  //   required Map<dynamic, dynamic> payload,
  //   Map<String, String>? customHeaders,
  // }) async {
  //   Uri url = Uri.parse(
  //       "http://womenrapido.nuhvin.com/auth/send-otp/"); // Replace with your baseUrl + endpoint if needed

  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   };

  //   if (customHeaders != null) {
  //     headers.addAll(customHeaders);
  //   }

  //   try {
  //     var response = await http.post(
  //       url,
  //       headers: headers,
  //       body: json.encode(payload),
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return json.decode(response.body);
  //     } else {
  //       return handleError(response);
  //     }
  //   } catch (e) {
  //     debugPrint("$e");
  //     return {"message": "Something went wrong!"};
  //   }
  // }

  // Map<String, dynamic> handleError(http.Response response) {
  //   if (response.statusCode == 404 ||
  //       response.statusCode == 401 ||
  //       response.statusCode == 400) {
  //     return json.decode(response.body);
  //   } else {
  //     return {"message": "Something went wrong!"};
  //   }
  // }

  Future postRequestNotokentwo({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';

      var response = await dio.post("$url", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //PostToken
  Future postRequestToken({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';

      var response = await dio.post("$url",
          //  "https://blood-server-us7o.onrender.com/auth/registor/donor",
          data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  /////////////////////Verify Docs

  //PostToken
  // Future postRequestTokenVerifyDocs({
  //   required String endpoint,
  //   required Map<dynamic, dynamic> payload,
  //   Map<String, String>? customHeaders,
  // }) async {
  //   Uri url = Uri.parse(VerificationUrl + endpoint);
  //   try {
  //     Dio dio = Dio();
  //     dio.options.headers["content-type"] = 'application/json';
  //     dio.options.headers["accept"] = 'application/json';
  //     dio.options.headers["x-auth-key"] = "q4Ewu5OELeimuoiS";

  //     var response = await dio.post("$url",
  //         //  "https://blood-server-us7o.onrender.com/auth/registor/donor",
  //         data: payload);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return response.data;
  //     }
  //   } on DioError catch (e) {
  //     debugPrint("$e");
  //     if (e.response?.statusCode == 404) {
  //       return e.response?.data;
  //     } else if (e.response?.statusCode == 401) {
  //       return e.response?.data;
  //     } else if (e.response?.statusCode == 400) {
  //       return e.response?.data;
  //     } else {
  //       return {"message": "Something went wrong!"};
  //     }
  //   }
  // }

  // Post patch

  // Future patchRequestEditProfile({
  //   required File profilePic,
  //   required String endpoint,
  //   required Map<dynamic, dynamic> payload,
  //   Map<String, String>? customHeaders,
  // }) async {
  //   Uri url = Uri.parse(baseUrl + endpoint);
  //   try {

  //   //   Dio dio = Dio();

  //   //   dio.options.headers["content-type"] = 'application/json';
  //   //   dio.options.headers["accept"] = 'application/json';
  //   //   String fileName = profilePic.path.split('/').last;

  //   // FormData formData = FormData.fromMap({
  //   //   "profile_image": await MultipartFile.fromFile(
  //   //     file.path,
  //   //     filename: fileName,
  //   //   ),
  //   // });
  //   // //   FormData formData = FormData.fromMap({
  //   //   'first_name': payload['firstName'],
  //   //   'last_name': payload['lastName'],
  //   //   'image': await MultipartFile.fromBytes(
  //   //     'image', // Field name
  //   //     profilePic.readAsBytes(),
  //   //     filename: fileName, // Specify the filename
  //   //     contentType: MediaType('image', 'jpg'), // Set the content type
  //   //   ),
  //   // });
  //     // FormData formData = FormData();
  //     // formData.fields
  //     //   ..add(MapEntry('first_name', payload["firstName"]))
  //     //   ..add(MapEntry('last_name', payload["lastName"]));
  //     // formData.files.add(MapEntry(
  //     //   'image',
  //     //   await MultipartFile.fromFile(profilePic.path, filename: fileName),
  //     // )
  //     // );

  //    // var response = await dio.patch("$url", data: payload);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return response.data;
  //     }
  //   } on DioError catch (e) {
  //     debugPrint("$e");
  //     if (e.response?.statusCode == 404) {
  //       return e.response?.data;
  //     } else if (e.response?.statusCode == 401) {
  //       return e.response?.data;
  //     } else if (e.response?.statusCode == 400) {
  //       return e.response?.data;
  //     } else {
  //       return {"message": "Something went wrong!"};
  //     }
  //   }
  // }
  // ///////////////////

  //     FormData formData = FormData();
  //     formData.fields
  //       ..add(MapEntry('first_name', firstName))
  //       ..add(MapEntry('last_name', lastName));
  //     formData.files.add(MapEntry(
  //       'profile_pic',
  //       await MultipartFile.fromFile(profilePic.path, filename: fileName),
  //     ));

  //     Response response = await _dio.patch('/users/$userId', data: formData);

  // ////////////
  Future patchRequestList({
    required String endpoint,
    required List payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';

      var response = await dio.post("$url", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //

  Future patchRequest({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';

      var response = await dio.patch("$url", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //pastch no tokrn
  Future patchRequestNoToken({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';

      var response = await dio.patch("$url", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // PatchRequestNo Payload
  Future patchRequestNopayload({
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';

      var response = await dio.patch("$url");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // post like

  Future deleteRequest({
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      Dio dio = Dio();
      dio.options.headers["content-type"] = 'application/json';
      dio.options.headers["accept"] = 'application/json';
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response = await dio.delete("$url");
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return response.data;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  Future<dynamic> postAuthRequest({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      var response = await http.post(url, body: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else if (response.statusCode == 404) {
        return response.body;
      } else if (response.statusCode == 401) {
        return response.body;
      } else if (response.statusCode == 400) {
        return response.body;
      } else if (response.statusCode == 500) {
        return response.body;
      } else {
        return {"message": "Something went wrong!"};
      }
    } on DioError catch (e) {
      debugPrint("$e");
      return {"message": "$e"};
    }
  }

  //

// Get Token
/////////////////////////////////////////////////////////////////////////////////

  Future<dynamic> getter({
    required String endpoint,
  }) async {
    Uri url = Uri.parse(
        baseUrl + endpoint); // Replace with your baseUrl + endpoint if needed

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserSimplePreferences.getToken()}'
    };

    try {
      var response = await http.get(
        url,
        headers: headers,
      );

      // Handle 301 status code
      if (response.statusCode == 301 || response.statusCode == 302) {
        String? newUrl = response.headers['location'];
        if (newUrl != null) {
          url = Uri.parse(newUrl);
          response = await http.get(
            url,
            headers: headers,
          );
        }
      }

      //    if (response.statusCode == 200) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
        // return json.decode(response.body);
      } else {
        return handleGetError(response);
      }
    } catch (e) {
      debugPrint("$e");
      return {"message": "Something went wrong!"};
    }
  }

  Map<String, dynamic> handleGetError(http.Response response) {
    if (response.statusCode == 404 ||
        response.statusCode == 401 ||
        response.statusCode == 400) {
      return json.decode(response.body);
    } else {
      return {"message": "Something went wrong!"};
    }
  }

//////////////////////////////////////////////

  // GetNoToken
  Future<dynamic> getRequestNoToken({
    required String endpoint,
    Map<String, String>? customHeaders,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      var response = await http.get(url);
      // var response = await http.get(url, headers: header);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  Future<dynamic> postreportRequest({
    required String endpoint,
    Map<String, String>? customHeaders,
    required Map<dynamic, dynamic> payload,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      var header = {
        "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      };
      var response = await http.post(url, body: payload, headers: header);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
    } on DioError catch (e) {
      debugPrint("$e");
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static updateProfilePhoto(File file) {}
  Future<dynamic> putForProfileUpdateRequest({
    required String endpoint,
    required Map<dynamic, dynamic> payload,
    Map<String, String>? customHeaders,
    File? image,
  }) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      var headers = {
        "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      };
      var request = http.MultipartRequest('PUT', Uri.parse(baseUrl + endpoint));
      request.fields.addAll({
        'full_name': payload["full_name"],
        'phone': payload["phone"],
        'gender': payload["gender"],
        'constituency': payload["constituency"]
      });
      if (image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', image.path));
      }
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return {"status": "Updated"};
      } else {
        return ({"message": response.reasonPhrase});
      }
    } on DioError catch (e) {
      return {"message": "$e"};
    }
  }

  Future<dynamic> postReportRequest(
      {required String endpoint,
      required Map<dynamic, dynamic> payload,
      Map<String, String>? customHeaders,
      File? problem,
      File? salefe}) async {
    Uri url = Uri.parse(baseUrl + endpoint);
    try {
      var headers = {
        "Authorization": 'Bearer ${UserSimplePreferences.getToken()}'
      };
      var request =
          http.MultipartRequest('POST', Uri.parse(baseUrl + endpoint));
      request.fields.addAll({
        'full_name': payload["full_name"],
        'email': payload["email"],
        'mobile_no': payload["mobile_no"],
        'pincode': payload["pincode"],
        'city': payload["city"],
        'state': payload["state"],
        'address': payload["address"],
        'report': payload["report"],
      });
      if (problem != null) {
        request.files.add(
            await http.MultipartFile.fromPath('report_image', problem.path));
      }
      if (salefe != null) {
        request.files.add(
            await http.MultipartFile.fromPath('reporter_selfie', salefe.path));
      }
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return {"status": "Updated"};
      } else {
        return ({"message": response.reasonPhrase});
      }
    } on DioError catch (e) {
      return {"message": "$e"};
    }
  }
}
