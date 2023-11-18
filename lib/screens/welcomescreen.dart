import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/screens/homescreen.dart';
import 'package:grocery_app/utils/AppColors.dart';

import 'Mainactivity.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Image.asset("assets/images/deliveryboy.webp",
              fit: BoxFit.cover, width: double.infinity),
          Align(
              alignment: Alignment.bottomCenter,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text("Welcome\nto our store",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        fontSize: 40,
                        color: AppColors.textcolor,
                        fontWeight: FontWeight.w500)),
                Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text("Ger your groceries in as fast as one hour",
                        style: GoogleFonts.montserrat(
                            color: AppColors.textcolor))),
                Padding(
                  padding: const EdgeInsets.only(top: 18, bottom: 55),
                  child: InkWell(onTap: () {
                    print("object");
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return MainActivity(0);
                    },));
                  },
                    child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12)),
                        height: 60,
                        width: width * 0.79,
                        child: Center(
                            child: Text("Get Started",
                                style: GoogleFonts.montserrat(
                                    color: AppColors.textcolor, fontSize: 17)))),
                  ),
                )
              ]))
        ],
      )),
    );
  }
}
