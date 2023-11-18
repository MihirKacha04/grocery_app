import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/Bloc/homescreenbloc/homescreen_bloc.dart';
import 'package:grocery_app/model/singleton.dart';
import 'package:grocery_app/screens/Categoryscreen.dart';
import 'package:grocery_app/screens/productscreen.dart';
import 'package:grocery_app/utils/AppColors.dart';
import 'package:like_button/like_button.dart';

import '../model/Model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Singleton data = Singleton();
  TextEditingController searchtext = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("${data.finalresponse!.categories![0].category}");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocProvider<HomeScreenBloc>(
      create: (context) => HomeScreenBloc()
        ..add(HomeScreenInitEvent(
            exclusive: data.finalresponse!.categories![6], bestselling: data.finalresponse!.categories![7])),
      child: BlocBuilder<HomeScreenBloc, HomescreenState>(
        builder: (context, state) {
          var toadd = BlocProvider.of<HomeScreenBloc>(context);
          if (state is HomescreenInitState) {
            return Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: state.animatedtopcontainer,
                      color: AppColors.primary,
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/cart-white.png", height: 30),
                            Text("FreshMart",
                                style: GoogleFonts.montserrat(
                                    color: AppColors.textcolor, fontSize: 22, fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      color: AppColors.primary,
                      duration: const Duration(milliseconds: 300),
                      padding: EdgeInsets.only(
                          left: state.paddingsecondtopcontainerleft!,
                          right: state.paddingsecondtopcontainerright!,
                          bottom: state.paddingsecondtopcontainerbottom!),
                      child: AnimatedContainer(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(state.secondcontainerradius!),
                            color: AppColors.textcolor),
                        duration: const Duration(milliseconds: 500),
                        child: Stack(
                          children: [
                            TextField(
                                controller: searchtext,
                                onChanged: (value) {
                                  BlocProvider.of<HomeScreenBloc>(context).add(SearchOnChangeEvent(
                                      data.finalresponse!.categories![6],
                                      data.finalresponse!.categories![7],
                                      data.allproducts,
                                      value));
                                },
                                // style: TextStyle(fontSize: 25),
                                onTap: () {
                                  BlocProvider.of<HomeScreenBloc>(context)
                                      .add(SearchTapEvent(state.exclusive, state.bestselling));
                                },
                                cursorColor: AppColors.primary,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 15),
                                  constraints: const BoxConstraints(maxHeight: 60),
                                  focusedBorder:
                                      const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: AppColors.primary),
                                      borderRadius: BorderRadius.circular(11)),
                                  enabledBorder:
                                      const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
                                  hintText: "Search Product",
                                )),
                            state.forcancelbutton!
                                ? Positioned.fill(
                                    child: Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.cancel,
                                        size: 30,
                                        color: AppColors.primary,
                                      ),
                                      onPressed: () {
                                        searchtext.clear();
                                        FocusScope.of(context).unfocus();
                                        BlocProvider.of<HomeScreenBloc>(context).add(HomeScreenInitEvent(
                                            exclusive: data.finalresponse!.categories![6],
                                            bestselling: data.finalresponse!.categories![7]));
                                      },
                                    ),
                                  ))
                                : SizedBox()
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Text("FreshMart",style: GoogleFonts.montserrat(fontSize: 18,fontWeight: FontWeight.w600),),
                            AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                child: state.bottomcontainer!
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 13, right: 13, top: 20, bottom: 20),
                                            child: SizedBox(
                                                width: double.infinity,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text("Exclusive Offer",
                                                        style: GoogleFonts.montserrat(
                                                            fontWeight: FontWeight.w600, fontSize: 23)),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(context, MaterialPageRoute(
                                                          builder: (context) {
                                                            return Categoryscreen(state.exclusive!);
                                                          },
                                                        ));
                                                      },
                                                      child: Text(
                                                        "See all",
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w500,
                                                            color: AppColors.primary),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                          ),
                                          SizedBox(
                                            height: 230,
                                            child: ListView.builder(
                                              physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: data.finalresponse!.categories![6].products!.length,
                                              itemBuilder: (context, index) {
                                                return productcard(
                                                    data.finalresponse!.categories![6].products![index], toadd);
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 13, right: 13, top: 20, bottom: 20),
                                            child: SizedBox(
                                                width: double.infinity,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text("Best Selling",
                                                        style: GoogleFonts.montserrat(
                                                            fontWeight: FontWeight.w600, fontSize: 23)),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(context, MaterialPageRoute(
                                                          builder: (context) {
                                                            return Categoryscreen(state.bestselling!);
                                                          },
                                                        ));
                                                      },
                                                      child: Text(
                                                        "See all",
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w500,
                                                            color: AppColors.primary),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                          ),
                                          SizedBox(
                                            height: 230,
                                            child: ListView.builder(
                                              physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: data.finalresponse!.categories![7].products!.length,
                                              itemBuilder: (context, index) {
                                                return productcard(
                                                    data.finalresponse!.categories![7].products![index], toadd);
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 13, right: 13, top: 20, bottom: 20),
                                            child: SizedBox(
                                                width: double.infinity,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text("Groceries",
                                                        style: GoogleFonts.montserrat(
                                                            fontWeight: FontWeight.w600, fontSize: 23)),
                                                    Text(
                                                      "See all",
                                                      style: GoogleFonts.montserrat(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w500,
                                                          color: AppColors.primary),
                                                    )
                                                  ],
                                                )),
                                          ),
                                          SizedBox(
                                            height: 110,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: 5,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Color(0xEFE1D3FF),
                                                        borderRadius: BorderRadius.circular(15)),
                                                    width: 200,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(10),
                                                          child: Image.asset(
                                                            "assets/images/pulses.png",
                                                            height: 50,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.all(10),
                                                          child: Text(
                                                            "Pulses",
                                                            style: GoogleFonts.montserrat(
                                                                fontWeight: FontWeight.w600, fontSize: 19),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                        ],
                                      )
                                    : Container(
                                        height: MediaQuery.of(context).size.height * 0.8,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: state.searchproducts!.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                // Navigator.pushReplacement(context, MaterialPageRoute(
                                                //   builder: (context) {
                                                //     return ProductPage(state.searchproducts![index],true);
                                                //   },
                                                // ));
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
                                                      child: Image.asset(state.searchproducts![index].images![0]),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child:
                                                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                      Container(
                                                          width: width * 0.42,
                                                          child: Text(
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            state.searchproducts![index].name!,
                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                          )),
                                                      Container(
                                                        padding: EdgeInsets.only(top: 5),
                                                        child: Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          state.searchproducts![index].quantity!,
                                                          style: TextStyle(fontSize: 16),
                                                        ),
                                                      )
                                                    ]),
                                                  ),
                                                  Expanded(
                                                    child: Row(children: [
                                                      Text(
                                                        "\$${state.searchproducts![index].price}",
                                                        style:
                                                            const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                                      ),
                                                      const SizedBox(width: 3),
                                                      const Icon(Icons.arrow_forward_ios)
                                                    ]),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      )),
                            // SizedBox(
                            //   height: 230,
                            //   child: ListView.builder(
                            //     scrollDirection: Axis.horizontal,
                            //     itemCount: 5,
                            //     itemBuilder: (context, index) {
                            //       return productcard();
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              body: SafeArea(
                  child: Center(
                child: CircularProgressIndicator(),
              )),
            );
          }
        },
      ),
    );
  }

  Widget productcard(Product product, HomeScreenBloc toadd) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ProductPage(product, false);
          },
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Container(
          width: 160,
          decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Image.asset(
                  product.images![0],
                  height: 80,
                ),
              ),
              Text(
                product.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              Text(
                product.quantity!,
                style: GoogleFonts.montserrat(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$${product.price}",
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 18)),
                    LikeButton(
                      onTap: (isLiked) async {
                        if (isLiked) {
                          product.inCart = 0;
                          toadd.add(HomeScreenInitEvent(
                              exclusive: data.finalresponse!.categories![6],
                              bestselling: data.finalresponse!.categories![7]));
                          Fluttertoast.showToast(
                              msg: "Item Removed from cart",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: AppColors.primary,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          product.inCart = 1;
                          toadd.add(HomeScreenInitEvent(
                              exclusive: data.finalresponse!.categories![6],
                              bestselling: data.finalresponse!.categories![7]));
                          Fluttertoast.showToast(
                              msg: "Item added to cart",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: AppColors.primary,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                        return !isLiked;
                      },
                      isLiked: (product.inCart! > 0),
                      animationDuration: Duration(seconds: 1),
                      bubblesColor:
                          BubblesColor(dotPrimaryColor: AppColors.primary, dotSecondaryColor: Colors.yellowAccent),
                      circleColor: CircleColor(start: Colors.yellowAccent, end: AppColors.primary),
                      size: 35,
                      likeBuilder: (isLiked) {
                        if (isLiked) {
                          return Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(),
                                color: AppColors.primary),
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Image.asset("assets/images/check.png"),
                            ),
                          );
                        } else {
                          return Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(),
                                color: AppColors.primary),
                            child: const Icon(Icons.add),
                          );
                        }
                      },
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
