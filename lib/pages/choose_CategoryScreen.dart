import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inews/pages/category_page.dart';

OverlayEntry? _overlayEntry;
String CategoryName = '';

List<String> CategoriesList = [
  'General',
  'Entertainment',
  'Health',
  'Sports',
  'Buisness',
  'Technology'
];

void showOverlay(BuildContext context) {
  OverlayState overlayState = Overlay.of(context);
  _overlayEntry = OverlayEntry(
    builder: (context) => OverlayWidget(),
  );
  overlayState.insert(_overlayEntry!);
}

void closeOverlay() {
  _overlayEntry?.remove();
  _overlayEntry = null;
}

class OverlayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.black.withOpacity(0.9),
      child: ListView(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      closeOverlay();
                    },
                    child: Icon(
                      Icons.clear,
                      color: Colors.white,
                    )),
                SizedBox(width: 30),
                Text(
                  'C A T E G O R I E S',
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.06),
          Container(
            height: height * 0.9,
            width: width * 0.9,
            child: Material(
              color: Colors.transparent,
              child: ListView.builder(
                itemCount: CategoriesList.length,
                itemBuilder: ((context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          closeOverlay(); // Close overlay when tapping a category
                          CategoryName = CategoriesList[index];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Category_page(
                                categ: CategoriesList[index].toLowerCase(),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: height * 0.10,
                          width: width * 0.7,
                          child: Center(
                            child: Text(
                              CategoriesList[index].toString(),
                              style: GoogleFonts.poppins(
                                decoration: TextDecoration.none,
                                color: CategoryName == CategoriesList[index]
                                    ? Colors.blue
                                    : Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.8,
                        child: Divider(
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
