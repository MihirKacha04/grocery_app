import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchtext = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          TextField(
            controller: searchtext,
            decoration: InputDecoration(hintText: "Search For Products"),
            maxLines: 1,
          ),
          searchtext.text.isEmpty
              ? Expanded(
                  child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(children: [
                        Row(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Tomato",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),Spacer(),
                          IconButton(onPressed: () {

                          }, icon: Icon(Icons.arrow_back_sharp,))
                        ]),
                        Divider()
                      ]),
                    );
                  },
                ))
              : Expanded(child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container();
                  },
                ))
        ],
      )),
    );
  }
}
