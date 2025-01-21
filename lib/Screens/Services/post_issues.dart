import 'dart:convert';
import 'dart:io';

import 'package:image_pickers/image_pickers.dart';
import 'package:political/untils/export_file.dart';
import 'package:video_player/video_player.dart';

class PostIssues extends StatefulWidget {
  const PostIssues({super.key});

  @override
  State<PostIssues> createState() => _PostIssuesState();
}

class _PostIssuesState extends State<PostIssues> {
  DashboardController dashboardController = Get.put(DashboardController());
  var serviceData = Get.arguments;
  bool showimagenullMessage = false;
  String? selectedUserValue;
  String base64Image = "";
  File? selectedImage;
  final List<String> fileType = ['image', 'video'];

  ///
  List<Media> _listVideoPaths = [];
  String description = "";
  int? totalAmount;
  String? str;
  File? selectedVideo;
  VideoPlayerController? _videoController;
  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> pickVideo() async {
    try {
      _listVideoPaths = await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.video,
        selectCount: 1,
        showCamera: false,
      );

      if (_listVideoPaths.isNotEmpty) {
        final videoPath = _listVideoPaths[0].path;

        if (videoPath != null) {
          setState(() {
            selectedVideo = File(videoPath);
            _videoController = VideoPlayerController.file(selectedVideo!)
              ..initialize().then((_) {
                setState(() {}); // Refresh UI when video is loaded
              });
          });
          dashboardController.updateSelectedVideo(selectedVideo!);
        }
      }
    } catch (e) {
      print("Error picking video: $e");
    }
  }

  /////
  Future<void> chooseImage(type) async {
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 10,
      );
    } else {
      image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 10);
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        //  dashboardcontroller.setSelectedImage(selectedImage);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
        dashboardController.updateSelectedImage(selectedImage!);
        // profilecontroller.editProfilePicture(selectedImage!); //
        print(selectedImage!.readAsBytesSync().lengthInBytes);
        final kb = selectedImage!.readAsBytesSync().lengthInBytes / 1024;
        print(kb);
        final mb = kb / 1024;
        print(mb);
        print("ram b jk dslnkv flk dlkcdslc k");
        showimagenullMessage = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Kwhite,
        appBar: AppBar(
            elevation: 3,
            shadowColor: kblack,
            backgroundColor: KPartyThemeOne,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Kwhite,
                size: 23.sp,
              ),
            ),
            title: Text(
              serviceData["tile"] + " issues",
              style: GoogleFonts.poppins(
                  color: Kwhite, fontSize: kSixteenFont, fontWeight: kFW600),
            )),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(16),
            child: Column(
              children: [
                // Divider(
                //   color: Kwhite.withOpacity(0.5),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(300),
                      child: Image.asset(
                        // kBaseImageUrl
                        "assets/images/fbb.png",
                        height: 30,
                        width: 30,
                        fit: BoxFit.cover,
                        // width: 25.h,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(300),
                      child: Image.asset(
                        // kBaseImageUrl
                        "assets/images/inn.png",
                        height: 30,
                        width: 30,
                        fit: BoxFit.cover,
                        // width: 25.h,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(300),
                      child: Image.asset(
                        // kBaseImageUrl
                        "assets/images/insta.png",
                        height: 30,
                        width: 30,
                        fit: BoxFit.cover,
                        // width: 25.h,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(300),
                      child: Image.asset(
                        // kBaseImageUrl
                        "assets/images/pin_logo.png",
                        height: 30,
                        width: 30,
                        fit: BoxFit.cover,
                        // width: 25.h,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomFormFields(
                  ontap: () {},
                  enabled: true,
                  controller: dashboardController.issuename,
                  labelColor: KdarkText,
                  obscureText: false,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  fontSize: kFourteenFont,
                  fontWeight: FontWeight.w500,
                  hintText: "Enter Name",
                  maxLines: 1,
                  readOnly: false,
                  label: "Name",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomFormFields(
                  ontap: () {},
                  enabled: true,
                  controller: dashboardController.issuemobile,
                  keyboardType: TextInputType.phone,
                  labelColor: KdarkText,
                  obscureText: false,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  fontSize: kFourteenFont,
                  fontWeight: FontWeight.w500,
                  hintText: "Enter Phonenumber",
                  maxLines: 1,
                  readOnly: false,
                  label: "Phone",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomFormFields(
                  ontap: () {},
                  enabled: true,
                  controller: dashboardController.issuesubject,
                  labelColor: KdarkText,
                  obscureText: false,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  fontSize: kFourteenFont,
                  fontWeight: FontWeight.w500,
                  hintText: "Enter Subject",
                  maxLines: 1,
                  readOnly: false,
                  label: "Subject",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter subject';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomFormFields(
                  ontap: () {},
                  enabled: true,
                  controller: dashboardController.issuecontent,
                  labelColor: KdarkText,
                  obscureText: false,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  fontSize: kFourteenFont,
                  fontWeight: FontWeight.w500,
                  hintText: "Enter Content",
                  maxLines: 8,
                  readOnly: false,
                  label: "Content",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter content';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomFormFields(
                  ontap: () {},
                  enabled: true,
                  controller: dashboardController.issuevillage,
                  labelColor: KdarkText,
                  obscureText: false,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  fontSize: kFourteenFont,
                  fontWeight: FontWeight.w500,
                  hintText: "Enter Village",
                  maxLines: 1,
                  readOnly: false,
                  label: "Village",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter village';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomFormFields(
                  ontap: () {},
                  enabled: true,
                  controller: dashboardController.issuemandal,
                  labelColor: KdarkText,
                  obscureText: false,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  fontSize: kFourteenFont,
                  fontWeight: FontWeight.w500,
                  hintText: "Enter Mandal",
                  maxLines: 1,
                  readOnly: false,
                  label: "Mandal",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Mandal';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomFormFields(
                  ontap: () {},
                  enabled: true,
                  controller: dashboardController.issueconstitution,
                  labelColor: KdarkText,
                  obscureText: false,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  fontSize: kFourteenFont,
                  fontWeight: FontWeight.w500,
                  hintText: "Enter constitution",
                  maxLines: 1,
                  readOnly: false,
                  label: "Constitution",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter constitution';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomFormFields(
                  ontap: () {},
                  enabled: true,
                  controller: dashboardController.issuecity,
                  labelColor: KdarkText,
                  obscureText: false,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  fontSize: kFourteenFont,
                  fontWeight: FontWeight.w500,
                  hintText: "Enter City",
                  maxLines: 1,
                  readOnly: false,
                  label: "City",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter City';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomFormFields(
                  ontap: () {},
                  enabled: true,
                  controller: dashboardController.issuestate,
                  labelColor: KdarkText,
                  obscureText: false,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  fontSize: kFourteenFont,
                  fontWeight: FontWeight.w500,
                  hintText: "Enter State",
                  maxLines: 1,
                  readOnly: false,
                  label: "State",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter state';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomFormFields(
                  ontap: () {},
                  enabled: true,
                  keyboardType: TextInputType.number,
                  controller: dashboardController.issuepincode,
                  labelColor: KdarkText,
                  obscureText: false,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  fontSize: kFourteenFont,
                  fontWeight: FontWeight.w500,
                  hintText: "Enter Pincode",
                  maxLines: 1,
                  readOnly: false,
                  label: "Pincode",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter pincode';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "File Type",
                      style: GoogleFonts.robotoCondensed(
                          color: KdarkText,
                          fontSize: kSixteenFont,
                          fontWeight: kFW400),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Kwhite,
                      boxShadow: [
                        BoxShadow(
                          color: kblack.withOpacity(0.2),
                          blurRadius: 2.r,
                          offset: Offset(1, 1),
                          spreadRadius: 1.r,
                        )
                      ]),
                  child: DropdownButtonFormField2<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: kblack.withOpacity(0.6), width: 0.5),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: kblack.withOpacity(0.6), width: 0.5),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: kblack.withOpacity(0.6), width: 0.5),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: KPartyThemetwo, width: 1),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: KPartyThemetwo, width: 1),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    hint: Text(
                      'Select Type',
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 14,
                        color: KTextgery.withOpacity(0.5),
                      ),
                    ),
                    items: fileType
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: GoogleFonts.robotoCondensed(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select type';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        selectedUserValue = value.toString();

                        dashboardController.sfileTpye.value = value.toString();
                        if (selectedUserValue == "video") {
                          dashboardController.updateSelectedImage(null);
                        } else {
                          dashboardController.updateSelectedVideo(null);
                        }
                        // if (selectedVideos.value != null) {

                        // }
                        print("object");
                        setState(() {});
                      });
                    },
                    onSaved: (value) {
                      selectedUserValue = value.toString();
                      print(selectedUserValue);
                      setState(() {});
                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.only(right: 8),
                    ),
                    iconStyleData: IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: KPartyThemetwo,
                      ),
                      iconSize: 24,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                dashboardController.sfileTpye.value == "image"
                    ? Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Divider(
                            color: Kwhite.withOpacity(0.5),
                          ),
                          selectedImage != null
                              ? Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      // padding: EdgeInsets.all(12),
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Klight_grey_twg, width: 1),
                                        color: Kwhite,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5)),
                                      ),
                                      child: Image.file(
                                        selectedImage!,
                                        //   width: dou.w,
                                        height: 140.h,
                                        //   fit: BoxFit.cover,
                                        fit: BoxFit.cover,
                                        // height: 100.h,
                                        // width: 100.w,
                                        // fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                )
                              : Text(
                                  "No image selected",
                                  style: TextStyle(color: Kwhite),
                                ),
                          SizedBox(
                            height: 20.h,
                          ),
                          selectedImage == null
                              ? CustomButton(
                                  // margin: EdgeInsets.only(top: 36.h),
                                  borderRadius: BorderRadius.circular(5.r),
                                  Color: KPartyThemetwo,
                                  textColor: Kwhite,
                                  height: 45,
                                  width: double.infinity,
                                  label: "Browse image",
                                  fontSize: kSixteenFont,
                                  fontWeight: kFW600,
                                  isLoading: false,
                                  onTap: () {
                                    showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              topLeft: Radius.circular(20)),
                                        ),
                                        backgroundColor: Kbackground,
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Kbackground,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          topRight:
                                                              Radius.circular(
                                                                  20))),
                                              height: 100.h,
                                              padding:
                                                  EdgeInsets.only(top: 20.h),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      chooseImage("Gallery");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Icon(
                                                          Icons.image_outlined,
                                                          color: KPartyThemeOne,
                                                        ),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        Text('Gallery',
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .robotoCondensed(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        kFW700,
                                                                    color:
                                                                        KdarkText)),
                                                      ],
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      chooseImage("camera");
                                                      Navigator.pop(context);
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          color: KPartyThemeOne,
                                                        ),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        Text('camera',
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .robotoCondensed(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        kFW700,
                                                                    color:
                                                                        KdarkText)),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  })
                              : Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // selectedImage == null
                                    //     ? SizedBox()
                                    //     :
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedImage = null;
                                        });
                                        dashboardController
                                            .updateSelectedImage(null);
                                        //  updateSelectedImage
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 45,
                                        width: 110,
                                        margin: EdgeInsets.only(right: 10),
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Klight_grey_twg, width: 1),
                                          color: Kwhite,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5),
                                              bottomLeft: Radius.circular(5),
                                              bottomRight: Radius.circular(5)),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/delete.png",
                                              height: 24,
                                              width: 24,
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              "Delete",
                                              style:
                                                  GoogleFonts.robotoCondensed(
                                                      color: Klight_grey_twg,
                                                      fontSize: kSixteenFont,
                                                      fontWeight: kFW600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    CustomButton(
                                        // margin: EdgeInsets.only(top: 36.h),
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        Color: KPartyThemetwo,
                                        textColor: Kwhite,
                                        height: 45,
                                        width: 155.w,
                                        label: "Browse image",
                                        fontSize: kSixteenFont,
                                        fontWeight: kFW600,
                                        isLoading: false,
                                        onTap: () {
                                          showModalBottomSheet(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(20),
                                                    topLeft:
                                                        Radius.circular(20)),
                                              ),
                                              backgroundColor: Kbackground,
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Kbackground,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20))),
                                                    height: 100.h,
                                                    padding: EdgeInsets.only(
                                                        top: 20.h),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            chooseImage(
                                                                "Gallery");
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Column(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .image_outlined,
                                                                color:
                                                                    Kblue_twg,
                                                              ),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Text('Gallery',
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: GoogleFonts.robotoCondensed(
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          kFW700,
                                                                      color:
                                                                          KdarkText)),
                                                            ],
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            chooseImage(
                                                                "camera");
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Column(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .camera_alt_outlined,
                                                                color:
                                                                    Kblue_twg,
                                                              ),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Text('camera',
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: GoogleFonts.robotoCondensed(
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          kFW700,
                                                                      color:
                                                                          KdarkText)),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        }),
                                  ],
                                ),
                          SizedBox(
                            height: 35.h,
                          ),
                        ],
                      )

                    ///video
                    : Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          // _listVideoPaths.isEmpty
                          //     ? SizedBox()
                          //     : Container(
                          //         // padding: EdgeInsets.all(12),
                          //         margin: EdgeInsets.only(bottom: 10),
                          //         width: double.infinity,
                          //         decoration: BoxDecoration(
                          //           border: Border.all(color: Klight_grey_twg, width: 1),
                          //           color: Kwhite,
                          //           borderRadius: BorderRadius.only(
                          //               topLeft: Radius.circular(5),
                          //               topRight: Radius.circular(5),
                          //               bottomLeft: Radius.circular(5),
                          //               bottomRight: Radius.circular(5)),
                          //         ),
                          //         child: Image.file(
                          //           File(
                          //             _listVideoPaths[0].thumbPath!,
                          //           ),
                          //           fit: BoxFit.cover,
                          //           height: 140.h,
                          //         ),
                          //       ),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     _listVideoPaths.isEmpty
                          //         ? SizedBox()
                          //         : InkWell(
                          //             onTap: () {
                          //               setState(() {
                          //                 _listVideoPaths.clear();
                          //                 dashboardController.selectedVideo.value = null;
                          //               });
                          //               setState(() {});
                          //             },
                          //             child: Container(
                          //               height: 45,
                          //               width: 110,
                          //               margin: EdgeInsets.only(right: 10),
                          //               padding: EdgeInsets.all(8),
                          //               decoration: BoxDecoration(
                          //                 border:
                          //                     Border.all(color: Klight_grey_twg, width: 1),
                          //                 color: Kwhite,
                          //                 borderRadius: BorderRadius.only(
                          //                     topLeft: Radius.circular(5),
                          //                     topRight: Radius.circular(5),
                          //                     bottomLeft: Radius.circular(5),
                          //                     bottomRight: Radius.circular(5)),
                          //               ),
                          //               child: Row(
                          //                 children: [
                          //                   Image.asset(
                          //                     "assets/images/delete.png",
                          //                     height: 24,
                          //                     width: 24,
                          //                   ),
                          //                   SizedBox(
                          //                     width: 5.w,
                          //                   ),
                          //                   Text(
                          //                     "Delete",
                          //                     style: GoogleFonts.robotoCondensed(
                          //                         color: Klight_grey_twg,
                          //                         fontSize: kSixteenFont,
                          //                         fontWeight: kFW600),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ),
                          //     // SizedBox(height: 20),
                          //     // ElevatedButton(
                          //     //   onPressed: pickVideo,
                          //     //   child: Text("Pick Video"),
                          //     // ),
                          //     // CustomButton(
                          //     //   // margin: EdgeInsets.only(top: 36.h),
                          //     //   borderRadius: BorderRadius.circular(5.r),
                          //     //   Color: Kform_border_twg,
                          //     //   textColor: Kwhite,
                          //     //   height: 45,
                          //     //   width: 155.w,
                          //     //   label: "+ Browser.....",
                          //     //   fontSize: kSixteenFont,
                          //     //   fontWeight: kFW600,
                          //     //   isLoading: false,
                          //     //   onTap: () async {
                          //     //     try {
                          //     //       // Use the ImagePickers library to select a video
                          //     //       _listVideoPaths = await ImagePickers.pickerPaths(
                          //     //         galleryMode: GalleryMode.video,
                          //     //         selectCount: 1,
                          //     //         showCamera: false,
                          //     //       );

                          //     //       // Update the UI
                          //     //       setState(() {});

                          //     //       if (_listVideoPaths.isNotEmpty) {
                          //     //         final String? videoPath = _listVideoPaths[0].path;

                          //     //         if (videoPath != null) {
                          //     //           // Pass the selected video file to the controller
                          //     //           dashboardController.setSelectedVideo(File(videoPath));
                          //     //           print("Selected video path: $videoPath");
                          //     //         } else {
                          //     //           print("Video path is null");
                          //     //         }
                          //     //       } else {
                          //     //         print("No videos selected");
                          //     //       }
                          //     //     } catch (e) {
                          //     //       print("Error picking video: $e");
                          //     //     }
                          //     //   },
                          //     // ),
                          //   ],
                          // ),

                          SizedBox(
                            height: 20.h,
                          ),
                          ////////////////////////
                          selectedVideo != null && _videoController != null
                              ? _videoController!.value.isInitialized
                                  ? Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              height: 120.h,
                                              // padding: EdgeInsets.all(12),
                                              margin:
                                                  EdgeInsets.only(bottom: 10),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Klight_grey_twg,
                                                    width: 1),
                                                color: Kwhite,
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5),
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5)),
                                              ),
                                              child: AspectRatio(
                                                aspectRatio: _videoController!
                                                            .value.aspectRatio >
                                                        1.0
                                                    ? _videoController!.value
                                                        .aspectRatio // Keep landscape
                                                    : 16 /
                                                        9, // Default to landscape if portrait video
                                                child: ClipRect(
                                                  child: FittedBox(
                                                    fit: BoxFit
                                                        .cover, // Ensures the video fits the container
                                                    child: SizedBox(
                                                      width: _videoController!
                                                          .value.size.width,
                                                      height: _videoController!
                                                          .value.size.height,
                                                      child: VideoPlayer(
                                                          _videoController!),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // AspectRatio(
                                              //   aspectRatio:
                                              //       _videoController!.value.aspectRatio,

                                              //   child: VideoPlayer(_videoController!),
                                              // ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              top: 0,
                                              left: 0,
                                              right: 0,
                                              child: SizedBox(
                                                height: 20.h,
                                                width: 20.w,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 20.r,
                                                      backgroundColor:
                                                          Kwhite.withOpacity(
                                                              0.5),
                                                      child: IconButton(
                                                        icon: Icon(
                                                          _videoController!
                                                                  .value
                                                                  .isPlaying
                                                              ? Icons.pause
                                                              : Icons
                                                                  .play_arrow,
                                                          color: kblack,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            if (_videoController!
                                                                .value
                                                                .isPlaying) {
                                                              _videoController!
                                                                  .pause();
                                                            } else {
                                                              _videoController!
                                                                  .play();
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.center,
                                        //   children: [
                                        //     IconButton(
                                        //       icon: Icon(
                                        //         _videoController!.value.isPlaying
                                        //             ? Icons.pause
                                        //             : Icons.play_arrow,
                                        //       ),
                                        //       onPressed: () {
                                        //         setState(() {
                                        //           if (_videoController!.value.isPlaying) {
                                        //             _videoController!.pause();
                                        //           } else {
                                        //             _videoController!.play();
                                        //           }
                                        //         });
                                        //       },
                                        //     ),
                                        //     // IconButton(
                                        //     //   icon: Icon(Icons.stop),
                                        //     //   onPressed: () {
                                        //     //     _videoController!.pause();
                                        //     //     _videoController!.seekTo(Duration.zero);
                                        //     //   },
                                        //     // ),
                                        //   ],
                                        // ),
                                      ],
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(
                                        color: Kwhite,
                                      ),
                                    )
                              : Text("No video selected",
                                  style: TextStyle(color: Kwhite)),
                          SizedBox(height: 20),
                          // ElevatedButton(
                          //   onPressed: pickVideo,
                          //   child: Text("Pick Video"),
                          // ),
                          selectedVideo == null && _videoController == null
                              ? CustomButton(
                                  // margin: EdgeInsets.only(top: 36.h),
                                  borderRadius: BorderRadius.circular(5.r),
                                  Color: KPartyThemetwo,
                                  textColor: Kwhite,
                                  height: 45,
                                  width: double.infinity,
                                  label: "Browse Video",
                                  fontSize: kSixteenFont,
                                  fontWeight: kFW600,
                                  isLoading: false,
                                  onTap: () {
                                    pickVideo();
                                  })
                              : Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // selectedImage == null
                                    // selectedVideo == null && _videoController == null
                                    //     ? SizedBox()
                                    //     :
                                    InkWell(
                                      onTap: () {
                                        if (_videoController!.value.isPlaying) {
                                          _videoController!.pause();
                                        }
                                        setState(() {
                                          selectedVideo = null;
                                          _videoController = null;
                                          // _videoController?.dispose();
                                          // selectedImage = null;
                                        });
                                        dashboardController
                                            .updateSelectedVideo(null);
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 45,
                                        width: 110,
                                        margin: EdgeInsets.only(right: 10),
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Klight_grey_twg, width: 1),
                                          color: Kwhite,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5),
                                              bottomLeft: Radius.circular(5),
                                              bottomRight: Radius.circular(5)),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/delete.png",
                                              height: 24,
                                              width: 24,
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              "Delete",
                                              style:
                                                  GoogleFonts.robotoCondensed(
                                                      color: Klight_grey_twg,
                                                      fontSize: kSixteenFont,
                                                      fontWeight: kFW600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    CustomButton(
                                        // margin: EdgeInsets.only(top: 36.h),
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        Color: KPartyThemetwo,
                                        textColor: Kwhite,
                                        height: 45,
                                        width: 155.w,
                                        label: "Browse Video",
                                        fontSize: kSixteenFont,
                                        fontWeight: kFW600,
                                        isLoading: false,
                                        onTap: () {
                                          pickVideo();
                                        }),
                                  ],
                                ),

                          //////////////////////////////////
                          // _videoPlayerController != null &&
                          //         _videoPlayerController!.value.isInitialized
                          //     ? AspectRatio(
                          //         aspectRatio: _videoPlayerController!.value.aspectRatio,
                          //         child: VideoPlayer(_videoPlayerController!),
                          //       )
                          //     : SizedBox(),

                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     CustomButton(
                          //       borderRadius: BorderRadius.circular(5),
                          //       Color: Colors.blue,
                          //       textColor: Colors.white,
                          //       height: 45,
                          //       width: 155,
                          //       label: "+ Browser Video",
                          //       fontSize: 16,
                          //       fontWeight: FontWeight.w600,
                          //       isLoading: false,
                          //       onTap: () => selectVideo(),
                          //     ),
                          //   ],
                          // ),

                          SizedBox(
                            height: 35.h,
                          ),
                        ],
                      ),
                Divider(),
                Obx(() => dashboardController.postIssueLoading == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: KPartyThemetwo,
                        ),
                      )
                    : CustomButton(
                        margin: EdgeInsets.only(top: 12.h),
                        borderRadius: BorderRadius.circular(5.r),
                        Color: KPartyThemetwo,
                        textColor: Kwhite,
                        height: 45,
                        width: double.infinity,
                        label: "Submit",
                        fontSize: kSixteenFont,
                        fontWeight: kFW600,
                        isLoading: false,
                        onTap: () {
                          ///
                          //                         '': '4',
                          // '': 'test',
                          // '': '9908262399',
                          // '': 'test',
                          // '': 'test',
                          // '': 'test',
                          // '': 'test',
                          // '': 'test',
                          // '': 'test',
                          // '': '500033',
                          // '': 'test',
                          // 'issue_type': 'health'
                          /////
                          var payload = {
                            "volunter_id":
                                dashboardController.profileData["user_id"] ??
                                    "",
                            //
                            "name": dashboardController.issuename.text,
                            "mobile_number":
                                dashboardController.issuemobile.text,
                            "subject": dashboardController.issuesubject.text,
                            "content": dashboardController.issuecontent.text,
                            "village": dashboardController.issuevillage.text,
                            "mandal": dashboardController.issuemandal.text,
                            "constitution":
                                dashboardController.issueconstitution.text,
                            "city": dashboardController.issuecity.text,
                            "pincode": dashboardController.issuepincode.text,
                            "state": dashboardController.issuestate.text,
                            'issue_type': serviceData["type"] ?? ""
                            // "userId":
                            //     dashboardController.profileData["user_id"] ??
                            //         "",
                            // "adminId": dashboardController
                            //             .profileData["political_admin_details"]
                            //         [0]["admin_id"] ??
                            //     ""
                            // dashboardController.profileData["user_id"] ?? ""
                          };

                          //  if (selectedImage != null) {
                          dashboardController.postIssues(payload);
                          setState(() {
                            // dashboardController.imageTitleController.text = "";
                            // dashboardController.videoTitleController.text = "";
                          });
                          setState(() {
                            selectedImage = null;
                          });
                        })),
                SizedBox(
                  height: 60.h,
                ),
                Center(
                  child: Text(
                    "Powered By",
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.robotoCondensed(
                        color: KdarkText, fontSize: 11.sp, fontWeight: kFW600),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.asset(
                      "assets/images/twg_powerd.png",
                      height: 50.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
              ],
            ),
          ),
        ));
  }
}
