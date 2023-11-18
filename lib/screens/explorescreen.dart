import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/Bloc/explorebloc/explore_bloc.dart';
import 'package:grocery_app/model/singleton.dart';

import '../utils/AppColors.dart';
import 'Categoryscreen.dart';

class explorescreen extends StatefulWidget {
  const explorescreen({Key? key}) : super(key: key);

  @override
  State<explorescreen> createState() => _explorescreenState();
}

class _explorescreenState extends State<explorescreen> {
  TextEditingController searchtext = TextEditingController();
  Singleton data = Singleton();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocProvider<ExploreBloc>(
      create: (context) => ExploreBloc()..add(ExploreInitEvent(categories: data.finalresponse!.categories!)),
      child: BlocBuilder<ExploreBloc, ExploreState>(
        builder: (context, state) {
          if (state is ExploreInitState) {
            return Scaffold(
              body: SafeArea(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedContainer(
                      height: state.bottomcontainer! ? MediaQuery.of(context).size.height * 0.04 : 0,
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.all(state.paddingsecondtopcontainerbottom!),
                      child: Text(
                        "Find Products",
                        style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: width,
                    padding:
                        EdgeInsets.only(top: 0,left: state.paddingsecondtopcontainerleft!, right: state.paddingsecondtopcontainerright!, bottom: state.paddingsecondtopcontainerbottom!),
                    child: Stack(
                      children: [
                        TextField(
                            cursorColor: AppColors.primary,
                            style: TextStyle(fontSize: 20),
                            controller: searchtext,
                            onChanged: (value) {
                              BlocProvider.of<ExploreBloc>(context).add(SearchonChangeEvent(data.finalresponse!.categories!, data.allproducts, value));
                            },
                            onTap: () {
                              BlocProvider.of<ExploreBloc>(context).add(SearchTapEvent(data.finalresponse!.categories!));
                            },
                            decoration: InputDecoration(
                                hintText: "Search For products",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(state.secondcontainerradius!)),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(state.secondcontainerradius!)),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(state.secondcontainerradius!), borderSide: BorderSide(width: 0.5)))),
                        state.forcancelbutton!
                            ? Positioned.fill(
                                child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    searchtext.clear();
                                    FocusScope.of(context).unfocus();
                                    BlocProvider.of<ExploreBloc>(context).add(ExploreInitEvent(categories: data.finalresponse!.categories!));
                                  },
                                ),
                              ))
                            : SizedBox()
                      ],
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    child: state.bottomcontainer!
                        ? Expanded(
                            child: GridView.builder(
                              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                              itemCount: 6,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(13),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return Categoryscreen(state.categories[index]);
                                        },
                                      ));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all()),
                                      child: Column(children: [
                                        Container(
                                          height: width * 0.3,
                                          padding: const EdgeInsets.all(15),
                                          child: Image.asset(
                                            state.categories[index].thumb!,
                                            alignment: Alignment.bottomCenter,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              state.categories[index].category!,
                                              style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ]),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Expanded(
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
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                          ),
                  )
                ],
              )),
            );
          } else {
            return const Scaffold(body: SafeArea(child: Center(child: CircularProgressIndicator())));
          }
        },
      ),
    );
  }
}
