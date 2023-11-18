import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/screens/Mainactivity.dart';
import 'package:grocery_app/screens/homescreen.dart';
import 'package:grocery_app/utils/AppColors.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';

class OrederAccept extends StatefulWidget {
  const OrederAccept({Key? key}) : super(key: key);

  @override
  State<OrederAccept> createState() => _OrederAcceptState();
}

class _OrederAcceptState extends State<OrederAccept> with TickerProviderStateMixin {
  AnimationController? _controller;
  final player = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
    player.setAsset("assets/audio/orderacceptaudio.mp3");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return MainActivity(0);
          },
        ));
        return true;
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/orderacceptedbg.png"), fit: BoxFit.fill)),
          child: SafeArea(
              child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 70,
                    ),
                    child: Center(
                        child: Lottie.asset(
                      "assets/lottie/orderaccepted.json",
                      onLoaded: (p0) {
                        player.play();
                        _controller!
                          ..duration = p0.duration
                          ..forward();
                      },
                      controller: _controller,
                    )),
                  ),
                  Text(
                    "Your Order has been \n accepted",
                    style: GoogleFonts.montserrat(fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Your items has been placcd and is on \n it’s way to being processed",
                    style: GoogleFonts.montserrat(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(15)),
                        height: 60,
                        child: Center(
                            child: Text(
                          "Track Order",
                          style: GoogleFonts.montserrat(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                        )),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return MainActivity(0);
                            },
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                          height: 60,
                          child: Center(
                              child: Text(
                            "Back to Home",
                            style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w600),
                          )),
                        ),
                      )),
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }
}
