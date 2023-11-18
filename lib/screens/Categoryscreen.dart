import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/Bloc/CategoryBloc/category_bloc.dart';
import 'package:grocery_app/model/Model.dart';
import 'package:grocery_app/screens/productscreen.dart';
import 'package:grocery_app/utils/AppColors.dart';
import 'package:like_button/like_button.dart';

class Categoryscreen extends StatefulWidget {
  Category categorie;

  Categoryscreen(this.categorie);

  @override
  State<Categoryscreen> createState() => _CategoryscreenState();
}

class _CategoryscreenState extends State<Categoryscreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryBloc>(
      create: (context) => CategoryBloc()..add(CategoryInitEvent(widget.categorie.products)),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryInitState) {
            return Scaffold(
              body: SafeArea(
                  child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios)),
                      ),
                      Text(
                        "${widget.categorie.category}",
                        style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ]),
                  ),
                  Expanded(
                      child: GridView.builder(
                    physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    itemCount: widget.categorie.products!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 260,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      print("${widget.categorie.products![index].name}  ${widget.categorie.products![index].inCart}");
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ProductPage(widget.categorie.products![index], false);
                              },
                            ));
                          },
                          child: Container(
                            decoration: BoxDecoration(border: Border.all(color: Colors.black45), borderRadius: BorderRadius.circular(20)),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Center(child: Image.asset(widget.categorie.products![index].images![0], height: MediaQuery.of(context).size.width * 0.25)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  "${widget.categorie.products![index].name}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  "${widget.categorie.products![index].quantity}",
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\$${widget.categorie.products![index].price}",
                                      style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    LikeButton(
                                      onTap: (isLiked) async {
                                        if (isLiked) {
                                          widget.categorie.products![index].inCart = 0;
                                          BlocProvider.of<CategoryBloc>(context).add(CategoryInitEvent(widget.categorie.products));
                                          Fluttertoast.showToast(
                                              msg: "Item Removed from cart",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: AppColors.primary,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        } else {
                                          widget.categorie.products![index].inCart = 1;
                                          BlocProvider.of<CategoryBloc>(context).add(CategoryInitEvent(widget.categorie.products));
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
                                      isLiked: (state.products![index].inCart! > 0),
                                      animationDuration: Duration(seconds: 1),
                                      bubblesColor: BubblesColor(dotPrimaryColor: AppColors.primary, dotSecondaryColor: Colors.yellowAccent),
                                      circleColor: CircleColor(start: Colors.yellowAccent, end: AppColors.primary),
                                      size: 35,
                                      likeBuilder: (isLiked) {
                                        if (isLiked) {
                                          return Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(), color: AppColors.primary),
                                            child: Padding(
                                              padding: const EdgeInsets.all(7.0),
                                              child: Image.asset("assets/images/check.png"),
                                            ),
                                          );
                                        } else {
                                          return Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(), color: AppColors.primary),
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
                      );
                    },
                  ))
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
    );
  }
}
