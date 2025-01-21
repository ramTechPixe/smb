import 'package:flutter/services.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:intl/intl.dart';
import 'package:political/untils/export_file.dart';
import 'dart:convert';
import 'dart:io';
import 'package:video_player/video_player.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  File? selectedImage;
  DashboardController dashboardController = Get.put(DashboardController());
  final List<String> fileType = ['image', 'video'];
///////////////////////////////
  final List<String> CompanyList = [
    'English',
    'Hindi',
    'Assamese',
    'Bengali',
    'Bodo',
    'Dogri',
    'Gujarati',
    'Kashmiri',
    'Kannada',
    'Konkani',
    'Maithili',
    'Malayalam',
    'Manipuri',
    'Marathi',
    'Nepali',
    'Oriya',
    'Punjabi',
    'Sanskrit',
    'Santali',
    'Sindhi',
    'Tamil',
    'Telugu',
    'Urdu',
    'Tulu',
    'Bhili',
    'Garo',
    'Mizo',
    'Khasi',
    'Lepcha',
    'Ladakhi',
    'Sherpa',
    'Ho',
    'Ao',
    'Bhilodi',
    'Mundari',
  ];
  ////////////////

  ////////////

  String? selectedUserValue;
////////////////////////
  ///
  List<String> selectedCheckBoxValue = [];

  String? dataImagePath = "";

  String? selectedOption;
  bool showimagenullMessage = false;

  File? selectedResume;
  File? selectedLetter;
  File? selectedImagetwo;
  String base64Image = "";
  // bool isLoading = false;
  Map typesData = {};
  List<String> options = [];
  int choosenTypeData = 0;
  String choosenOption = "";
  List<Media> _listVideoPaths = [];
  String description = "";
  int? totalAmount;
  String? str;
  File? selectedVideo;
  VideoPlayerController? _videoController;
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
  ////////////////////////////////

  //////////video player
  // Future<void> selectVideo() async {
  //   try {
  //     _listVideoPaths = await ImagePickers.pickerPaths(
  //       galleryMode: GalleryMode.video,
  //       selectCount: 1,
  //       showCamera: false,
  //     );

  //     if (_listVideoPaths.isNotEmpty) {
  //       final String? videoPath = _listVideoPaths[0].path;
  //       if (videoPath != null) {
  //         setState(() {
  //           _videoPlayerController = VideoPlayerController.file(File(videoPath))
  //             ..initialize().then((_) {
  //               setState(() {}); // Update UI after initialization
  //             })
  //             ..setLooping(true)
  //             ..play(); // Start playing the video automatically
  //         });
  //       }
  //     } else {
  //       print("No videos selected");
  //     }
  //   } catch (e) {
  //     print("Error picking video: $e");
  //   }
  // }

  // @override
  // void dispose() {
  //   _videoPlayerController?.dispose();
  //   super.dispose();
  // }
  ////////
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Are you sure?',
              style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            content: Text(
              'Do you want to exit this App',
              style: GoogleFonts.roboto(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text(
                  'Yes',
                  style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: KPartyThemeOne),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  Map userDetails = {};
  @override
  void initState() {
    setState(() {
      userDetails = UserSimplePreferences.getUserDetails()!;
      dashboardController.imageTitleController.text = "";
      dashboardController.videoTitleController.text = "";
      dashboardController.profileData.value = userDetails;
      print("object");
    });
    // TODO: implement initState
    super.initState();
  }

  /////
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: KPartyThemeOne,
        endDrawer: Drawer(
          elevation: 16.0,
          child: leftDrawerMenu(context),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/dummy_logo.png",
                            height: 40.h,
                            width: 40.w,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            "Bharatiya Janata Party",
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.robotoCondensed(
                                color: Kwhite,
                                fontSize: 8.sp,
                                fontWeight: kFW600),
                          ),
                        ]),
                    InkWell(
                      onTap: () {
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(300),
                        child: Image.asset(
                          "assets/images/menu_image.png",
                          width: 30,
                          height: 30,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 35.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Choose language",
                      style: GoogleFonts.robotoCondensed(
                          color: Kwhite,
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
                      'Select language',
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 14,
                        color: KTextgery.withOpacity(0.5),
                      ),
                    ),
                    items: CompanyList.map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: GoogleFonts.robotoCondensed(
                              fontSize: 14,
                            ),
                          ),
                        )).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select language';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        selectedUserValue = value.toString();

                        dashboardController.choosenFromCategory.value =
                            value.toString();

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
                SizedBox(
                  height: 35.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "File Type",
                      style: GoogleFonts.robotoCondensed(
                          color: Kwhite,
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
                          CustomFormFields(
                            ontap: () {},
                            enabled: true,
                            controller:
                                dashboardController.imageTitleController,
                            labelColor: Kwhite,
                            obscureText: false,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 8),
                            fontSize: kFourteenFont,
                            fontWeight: FontWeight.w500,
                            hintText: "Enter Image title",
                            maxLines: 1,
                            readOnly: false,
                            label: "Image title",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter image title';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20.h,
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

                          Divider(
                            color: Kwhite.withOpacity(0.5),
                          ),
                          CustomFormFields(
                            ontap: () {},
                            enabled: true,
                            controller:
                                dashboardController.videoTitleController,
                            labelColor: Kwhite,
                            obscureText: false,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 8),
                            fontSize: kFourteenFont,
                            fontWeight: FontWeight.w500,
                            hintText: "Enter Video title",
                            maxLines: 1,
                            readOnly: false,
                            label: "Video title",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter image title';
                              }
                              return null;
                            },
                          ),
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
                Divider(
                  color: Kwhite.withOpacity(0.5),
                ),
                Obx(() => dashboardController.addFormLoading == true
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
                          DateTime now = DateTime.now();
                          String formattedDate =
                              DateFormat("dd-MM-yyyy").format(now);
                          String formattedTime =
                              DateFormat("hh:mm a").format(now);
                          setState(() {
                            dashboardController.today.value =
                                formattedDate + " " + formattedTime;
                            print(dashboardController.today);
                          });
                          var payload = {
                            "language":
                                dashboardController.choosenFromCategory.value,
                            //
                            "imageTitle":
                                dashboardController.imageTitleController.text,
                            "videoTitle":
                                dashboardController.videoTitleController.text,
                            "createdTime": dashboardController.today.value,
                            "userId":
                                dashboardController.profileData["user_id"] ??
                                    "",
                            "adminId": dashboardController
                                        .profileData["political_admin_details"]
                                    [0]["admin_id"] ??
                                ""
                            // dashboardController.profileData["user_id"] ?? ""
                          };

                          //  if (selectedImage != null) {
                          dashboardController.addFormCommment(payload);
                          setState(() {
                            dashboardController.imageTitleController.text = "";
                            dashboardController.videoTitleController.text = "";
                          });
                          setState(() {
                            selectedImage = null;
                          });
                          if (_videoController!.value.isPlaying) {
                            _videoController!.pause();
                          }
                          setState(() {
                            selectedVideo = null;
                            _videoController = null;
                            // _videoController?.dispose();
                            // selectedImage = null;
                          });
                          // dashboardController
                          //     .otherCommentsController
                          //     .clear();
                          // } else {
                          //   Fluttertoast.showToast(
                          //     msg: "please upload image",
                          //   );
                          // }
                          // if (_formKey.currentState!.validate()) {
                          //   dashboardcontroller.addForm(payload);
                          // }
                        }
                        // {
                        //   showDialog(
                        //     context: context,
                        //     builder: (context) => AlertDialog(
                        //       title: Text("success"),
                        //       content: Text("Uploaded Successfully"),
                        //       actions: [
                        //         TextButton(
                        //           child: Text("OK"),
                        //           onPressed: () {
                        //             Navigator.of(context).pop();
                        //           },
                        //         ),
                        //       ],
                        //     ),
                        //   );
                        //   Future.delayed(Duration(seconds: 2), () async {
                        //     Navigator.of(context).pop();
                        //   });
                        // }
                        )),
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
                        color: Kwhite, fontSize: 11.sp, fontWeight: kFW600),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Center(
                  child: Image.asset(
                    "assets/images/twg_powerd.png",
                    height: 50.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
//
Widget leftDrawerMenu(
  BuildContext context,
) {
  return Container(
    color: Kwhite,
    padding: const EdgeInsets.all(15.0),
    child: ListView(
      children: [
        Text(
          "Menu",
          style: GoogleFonts.poppins(
              color: kblack, fontSize: 24.sp, fontWeight: kFW600),
        ),
        SizedBox(
          height: 20.h,
        ),
        InkWell(
          onTap: () {
            Get.toNamed(kServicesScreen);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Services",
                style: GoogleFonts.poppins(
                    color: kblack, fontSize: kSixteenFont, fontWeight: kFW500),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: kTwentyFont,
              )
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Divider(),
        SizedBox(
          height: 10.h,
        ),
        InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Are You Sure',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                            fontSize: 12.sp,
                            fontWeight: kFW700,
                            color: KdarkText)),
                    content: Text('You Want To LogOut ?',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                            fontSize: 12.sp,
                            fontWeight: kFW700,
                            color: KdarkText.withOpacity(0.7))),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('No',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                                fontSize: 12.sp,
                                fontWeight: kFW700,
                                color: KdarkText)),
                      ),
                      TextButton(
                        onPressed: () async {
                          ///
                          /// Delete the database at the given path.
                          ///
                          // Future<void> deleteDatabase(String path) =>
                          //     _databaseHelper.database;
                          UserSimplePreferences.clearAllData();
                          Get.toNamed(kSplash);
                        },
                        child: Text('Yes',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                                fontSize: 12.sp,
                                fontWeight: kFW700,
                                color: KdarkText)),
                      )
                    ],
                  );
                });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Logout",
                style: GoogleFonts.poppins(
                    color: KRed_twg,
                    fontSize: kSixteenFont,
                    fontWeight: kFW500),
              ),
              Icon(
                Icons.logout,
                size: kTwentyFont,
                color: KRed,
              )
            ],
          ),
          // Row(
          //   children: [
          //     Text(
          //       "Logout",
          //       style: GoogleFonts.robotoCondensed(
          //           color: KdarkText, fontSize: 15.sp, fontWeight: kFW500),
          //     ),
          //     SizedBox(
          //       width: 5.w,
          //     ),
          //     Icon(
          //       Icons.logout,
          //       color: Kwhite,
          //       size: 18.sp,
          //     )
          //   ],
          // ),
        ),
      ],
    ),
  );
}
