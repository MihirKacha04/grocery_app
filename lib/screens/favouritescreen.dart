import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/screens/productscreen.dart';

import '../model/Model.dart';
import '../model/singleton.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  Singleton data = Singleton();
  List<Product> favouriteproduct = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data.allproducts.forEach((element) {
      if (element.isFavourite!) {
        favouriteproduct.add(element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Favourites",
                style: GoogleFonts.montserrat(fontSize: 22, fontWeight: FontWeight.bold),
              )),
          Expanded(
              child: ListView.builder(physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            itemCount: favouriteproduct.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return ProductPage(favouriteproduct[index],true);
                    },
                  ));
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: width * 0.25,
                        width: width * 0.25,
                        child: Image.asset(favouriteproduct[index].images![0]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Container(
                            width: width * 0.42,
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              favouriteproduct[index].name!,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            )),
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            favouriteproduct[index].quantity!,
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ]),
                    ),
                    Expanded(
                      child: Row(children: [
                      Text(
                      "\$${favouriteproduct[index].price}",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),const SizedBox(width: 3),
                      const Icon(Icons.arrow_forward_ios)
                      ]),
                    )
                  ],
                ),
              );
            },
          ))
        ],
      )),
    );
  }
}
