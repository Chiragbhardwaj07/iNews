import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inews/pages/category_page.dart';
import 'package:inews/pages/settings.dart';
import 'package:inews/pages/test.dart';

class ComplexDrawer extends StatefulWidget {
  final VoidCallback onButtonPressedin;
  final VoidCallback onButtonPressedus;
  final VoidCallback onButtonPressedch;
  final VoidCallback onButtonPressedfr;
  const ComplexDrawer(
      {Key? key,
      required this.onButtonPressedin,
      required this.onButtonPressedch,
      required this.onButtonPressedfr,
      required this.onButtonPressedus})
      : super(key: key);

  @override
  _ComplexDrawerState createState() => _ComplexDrawerState();
}

class _ComplexDrawerState extends State<ComplexDrawer> {
  int selectedIndex = -1; //dont set it to 0

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.85,
      child: row(),
      color: Colors.transparent,
    );
  }

  Widget row() {
    return Row(children: [
      isExpanded ? blackIconTiles() : blackIconMenu(),
      invisibleSubMenus(),
    ]);
  }

  Widget blackIconTiles() {
    return Container(
      width: 200,
      color: Colors.black,
      child: Column(
        children: [
          controlTile(),
          Expanded(
            child: ListView.builder(
              itemCount: cdms.length,
              itemBuilder: (BuildContext context, int index) {
                //  if(index==0) return controlTile();
                CDM cdm = cdms[index];
                bool selected = selectedIndex == index;

                return cdms[index].submenus.isEmpty
                    ? ListTile(
                        onTap: () {
                          if (index == 4) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Settings(),
                                ));
                          } else if (index == 3) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Category_page(categ: 'new'),
                                ));
                          } else if (index == 2) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Category_page(categ: 'trending'),
                                ));
                          }
                        },
                        leading: Icon(cdm.icon, color: Colors.white),
                        title: Text(
                          cdm.title,
                          style: GoogleFonts.poppins(
                              color: selected ? Colors.white : Colors.grey),
                        ),
                        trailing: cdm.submenus.isEmpty
                            ? null
                            : Icon(
                                selected
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                      )
                    : ExpansionTile(
                        onExpansionChanged: (z) {
                          setState(() {
                            selectedIndex = z ? index : -1;
                          });
                        },
                        leading: Icon(cdm.icon, color: Colors.white),
                        title: Text(
                          cdm.title,
                          style: GoogleFonts.poppins(
                              color: selected ? Colors.white : Colors.grey),
                        ),
                        trailing: cdm.submenus.isEmpty
                            ? null
                            : Icon(
                                selected
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                        children: cdm.submenus.map((subMenu) {
                          return sMenuButton(subMenu, false, index);
                        }).toList());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget controlTile() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 30),
      child: ListTile(
        leading: Image.asset('assets/news.png'),
        title: Text("iNews",
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        onTap: expandOrShrinkDrawer,
      ),
    );
  }

  Widget blackIconMenu() {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      width: 100,
      color: Colors.black,
      child: Column(
        children: [
          controlButton(),
          Expanded(
            child: ListView.builder(
                itemCount: cdms.length,
                itemBuilder: (contex, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                      if (index == 4) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Settings(),
                            ));
                      } else if (index == 3) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Category_page(categ: 'new'),
                            ));
                      } else if (index == 2) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Category_page(categ: 'trending'),
                            ));
                      }
                    },
                    child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      child: Icon(cdms[index].icon, color: Colors.white),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget invisibleSubMenus() {
    // List<CDM> _cmds = cdms..removeAt(0);
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: isExpanded ? 0 : 125,
      color: Colors.transparent,
      child: Column(
        children: [
          Container(height: 95),
          Expanded(
            child: ListView.builder(
                itemCount: cdms.length,
                itemBuilder: (context, index) {
                  CDM cmd = cdms[index];
                  // if(index==0) return Container(height:95);
                  //controll button has 45 h + 20 top + 30 bottom = 95

                  bool selected = selectedIndex == index;
                  bool isValidSubMenu = selected && cmd.submenus.isNotEmpty;
                  return subMenuWidget(
                      [cmd.title]..addAll(cmd.submenus), isValidSubMenu);
                }),
          ),
        ],
      ),
    );
  }

  Widget controlButton() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 30),
      child: InkWell(
        onTap: expandOrShrinkDrawer,
        child: Container(
          height: 45,
          alignment: Alignment.center,
          child: Image.asset(
            'assets/news.png',
          ),
        ),
      ),
    );
  }

  Widget subMenuWidget(List<String> submenus, bool isValidSubMenu) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: isValidSubMenu ? submenus.length.toDouble() * 37.5 : 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isValidSubMenu ? Colors.grey : Colors.transparent,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          )),
      child: ListView.builder(
          padding: EdgeInsets.all(6),
          itemCount: isValidSubMenu ? submenus.length : 0,
          itemBuilder: (context, index) {
            String subMenu = submenus[index];
            return sMenuButton(
              subMenu,
              index == 0,
              index,
            );
          }),
    );
  }

  Widget sMenuButton(
    String subMenu,
    bool isTitle,
    int mindex,
  ) {
    return InkWell(
      onTap: () {
        //handle the function
        //if index==0? donothing: doyourlogic here

        if (subMenu == "India") {
          widget.onButtonPressedin();
        } else if (subMenu == "US") {
          widget.onButtonPressedus();
        } else if (subMenu == "Russia") {
          widget.onButtonPressedch();
        } else if (subMenu == "France") {
          widget.onButtonPressedfr();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(subMenu,
            style: GoogleFonts.poppins(
              fontSize: isTitle ? 17 : 14,
              color: isTitle ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }

  static List<CDM> cdms = [
    CDM(Icons.location_on_outlined, "Locations",
        ["US", "India", "France", "Russia"], '/test'),
    CDM(Icons.settings_input_antenna, "Channels", ["BCC", "CNN", "Hindustan"],
        '/test'),
    CDM(Icons.trending_up, "Trending", [], '/test'),
    CDM(Icons.explore, "Explore", [], '/test'),
    CDM(Icons.settings, "Settings", [], '/test'),
  ];

  void expandOrShrinkDrawer() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
}

class CDM {
  IconData icon;
  String title;
  List<String> submenus;
  String route;

  CDM(this.icon, this.title, this.submenus, this.route);
}
