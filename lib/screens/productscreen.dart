import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/Bloc/ProductBloc/product_bloc.dart';
import 'package:grocery_app/model/Model.dart';
import 'package:grocery_app/screens/favouritescreen.dart';
import 'package:like_button/like_button.dart';
import '../utils/AppColors.dart';
import 'Mainactivity.dart';

class ProductPage extends StatefulWidget {
  Product? product;
  bool fromfavourite;
  ProductPage(this.product, this.fromfavourite, {Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int pageindex = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
onback(){

}
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(onWillPop: () async {
      if(widget.fromfavourite){
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return MainActivity(3);
          },
        ));
      } else{
        Navigator.pop(context);
      }
      return true;
    },
      child: BlocProvider<ProductBloc>(
        create: (context) => ProductBloc()..add(ProductInitEvent(widget.product)),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductInitState) {
              print("isfavourite:::${state.product!.isFavourite}");
              return Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                    child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            // Expanded(
                            //   child: PageView.builder(
                            //     pageSnapping: true,
                            //     itemCount: widget.product!.images!.length,
                            //     itemBuilder: (context, index) {
                            //       return Container(margin: EdgeInsets.all(10), child: Image.asset(widget.product!.images![index], height: 30));
                            //     },
                            //   ),
                            // ),
                            Stack(
                              children: [
                                CarouselSlider(
                                    items: state.product!.images!.map((e) {
                                      return Container(
                                        color: Colors.white,
                                        child: Image.asset(e),
                                      );
                                    }).toList(),
                                    options: CarouselOptions(
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          pageindex = index;
                                        });
                                      },
                                      height: width * 0.7,
                                      enlargeCenterPage: true,
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    if(widget.fromfavourite){
                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                        builder: (context) {
                                          return MainActivity(3);
                                        },
                                      ));
                                    } else{
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(),
                                    child: Icon(Icons.arrow_back_ios, size: 35),
                                  ),
                                )
                              ],
                            ),
                            Center(
                              child: CarouselIndicator(
                                space: 5,
                                color: Colors.black12,
                                count: state.product!.images!.length,
                                index: pageindex,
                                activeColor: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                            maxLines: 2,
                                            state.product!.name!,
                                            style: GoogleFonts.montserrat(fontSize: 22, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      LikeButton(
                                        size: 35,
                                        isLiked: state.product!.isFavourite,
                                        onTap: (isLiked) async {
                                          widget.product!.isFavourite! ? widget.product!.isFavourite = false : widget.product!.isFavourite = true;
                                          print("isfavouritle:::${widget.product!.isFavourite}");
                                          BlocProvider.of<ProductBloc>(context).add(ProductInitEvent(widget.product));
                                          return !isLiked;
                                        },
                                      )
                                    ],
                                  ),
                                  Text(
                                    state.product!.quantity!,
                                    style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20, left: 20),
                              child: Text(
                                "\$${state.product!.price}",
                                style: GoogleFonts.montserrat(fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(state.product!.description!),
                            )
                          ]),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          if(state.product!.inCart!<=0){
                            widget.product!.inCart = widget.product!.inCart! + 1;
                            BlocProvider.of<ProductBloc>(context).add(ProductInitEvent(widget.product));
                          }
                        },
                        child: Container(
                          width: width,
                          height: 55,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              color: AppColors.primary,
                              width: 210,
                              child: Center(
                                child: Text(
                                  state.product!.inCart! > 0 ? "Added to Basket" : "Add to Basket",
                                  style: GoogleFonts.montserrat(color: AppColors.textcolor, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
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
      ),
    );
  }
}
