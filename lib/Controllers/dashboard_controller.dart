import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:political/untils/export_file.dart';
import 'package:intl/intl.dart';

import 'dart:convert';
import 'dart:io';

import 'package:video_player/video_player.dart';

class DashboardController extends GetxController {
  final apiService = Get.put(ApiService());
  var isFormselected = false.obs;
  var selectedQuickPost = "Auto Post".obs;
  var today = ''.obs;
  var selectedPublishedorScheduled = "Published".obs;
  var selectedMediaType = "".obs;
  var selectedMediaChannels = "".obs;
  var selectedSocialPlatform = "General".obs;
  var selectedAllItem = "".obs;
  var selectedAnaliyics = "All".obs;
  var selectedSocialMediaGraph = "".obs;
  var isCustomSelected = false.obs;
  var autoPostUploadType = "image".obs;
  var selectappmethidType = "appmethod".obs;
  var sfileTpye = "image".obs;
  var choosenAutoCRMTool = "".obs;
  var userEmail = ''.obs;
/////////////////////////////
  TextEditingController imageTitleController = TextEditingController();
  TextEditingController videoTitleController = TextEditingController();
//
//
//
//

//   'constitution': 'test',
//   'city': 'test',
//   'pincode': '500033',
//   'state': 'test',
//   'issue_type': 'health'
  TextEditingController issuename = TextEditingController();
  TextEditingController issuemobile = TextEditingController();
  TextEditingController issuesubject = TextEditingController();
  TextEditingController issuecontent = TextEditingController();
  TextEditingController issuevillage = TextEditingController();
  TextEditingController issuemandal = TextEditingController();
  TextEditingController issueconstitution = TextEditingController();
  TextEditingController issuecity = TextEditingController();
  TextEditingController issuepincode = TextEditingController();
  TextEditingController issuestate = TextEditingController();

  var profileData = {}.obs;
/////
  ///
  var selectedImageobss = Rxn<File>();

  // Function to update the selected file
  void setSelectedImage(File? imageFile) {
    selectedImageobss.value = imageFile;
  }

////////////////////////for video
  // Reactive variable for the selected video
  var selectedVideos = Rxn<File>();

  // Method to update the selected image

  // Method to update the selected video
  void updateSelectedVideo(File? video) {
    selectedVideos.value = video;
    print("object");
  }
//////
  // Forvideo

  Rxn<File> selectedVideo = Rxn<File>(); // Store selected video file
  VideoPlayerController? _videoPlayerController; // Video player controller
  var isPlaying = false.obs; // Track if the video is playing

  // Getter for the private video player controller
  VideoPlayerController? get videoPlayerController => _videoPlayerController;

  // Function to set the selected video
  void setSelectedVideo(File? videoFile) {
    selectedVideo.value = videoFile;
    if (videoFile != null) {
      _initializeVideoPlayer(videoFile);
    }
  }

  // Function to initialize the video player
  void _initializeVideoPlayer(File videoFile) {
    _videoPlayerController = VideoPlayerController.file(videoFile)
      ..initialize().then((_) {
        update(); // Notify listeners when the video is initialized
      });
  }

  // Play or pause the video
  void togglePlayPause() {
    if (_videoPlayerController != null) {
      if (isPlaying.value) {
        _videoPlayerController!.pause();
      } else {
        _videoPlayerController!.play();
      }
      isPlaying.value = !isPlaying.value; // Toggle play/pause state
    }
  }

  @override
  void onClose() {
    // Dispose of the controller when the widget is disposed
    _videoPlayerController?.dispose();
    super.onClose();
  }

  /////
  TextEditingController v1 = TextEditingController();
  TextEditingController v2 = TextEditingController();
  TextEditingController v3 = TextEditingController();
  TextEditingController v4 = TextEditingController();
  TextEditingController v5 = TextEditingController();
  // Dev api // Dashboard Social Media
  var dashboardTotalSocialPosts = {}.obs;
  var networkCountList = [].obs;
  var dashboardTotalSocialPostsLoading = false.obs;

  // Dev api // Dashboard statictics api
  var choosenFromCategory = ''.obs;
  var dashboardTotalPosts = {}.obs;
  var dashboardTotalPostsLoading = false.obs;
  ///////////////////////////smb app
  Rx<File?> selectedImage = Rx<File?>(null);

