import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/model/Model.dart';
import 'package:grocery_app/model/singleton.dart';
import 'package:grocery_app/utils/AppColors.dart';
import 'package:grocery_app/screens/welcomescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ResponseModel? finalresponse;
  Category? category;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Singleton().adddata();
    Singleton().allproducts[0].inCart = 3;
    Singleton().allproducts[1].inCart = 1;
    Singleton().allproducts[5].inCart = 6;
    Singleton().allproducts[8].inCart = 2;
    Singleton().allproducts[0].isFavourite = true;
    Singleton().allproducts[1].isFavourite = true;
    Singleton().allproducts[5].isFavourite = true;
    Singleton().allproducts[8].isFavourite = true;
    Singleton().finalresponse!.categories![6] = Category(thumb: "null", category: "Exclusive Offer", products: [
      Singleton().allproducts[0],
      Singleton().allproducts[2],
      Singleton().allproducts[5],
      Singleton().allproducts[7],
      Singleton().allproducts[9],
      Singleton().allproducts[17],
      Singleton().allproducts[1],
      Singleton().allproducts[15],
    ]);
    Singleton().finalresponse!.categories![7] = Category(thumb: "null", category: "Best Selling", products: [
      Singleton().allproducts[7],
      Singleton().allproducts[12],
      Singleton().allproducts[5],
      Singleton().allproducts[18],
      Singleton().allproducts[9],
      Singleton().allproducts[6],
      Singleton().allproducts[1],
      Singleton().allproducts[20],
    ]);
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return WelcomeScreen();
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: Duration(seconds: 2)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      color: AppColors.primary,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/cart-white.png",
                height: 50,
              ),
              Text(
                "FreshMart",
                style: GoogleFonts.montserrat(fontSize: 50, color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Text(
            "Online Groceries",
            style: GoogleFonts.montserrat(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ],
      )),
    )));
  }
}
