import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/Bloc/cartbloc/cart_bloc.dart';
import 'package:grocery_app/model/Model.dart';
import 'package:grocery_app/screens/Orderaccetscreen.dart';
import 'package:grocery_app/utils/AppColors.dart';

class Cartscreen extends StatefulWidget {
  const Cartscreen({Key? key}) : super(key: key);

  @override
  State<Cartscreen> createState() => _CartscreenState();
}

class _CartscreenState extends State<Cartscreen> {
  // Singleton data = Singleton();
  // List<Product> productsincart = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // data.allproducts.forEach((element) {
    //   if (element.inCart! > 0) {
    //     productsincart.add(element);
    //   }
    // });
    //
    // print("${productsincart[0].name}    ${productsincart[0].inCart}");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocProvider<CartBloc>(
      create: (context) => CartBloc()..add(Cartinitevent([])),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartinitState) {
            return Scaffold(
              body: SafeArea(
                  child: state.productsincart!.isEmpty
                      ? Center(
                          child: Text(
                          "No Items in Cart!",
                          style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w600),
                        ))
                      : Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.78,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text("My Cart", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 18)),
                                  ),
                                  Expanded(
                                      child: ListView.builder(physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                                    itemCount: state.productsincart!.length,
                                    itemBuilder: (context, index) {
                                      return Row(children: [
                                        Container(
                                          height: width * 0.3,
                                          width: width * 0.3,
                                          padding: const EdgeInsets.all(10),
                                          child: Image.asset(state.productsincart![index].images![0]),
                                        ),
                                        Container(
                                          width: width * 0.69,
                                          padding: const EdgeInsets.all(15),
                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 20, right: 10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      state.productsincart![index].name!,
                                                      style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 18),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        state.productsincart![index].inCart = 0;
                                                        BlocProvider.of<CartBloc>(context).add(Cartinitevent(state.productsincart));
                                                      },
                                                      child: const Icon(Icons.close))
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                                              child: Text(
                                                state.productsincart![index].quantity!,
                                                style: GoogleFonts.montserrat(fontSize: 16),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    state.productsincart![index].inCart = state.productsincart![index].inCart! - 1;
                                                    BlocProvider.of<CartBloc>(context).add(Cartinitevent(state.productsincart));
                                                  },
                                                  child: Container(
                                                    width: 42,
                                                    height: 42,
                                                    decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(15)),
                                                    child: const Center(
                                                        child: Divider(
                                                      color: Colors.black,
                                                      endIndent: 12,
                                                      indent: 12,
                                                      thickness: 1,
                                                    )),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 42,
                                                  height: 42,
                                                  child: Center(child: Text("${state.productsincart![index].inCart}")),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    state.productsincart![index].inCart = state.productsincart![index].inCart! + 1;
                                                    BlocProvider.of<CartBloc>(context).add(Cartinitevent(state.productsincart));
                                                  },
                                                  child: Container(
                                                    width: 42,
                                                    height: 42,
                                                    decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(15)),
                                                    child: const Center(
                                                        child: Text(
                                                      "+",
                                                      style: TextStyle(color: AppColors.primary, fontSize: 35, fontWeight: FontWeight.w300),
                                                    )),
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "\$${state.productsincart![index].price}",
                                                  style: GoogleFonts.montserrat(fontSize: 22, fontWeight: FontWeight.w500),
                                                )
                                              ],
                                            )
                                          ]),
                                        )
                                      ]);
                                    },
                                  ))
                                ],
                              ),
                            ),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: GestureDetector(
                                      onTap: () {
                                        bottomsheet(state.totalprice,state.productsincart);
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 70,
                                        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(15)),
                                        child: Padding(
                                            padding: EdgeInsets.all(15),
                                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                              Text(
                                                "Checkout",
                                                style: GoogleFonts.montserrat(color: AppColors.textcolor, fontWeight: FontWeight.w500, fontSize: 20),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.black12),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    "\$ ${state.totalprice.toStringAsFixed(2)}",
                                                    style: GoogleFonts.montserrat(fontSize: 18, color: AppColors.textcolor),
                                                  ),
                                                ),
                                              ),
                                            ])),
                                      ),
                                    )))
                          ],
                        )),
            );
          } else {
            return const Scaffold(
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

  Future bottomsheet(double totalprice, List<Product>? productsincart,) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12, top: 18, left: 18, right: 18),
                child: Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Checkout",
                      style: GoogleFonts.montserrat(fontSize: 28, fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.close,
                          size: 28,
                        ))
                  ],
                )),
              ),
              const Divider(
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18, left: 18, top: 8, bottom: 8),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(
                    "Delivery",
                    style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black45),
                  ),
                  Row(
                    children: [
                      Text(
                        "Select Method",
                        style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(Icons.arrow_forward_ios),
                      )
                    ],
                  )
                ]),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 18, right: 18),
                child: Divider(thickness: 1),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18, left: 18, top: 8, bottom: 8),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(
                    "Payment Method",
                    style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black45),
                  ),
                  Row(
                    children: [
                      Image.asset("assets/images/mastecard.png", height: 13),
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(Icons.arrow_forward_ios),
                      )
                    ],
                  )
                ]),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 18, right: 18),
                child: Divider(thickness: 1),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18, left: 18, top: 8, bottom: 8),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(
                    "Promo Code",
                    style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black45),
                  ),
                  Row(
                    children: [
                      Text(
                        "Pick Discount",
                        style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(Icons.arrow_forward_ios),
                      )
                    ],
                  )
                ]),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 18, right: 18),
                child: Divider(thickness: 1),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18, left: 18, top: 8, bottom: 8),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(
                    "Total Cost",
                    style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black45),
                  ),
                  Row(
                    children: [
                      Text(
                        "\$${totalprice.toStringAsFixed(2)}",
                        style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(Icons.arrow_forward_ios),
                      )
                    ],
                  )
                ]),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 18, right: 18),
                child: Divider(thickness: 1),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Text(
                  "By placing an order you agree to our",
                  style: GoogleFonts.montserrat(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black45),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18, top: 5),
                child: Row(
                  children: [
                    Text(
                      "Terms",
                      style: GoogleFonts.montserrat(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                    Text(
                      " And ",
                      style: GoogleFonts.montserrat(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black45),
                    ),
                    Text(
                      "Conditions",
                      style: GoogleFonts.montserrat(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10, right: 18, left: 18,bottom: 10),
                  child: GestureDetector(onTap: () {
                    for(int i=0;i<productsincart!.length;i++){
                      productsincart[i].inCart = 0;
                    }
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                      return OrederAccept();
                    },), (route) => false);
                  },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: Text(
                        "Place Order",
                        style: GoogleFonts.montserrat(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                      )),
                    ),
                  ))
            ]),
          ),
        );
      },
    );
  }
}
