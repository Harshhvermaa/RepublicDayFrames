import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';

import '../adsController/adscontroller.dart';
import '../frames/frames 1.dart';
import '../widget/gradientButton.dart';

class postMakingScreen extends StatefulWidget {
  XFile? xfile;
  postMakingScreen({required this.xfile});

  @override
  State<postMakingScreen> createState() => postMakingScreenState();
}

class postMakingScreenState extends State<postMakingScreen> {

  List<String> frames = Constantt().frames;
  Image? _image;
  String _currentFrame = "assets/2.png";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adController().createBannerAd2();
    adController().createBannerAd3();
    adController().createInterstitial();
    adController().createInterstitial2();
    adController().createBannerAd3();
  }

  GlobalKey previewContainer = GlobalKey();
  int originalSize = 800;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg.png"), fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            bannerAd3 != null
                ? SizedBox(
                    height: 55.h,
                    child: AdWidget(ad: bannerAd2!),
                  )
                : const SizedBox(),
            bannerAd2 != null
                ? SizedBox(
                    height: 55.h,
                    child: AdWidget(ad: bannerAd3!),
                  )
                : const SizedBox(),
            SizedBox(
              height: 40.h,
            ),
            RepaintBoundary(
              key: previewContainer,
              child: 
              Container(
                height: 500.h,
                width: double.maxFinite,
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("object");
                      },
                      child: SizedBox(
                        height: 500.h,
                        width: double.maxFinite,
                        child: InteractiveViewer(
                          panEnabled: true,
                          constrained: true,
                          alignPanAxis: true,
                          scaleEnabled: true,
                          scaleFactor: 200,
                          boundaryMargin: EdgeInsets.all(300),
                          minScale: 0.1,
                          child: Image.file(
                            File(widget.xfile!.path.toString(),),
                          ),
                        ),
                      ),
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: GestureDetector(
                        onTap: () {
                          print("object2");
                        },
                        child: SizedBox(
                          height: 500.h,
                          width: double.infinity,
                          child: Image.asset(
                            _currentFrame,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
           
            Spacer(),
            //Save and share
            SizedBox(
              width: width * 0.97,
              height: 80.h,
              child: gradientButton(
                onPressed: () async {
                  RenderRepaintBoundary? boundary = (await previewContainer
                      .currentContext!
                      .findRenderObject()) as RenderRepaintBoundary?;
                  ui.Image image = await boundary!.toImage(pixelRatio: 0.8);
                  ByteData? byteData =
                      await image.toByteData(format: ui.ImageByteFormat.png);
                  Uint8List memoryImagedata = byteData!.buffer.asUint8List();

                    Directory output = await
                        Directory('/storage/emulated/0/Download');

                    final file = await File("${output.path}/${ DateFormat.s().format(DateTime.now()) + Random().nextInt(1000).toString() }.jpeg");
                    await file.writeAsBytes( memoryImagedata );
                    Fluttertoast.showToast(msg: "Your art is saved in /downloads folder");
                    print("object");
                  // await adController().createInterstitial2();
                  ShareFilesAndScreenshotWidgets().shareScreenshot(
                      previewContainer,
                      originalSize,
                      "Title",
                      "Name.png",
                      "image/png",
                      text: ""
                      );
                },
                fontSize: 30,
                text: "Save & Share",
                textcolor: Color(0xFF053D76),
              ),
            ),

            Spacer(),
            // Frames
            SizedBox(
              height: 150.h,
              child: ListView.builder(
                itemCount: frames.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentFrame = frames[index];
                      });
                    },
                    child: Container(
                      margin: EdgeInsetsDirectional.only(end: 10.w),
                      height: 150.h,
                      width: 150.w,
                      color: const Color.fromARGB(255, 255, 252, 252),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          frames[index],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
