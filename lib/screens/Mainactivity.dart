import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/screens/Profilescreen.dart';
import 'package:grocery_app/screens/homescreen.dart';
import 'package:grocery_app/utils/AppColors.dart';

import '../Bloc/MainActivityBloc/main_activity_bloc.dart';
import 'cartscreen.dart';
import 'Searchscreen.dart';
import 'explorescreen.dart';
import 'favouritescreen.dart';

class MainActivity extends StatefulWidget {
  int index;

  MainActivity(this.index, {Key? key}) : super(key: key);

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  List<Widget> lis = [HomeScreen(), explorescreen(), Cartscreen(), FavouriteScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainActivityBloc>(
      create: (context) => MainActivityBloc()..add(Changetab(widget.index)),
      child: Scaffold(body: BlocBuilder<MainActivityBloc, MainActivityState>(
        builder: (context, state) {
          print(state is ChangeTabState);
          if (state is ChangeTabState) {
            print("state is changetabstate and state is ${state.index}");
            return lis.elementAt(state.index);
            // if (state.index == 0) {
            //   return HomeScreen();
            // } else if (state.index == 1) {
            //   return explorescreen();
            // } else if (state.index == 2) {
            //   return Cartscreen();
            // } else {
            //   return FavouriteScreen();
            // }
            // // else {
            // //   return SearchScreen();
            // // }
          } else {
            print("done");
            return HomeScreen();
          }
        },
      ), bottomNavigationBar: BlocBuilder<MainActivityBloc, MainActivityState>(
        builder: (context, state) {
          return BottomNavigationBar(
              backgroundColor: Colors.white30,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.primary,
              elevation: 10,
              currentIndex: (state is ChangeTabState) ? state.index : 0,
              onTap: (value) {
                BlocProvider.of<MainActivityBloc>(context).add(Changetab(value));
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_rounded), label: "Cart"),
                BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/images/heart-icon.png")), label: "Wishlist"),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: "My Profile"),
                // BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
              ]);
        },
      )),
    );
  }
}
