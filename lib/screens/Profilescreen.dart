import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.035,
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    "My Profile",
                    style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )),
            Divider(thickness: 1.2),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(children: [  
                Container(height: 80, child: Image.asset("assets/images/profileimage.png")),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Viraj Moradiya",
                      style: GoogleFonts.poppins(fontSize: 22),
                    ),
                    Text(
                      "testmail@gmail.com",
                      style: GoogleFonts.poppins(fontSize: 18, color: Colors.black54),
                    )
                  ],
                )
              ]),
            ),
            Divider(thickness: 1.2),
            Expanded(
                child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              child: Column(children: [
                Customewidget("assets/iconimages/MyDetailsicon.png", "User Details"),
                Divider(thickness: 1.1, endIndent: 20, indent: 20),
                Customewidget("assets/iconimages/Ordersicon.png", "My Orders"),
                Divider(thickness: 1.1, endIndent: 20, indent: 20),
                Customewidget("assets/iconimages/Deliceryaddress.png", "Delivery Address"),
                Divider(thickness: 1.1, endIndent: 20, indent: 20),
                Customewidget("assets/iconimages/paymenticon.png", "Payment Methods"),
                Divider(thickness: 1.1, endIndent: 20, indent: 20),
                Customewidget("assets/iconimages/PromoCordicon.png", "Offers and Promocodes"),
                Divider(thickness: 1.1, endIndent: 20, indent: 20),
                Customewidget("assets/iconimages/abouticon.png", "About us"),
              ]),
            ))
          ],
        ),
      ),
    );
  }

  Widget Customewidget(String imagepath, String Title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
      child: Row(
        children: [
          Image.asset(
            imagepath,
            width: 22,
          ),
          SizedBox(width: 15),
          Text(
            Title,
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 19,
          ),
        ],
      ),
    );
  }
}
