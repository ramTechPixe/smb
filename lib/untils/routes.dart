// import 'package:get/get_navigation/src/routes/get_route.dart';

import 'package:political/untils/export_file.dart';

class Routes {
  static List<GetPage<dynamic>> routes = [
    GetPage(
        name: kSplash,
        transition: Transition.rightToLeft,
        page: () => const SplashScreen()),
    GetPage(
        name: kDashboardScreen,
        transition: Transition.rightToLeft,
        page: () => const Dashboard()),
    GetPage(
        name: kServicesScreen,
        transition: Transition.rightToLeft,
        page: () => const ServicesScreen()),
    GetPage(
        name: kServicesScreen,
        transition: Transition.rightToLeft,
        page: () => const ServicesScreen()),
    GetPage(
        name: kPostIssuesScreen,
        transition: Transition.rightToLeft,
        page: () => PostIssues()),
    // kPostIssuesScreen
    // GetPage(
    //     name: kSignUps,
    //     transition: Transition.rightToLeft,
    //     page: () => const SignUPS()),
    // GetPage(
    //     name: kSignIns,
    //     transition: Transition.rightToLeft,
    //     page: () => const SignIn()),
    // GetPage(
    //     name: kForgotPassword,
    //     transition: Transition.rightToLeft,
    //     page: () => const Forgotpassword()),
    // GetPage(
    //     name: kNavigation,
    //     transition: Transition.rightToLeft,
    //     page: () => const Bottom_navigation()),
    // GetPage(
    //     name: kQuick_posting,
    //     transition: Transition.rightToLeft,
    //     page: () => const QuickPosting()),
    // GetPage(
    //     name: kEdit_Profile,
    //     transition: Transition.rightToLeft,
    //     page: () => const EditProfile()),
    // GetPage(
    //     name: kPublishedScreens,
    //     transition: Transition.rightToLeft,
    //     page: () => const PublishedScreens()),
    // GetPage(
    //     name: kSettingsScreens,
    //     transition: Transition.rightToLeft,
    //     page: () => const SettingsScreen()),
    // GetPage(
    //     name: kScheduledPostScreens,
    //     transition: Transition.rightToLeft,
    //     page: () => const Schedule_post_view()),
    // GetPage(
    //     name: kCreateBannersScreens,
    //     transition: Transition.rightToLeft,
    //     page: () => const CustomizeBanners()),
    // GetPage(
    //     name: kMultiPostScreens,
    //     transition: Transition.rightToLeft,
    //     page: () => const MultiPostScreen()),
    // GetPage(
    //     name: kAddMultiPost,
    //     transition: Transition.rightToLeft,
    //     page: () => const AddMultiScreen()),
    // GetPage(
    //     name: kEditMultiPost,
    //     transition: Transition.rightToLeft,
    //     page: () => const EditMultiScreen()),
    // GetPage(
    //     name: kToolsScreen,
    //     transition: Transition.rightToLeft,
    //     page: () => const ToolsScreen()),
    // GetPage(
    //     name: kDigitalInfluencerScreen,
    //     transition: Transition.rightToLeft,
    //     page: () => const DigitalInfluencer()),
    // GetPage(
    //     name: kLogoScreen,
    //     transition: Transition.rightToLeft,
    //     page: () => const LogosScreen()),
    // GetPage(
    //     name: kMusicScreen,
    //     transition: Transition.rightToLeft,
    //     page: () => const MusicScreen()),
    // GetPage(
    //     name: kAiBLogScreen,
    //     transition: Transition.rightToLeft,
    //     page: () => const AiBLogScreen()),

    //
  ];
}
