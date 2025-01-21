import 'package:flutter/services.dart';
import 'package:political/untils/export_file.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController authcontroller = Get.put(AuthController());
  DashboardController dashboardController = Get.put(DashboardController());
  /////////////////////////////////////////////
  final _formKey = GlobalKey<FormState>();
  String? selectedOption;
  bool passwordVisible = true;
  bool confirmpasswordVisible = true;

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

  bool? isUserLoggedIn;
  @override
  void initState() {
    //new
    isUserLoggedIn = UserSimplePreferences.getLoginStatus();
    Future.delayed(Duration(milliseconds: 0), () async {
      if (isUserLoggedIn != null && isUserLoggedIn == true) {
        Get.toNamed(kDashboardScreen);
      }
    });

    ///
    setState(() {
      authcontroller.UserEmailSignInController.text = "saitejaaa@gmail.com";
      authcontroller.UserEmailPasswordController.text = "Bstore@123";
    });

    super.initState();
  }
///////////new

//////
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: KPartyThemeOne,
        body: SingleChildScrollView(
          child: Container(
            // decoration: BoxDecoration(color: KPartyThemeOne),
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: 80.h,
                ),
                Image.asset(
                  "assets/images/dummy_logo.png",
                  height: 180.h,
                  fit: BoxFit.cover,
                ),
                Text(
                  "Bharatiya Janata Party",
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.robotoCondensed(
                      color: Kwhite, fontSize: 23.sp, fontWeight: kFW600),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Form(
                  key: _formKey,
                  // autovalidateMode: AutovalidateMode.always,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormFields(
                          ontap: () {},
                          enabled: true,
                          controller: authcontroller.UserEmailSignInController,
                          labelColor: Kwhite,
                          obscureText: false,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
                          fontSize: kFourteenFont,
                          fontWeight: FontWeight.w500,
                          hintText: "Email",
                          maxLines: 1,
                          readOnly: false,
                          label: "Email",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          "Password",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.robotoCondensed(
                              fontSize: kSixteenFont,
                              //  letterSpacing: 1,
                              color: Kwhite,
                              fontWeight: kFW400),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Kwhite,
                          ),
                          child: TextFormField(
                            cursorColor: Kform_border_twg,
                            obscureText: passwordVisible,
                            controller:
                                authcontroller.UserEmailPasswordController,
                            obscuringCharacter: '*',
                            enabled: true,
                            readOnly: false,
                            style: GoogleFonts.robotoCondensed(
                                fontSize: 14.sp,
                                fontWeight: kFW500,
                                color: kblack),
                            decoration: InputDecoration(
                              focusColor: Kwhite,
                              filled: true,
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 8),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: KText_border_twg, width: 0.5),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: KRed_twg, width: 0.5),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: KText_border_twg, width: 0.5),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: KPartyThemeOne, width: 1),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: KPartyThemeOne, width: 1),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              fillColor: Kwhite,

                              hintText: "Enter Password",
                              alignLabelWithHint: true,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 20.sp,
                                ),
                                onPressed: () {
                                  setState(
                                    () {
                                      passwordVisible = !passwordVisible;
                                    },
                                  );
                                },
                              ),

                              hintStyle: GoogleFonts.robotoCondensed(
                                color: KLighText_twg,
                                fontSize: 14.sp,
                                fontWeight: kFW400,
                              ),
                              //////////////////

                              ////////////

                              //create lable
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Password';
                              }
                              return null;
                            },
                            onChanged: (value) {},
                          ),
                        ),

                        // CustomButton(
                        //     margin: EdgeInsets.only(top: 36.h),
                        //     borderRadius: BorderRadius.circular(8.r),
                        //     Color: Kform_border_twg,
                        //     textColor: Kwhite,
                        //     height: 40,
                        //     width: double.infinity,
                        //     label: "Sign In",
                        //     fontSize: kSixteenFont,
                        //     fontWeight: kFW700,
                        //     isLoading: false,
                        //     onTap: () {
                        //       Get.toNamed(kHome);
                        //       // var payload = {
                        //       //   // "user_email": authcontroller
                        //       //   //     .UserEmailSignInController.text,
                        //       //   // "user_password": authcontroller
                        //       //   //     .UserEmailPasswordController.text
                        //       // };

                        //       // if (_formKey.currentState!.validate()) {}
                        //     }),
                        //////////////
                        Obx(
                          () => authcontroller.userSignInLoading == true
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: KPartyThemetwo,
                                  ),
                                )
                              : CustomButton(
                                  margin: EdgeInsets.only(top: 60.h),
                                  borderRadius: BorderRadius.circular(8.r),
                                  // Color: Kwhite,
                                  // textColor: KPartyThemetwo,
                                  Color: KPartyThemetwo,
                                  textColor: Kwhite,
                                  height: 40,
                                  width: double.infinity,
                                  label: "Sign In",
                                  fontSize: kSixteenFont,
                                  fontWeight: kFW700,
                                  isLoading: false,
                                  onTap: () {
                                    var payload = {
                                      "user_email": authcontroller
                                          .UserEmailSignInController.text,
                                      "user_password": authcontroller
                                          .UserEmailPasswordController.text
                                    };

                                    if (_formKey.currentState!.validate()) {
                                      // setState(() {
                                      //   dashboardController.userEmail.value =
                                      //       authcontroller
                                      //           .UserEmailSignInController.text;
                                      // });
                                      authcontroller.userSignIn(payload);
                                      // authcontroller.checkEmployee(payload);
                                    }
                                  }),
                        ),
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
                                color: Kwhite,
                                fontSize: 11.sp,
                                fontWeight: kFW600),
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

                        // SizedBox(height: MediaQuery.of(context).size.height / 2.5)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
