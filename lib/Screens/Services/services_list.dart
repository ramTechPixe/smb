import 'package:political/untils/export_file.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
//   1.  - Infrastructure Problems
// 2.  - Employment and livelihood
// 3.  - Education
// 4.  - Health care
// 5.  - Environment
// 6.  - Law
// 7.  - Youth
// 8.  - Women empowerment
// 9.  - Other services

  List toolsList = [
    {
      "tile": "बनयादी ढांच की समस्याए",
      "image": "assets/images/1.png",
      "type": "infrastructureProblems",
    },
    {
      "tile": "रोजगार एवं आजी वका",
      "image": "assets/images/2.png",
      "type": "employementAndLivelihood",
    },
    {
      "tile": "शक्षा",
      "image": "assets/images/3.png",
      "type": "education",
    },
    {
      "tile": "स्वास्थ्य दखभाल",
      "image": "assets/images/4.png",
      "type": "healthCare",
    },
    {
      "tile": "पयावरण",
      "image": "assets/images/5.png",
      "type": "environment",
    },
    {
      "tile": "कानन",
      "image": "assets/images/6.png",
      "type": "law",
    },
    {
      "tile": "यवा",
      "image": "assets/images/7.png",
      "type": "youth",
    },
    {
      "tile": "म हला सशि तकरण",
      "image": "assets/images/8.png",
      "type": "womenEmpowerment",
    },
    {
      "tile": "अन्य सवाए",
      "image": "assets/images/9.png",
      "type": "otherServices",
    },
    //
  ];

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
              "Services",
              style: GoogleFonts.poppins(
                  color: Kwhite, fontSize: kTwentyFont, fontWeight: kFW600),
            )),
        body: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.all(14.r),
                child: Wrap(
                  spacing: MediaQuery.of(context).size.width / 15,
                  runSpacing: 5.h,
                  children: [
                    for (int i = 0; i < toolsList.length; i++)
                      InkWell(
                        onTap: () {
                          Get.toNamed(kPostIssuesScreen,
                              arguments: toolsList[i]);
                          // DateTime now = DateTime.now();
                          // String formattedDate = DateFormat("yyyy-MM-dd").format(now);

                          // setState(() {
                          //   menuscontroller.today.value = formattedDate;
                          //   menuscontroller.userSelectedToolIDD.value =
                          //       menuscontroller.toolsList[i]["id"];
                          // });
                          // var payload = {
                          //   "tool_id": menuscontroller.toolsList[i]["id"],
                          //   //:,
                          //   "user_id": userprofilecontroller
                          //       .profileData["user_details"]["id"]
                          //   //
                          // };

                          // // if (_formKey.currentState!.validate()) {
                          // //   authcontroller.userSignIn(payload);
                          // // }

                          // menuscontroller.toolRazorpay(
                          //     payload, menuscontroller.toolsList[i]["tool_name"]);

                          // // vvip code
                          // // if (menuscontroller.toolsList[i]["tool_name"] ==
                          // //     "digital influencer") {
                          // //   Get.toNamed(kDigitalInfluencerScreen);
                          // // } else if (menuscontroller.toolsList[i]["tool_name"] ==
                          // //     "logo") {
                          // //   Get.toNamed(kLogoScreen);
                          // // } else if (menuscontroller.toolsList[i]["tool_name"] ==
                          // //     "logo") {
                          // //   Get.toNamed(kLogoScreen);
                          // // } else if (menuscontroller.toolsList[i]["tool_name"] ==
                          // //     "Music") {
                          // //   Get.toNamed(kMusicScreen);
                          // // } else if (menuscontroller.toolsList[i]["tool_name"] ==
                          // //     "AI Blog Writer") {
                          // //   Get.toNamed(kAiBLogScreen);
                          // // } else if (menuscontroller.toolsList[i]["tool_name"] ==
                          // //     "AI Blog Writer") {
                          // //   Get.toNamed(kAiBLogScreen);
                          // // } else if (menuscontroller.toolsList[i]["tool_name"] ==
                          // //     "Hashtags") {
                          // //   Get.toNamed(kHashtagScreen);
                          // // } else if (menuscontroller.toolsList[i]["tool_name"] ==
                          // //     "Automation CRM Tools") {
                          // //   Get.toNamed(kAutomationCRMScreen);
                          // // } else if (menuscontroller.toolsList[i]["tool_name"] ==
                          // //     "Digital Influencer Pose") {
                          // //   Get.toNamed(kInfluencerPosecreen);
                          // // }
                          // //vvip code
                          // // kHashtagScreen
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Image.asset(
                                toolsList[i]["image"],

                                // kBaseImageUrl
                                //  "assets/images/multipost_image.png",
                                // height: 60,
                                // width: 60,
                                fit: BoxFit.cover,
                                // width: 25.h,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              SizedBox(
                                width: 180.w,
                                child: Text(
                                  toolsList[i]["tile"],
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                      color: kblack,
                                      fontSize: kFourteenFont,
                                      fontWeight: kFW400),
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Text(
                                "",
                                // toolsList[i]["count"],
                                style: GoogleFonts.poppins(
                                    color: Kblue_twg,
                                    fontSize: kFourteenFont,
                                    fontWeight: kFW400),
                              ),
                            ],
                          ),
                        ),

                        // child: Container(
                        //   width: 160.w,
                        //   padding: EdgeInsets.all(8),
                        //   decoration: BoxDecoration(
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: kblack.withOpacity(0.1),
                        //         blurRadius: 2.r,
                        //         offset: Offset(0, 1),
                        //         spreadRadius: 2.r,
                        //       )
                        //     ],
                        //     color: Kwhite,
                        //     borderRadius: BorderRadius.circular(8.r),
                        //   ),
                        //   child:
                        //   Column(
                        //     children: [
                        //       SizedBox(
                        //         height: 10.h,
                        //       ),
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Container(
                        //             // padding: EdgeInsets.all(8),
                        //             alignment: Alignment.center,
                        //             decoration: BoxDecoration(
                        //               boxShadow: [
                        //                 BoxShadow(
                        //                   color: kblack.withOpacity(0.3),
                        //                   blurRadius: 0.5.r,
                        //                   offset: Offset(1, 1),
                        //                   spreadRadius: 0.5.r,
                        //                 )
                        //               ],
                        //               // color: Kwhite,
                        //               borderRadius: BorderRadius.circular(5.r),
                        //             ),
                        //             child: Image.asset(
                        //               // kBaseImageUrl
                        //               "assets/images/multipost_image.png",
                        //               height: 60,
                        //               width: 60,
                        //               fit: BoxFit.cover,
                        //               // width: 25.h,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       SizedBox(
                        //         height: 10.h,
                        //       ),
                        //       SizedBox(
                        //         width: 180.w,
                        //         child: Text(
                        //           toolsList[i]["tile"],
                        //           maxLines: 1,
                        //           textAlign: TextAlign.center,
                        //           overflow: TextOverflow.ellipsis,
                        //           style: GoogleFonts.poppins(
                        //               color: kblack,
                        //               fontSize: kFourteenFont,
                        //               fontWeight: kFW400),
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         height: 3.h,
                        //       ),
                        //       Text(
                        //         toolsList[i]["count"],
                        //         style: GoogleFonts.poppins(
                        //             color: Kblue_twg,
                        //             fontSize: kFourteenFont,
                        //             fontWeight: kFW400),
                        //       ),
                        //       SizedBox(
                        //         height: 15.h,
                        //       ),
                        //       Container(
                        //         height: 36.h,
                        //         width: 140.w,
                        //         alignment: Alignment.center,
                        //         decoration: BoxDecoration(
                        //           color: Kblue_twg,
                        //           borderRadius: BorderRadius.circular(5.r),
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceAround,
                        //           children: [
                        //             Text(
                        //               toolsList[i]["buttonName"],
                        //               style: GoogleFonts.poppins(
                        //                   color: Kwhite,
                        //                   fontSize: 11.sp,
                        //                   fontWeight: kFW400),
                        //             ),
                        //             Text(
                        //               toolsList[i]["price"],
                        //               style: GoogleFonts.poppins(
                        //                   color: Kwhite,
                        //                   fontSize: 11.sp,
                        //                   fontWeight: kFW400),
                        //             ),
                        //           ],
                        //         ),
                        //       )
                        //     ],
                        //   ),

                        // ),
                      )
                  ],
                ))));
  }
}