  // Method to update the selected image
  void updateSelectedImage(File? image) {
    selectedImage.value = image;
    print("object");
  }

  // add comment and image
  var addFormLoading = false.obs;
  Future<void> addFormCommment(Map payload) async {
    addFormLoading(true);

    //   "employee_id": scannedData["employee_id"],
    //   "employee_name": scannedData["employee_name"],
    //   "employee_designation": scannedData["employee_designation"],
    //   "profilepic": "base64 ${base64ImageValue.value}",
    //   "lat": "",
    //   "log": ""
    // };
    try {
      //
      var response = await apiService.postRequestDonorSignupFormDatabloodBank(
          payload: payload,
          video: selectedVideos.value,
          image: selectedImage.value);

      String data = response;
      print(data);

      if (data == "Accepted") {
        // Fluttertoast.showToast(
        //   msg: data,
        // );
        Fluttertoast.showToast(
          msg: "Submitted Successfully",
        );
        if (selectedImage.value != null) {
          updateSelectedImage(null);
        }
        if (selectedVideos.value != null) {
          updateSelectedVideo(null);
        }

        // else {
        //   Fluttertoast.showToast(
        //     msg: "Submitted Successfully",
        //   );
        // }

        // uploadImage();
        //here
      } else {
        Fluttertoast.showToast(
          msg: data,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      addFormLoading(false);
    }
  }

// post issues
  // add comment and image
  var postIssueLoading = false.obs;
  Future<void> postIssues(Map payload) async {
    postIssueLoading(true);

    //   "employee_id": scannedData["employee_id"],
    //   "employee_name": scannedData["employee_name"],
    //   "employee_designation": scannedData["employee_designation"],
    //   "profilepic": "base64 ${base64ImageValue.value}",
    //   "lat": "",
    //   "log": ""
    // };
    try {
      //
      //    var response = await apiService.postRequestDonorSignupFormDatabloodBank(
      var response = await apiService.postIssuesRequest(
          endpoint: "local_issues/upload/",
          payload: payload,
          video: selectedVideos.value,
          image: selectedImage.value);
// https://twgpost.in/local_issues/upload/
      Map data = jsonDecode(response);
      print(data);
// {"success":"Issue created successfully"}
      if (data["success"] == "Issue created successfully") {
        // Fluttertoast.showToast(
        //   msg: data,
        // );
        Fluttertoast.showToast(
          msg: "Submitted Successfully",
        );
        if (selectedImage.value != null) {
          updateSelectedImage(null);
        }
        if (selectedVideos.value != null) {
          updateSelectedVideo(null);
        }

        // else {
        //   Fluttertoast.showToast(
        //     msg: "Submitted Successfully",
        //   );
        // }

        // uploadImage();
        //here
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
      );
    } finally {
      postIssueLoading(false);
    }
  }
//
  // ///
  // Future<void> uploadImage() async {
  //   addFormLoading(true);

  //   try {
  //     var response = await apiService.postRequestDonorSignupFormDatabloodBank(
  //         // payload: payload,
  //         image: selectedImage.value!);

  //     String data = response;
  //     print(data);

  //     if (data == "Accepted") {
  //       if (selectedVideos.value != null) {
  //         uploadVideo();
  //       } else {
  //         Fluttertoast.showToast(
  //           msg: "Uploaded Successfully",
  //         );
  //       }
  //       updateSelectedImage(null);
  //       // Get.toNamed(kHome);
  //     } else {
  //       Fluttertoast.showToast(
  //         msg: data,
  //       );
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(
  //       msg: "Something went wrong",
  //     );
  //   } finally {
  //     addFormLoading(false);
  //   }
  // }

  // // video
  // Future<void> uploadVideo() async {
  //   addFormLoading(true);

  //   try {
  //     var response =
  //         await apiService.postRequestDonorSignupFormDatabloodBankvideo(
  //             // payload: payload,
  //             video: selectedVideos.value!);

  //     String data = response;
  //     print(data);

  //     if (data == "Accepted") {
  //       Fluttertoast.showToast(
  //         msg: "Files Uploaded Successfully",
  //       );
  //       updateSelectedVideo(null);
  //       // Get.toNamed(kHome);
  //     } else {
  //       Fluttertoast.showToast(
  //         msg: data,
  //       );
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(
  //       msg: "Something went wrong",
  //     );
  //   } finally {
  //     addFormLoading(false);
  //   }
  // }
}
