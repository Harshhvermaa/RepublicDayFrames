import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:republic_day_final/widget/gradientButton.dart';
import '../adsController/adscontroller.dart';
import 'postmaking.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => HomescreenState();
}

class HomescreenState extends State<Homescreen> {
  //  BannerAd? bannerAd2;
  bool? isLoaded;
  XFile? xFile;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adController().createBannerAd();
    adController().createBannerAd4();
    adController().createInterstitial();
    // _createBannerAd2();
  }

  // _createBannerAd2() {
  //   bannerAd2 = BannerAd(
  //     size: AdSize.fullBanner,
  //     adUnitId: bannerunitId2,
  //     listener: bannerAdListener,
  //     request: const AdRequest(),
  //   )..load();
  // }
  getImage(ImageSource source) async {
    xFile = await _picker.pickImage(source: source);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    print("$height ddsfdsf");
    print("$width dfsdfsdf ");

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 59, 72),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/bg.png"),fit: BoxFit.fill)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 52.h,
              child: AdWidget(ad: bannerAd4!),
            ),
            SizedBox(
              height: 90.h,
            ),
            
            Image(image: AssetImage("assets/greeting.png"),width: width*0.9.h,),
            
            SizedBox(
              height: 30.h,
            ),
            
            Image(image: AssetImage("assets/text.png"),width: width*0.7.h,),
            
            Spacer(),
            // Camera
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0.w),
              child: SizedBox(
                width: double.infinity,
                height: 90.h,
                child: gradientButton(
                    onPressed: () async {
                      await adController().showInterstitialAD();
                      await getImage(ImageSource.camera);
                      xFile != null
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return postMakingScreen(
                                    xfile: xFile!,
                                  );
                                },
                              ),
                            )
                          : adController().showInterstitialAD();
                    },
                    text: "Camera",
                    textcolor: Color.fromARGB(255, 15, 0, 41),
                    ),
              ),
            ),

            SizedBox(
              height: 40.h,
            ),
            // Gallery
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0.w),
              child: SizedBox(
                width: double.infinity,
                height: 90.h,
                child: gradientButton(
                    onPressed: () async {
                      print("object");
                      adController().showInterstitialAD();
                      await getImage(ImageSource.gallery);
                      xFile != null
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return postMakingScreen(
                                    xfile: xFile!,
                                  );
                                },
                              ),
                            )
                          : adController().showInterstitialAD();
                    },
                    text: "Gallery",
                    textcolor: Color.fromARGB(255, 15, 0, 41),
                    ),
              ),
            ),
            
            const Spacer(),
            SizedBox(
              height: 52.h,
              child: AdWidget(ad: bannerAd!),
            )
          ],
        ),
      ),
    );
  }
}