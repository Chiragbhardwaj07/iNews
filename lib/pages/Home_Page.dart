import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inews/pages/category_page.dart';
import 'package:inews/pages/choose_CategoryScreen.dart';
import 'package:inews/pages/news_detail.dart';
import 'package:inews/pages/search.dart';
import 'package:inews/pages/settings.dart';
import 'package:inews/utils/drawer.dart';
import 'package:inews/view_model/news_view_model.dart';
import 'package:intl/intl.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> with TickerProviderStateMixin {
  NewsViewModel newsViewModel = NewsViewModel();
  String location = 'us';

  final format = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 4, vsync: this);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      drawer: ComplexDrawer(
        onButtonPressedin: () {
          // Change the value of the string when the button is pressed
          setState(() {
            location = "in";
          });
        },
        onButtonPressedus: () {
          // Change the value of the string when the button is pressed
          setState(() {
            location = "us";
          });
        },
        onButtonPressedfr: () {
          // Change the value of the string when the button is pressed
          setState(() {
            location = "fr";
          });
        },
        onButtonPressedch: () {
          // Change the value of the string when the button is pressed
          setState(() {
            location = "ru";
          });
        },
      ),
      appBar: AppBar(
        iconTheme: IconTheme.of(context).copyWith(
          color: Colors.white,
        ),
        backgroundColor: Colors.black45,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Search(),
                    ));
              },
              icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                showOverlay(context);
              },
              icon: FaIcon(
                Icons.grid_view_rounded,
                color: Colors.white,
              )),
        ],
        elevation: 0,
        title: Text(
          'iNews',
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.30,
            width: width,
            child: FutureBuilder(
                future: newsViewModel.FetchNewsChannelapi(location),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: SpinKitFadingCircle(
                      color: Colors.white,
                    ));
                  } else if (snapshot.hasError) {
                    print('Error: ${snapshot.error}');
                    return Center(
                      child: Text(
                        'Error loading data',
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    );
                  } else if (snapshot.data == null ||
                      snapshot.data!.articles == null) {
                    return Center(
                      child: Text('No data available'),
                    );
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime datetime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsDetailScreen(
                                      snapshot.data!.articles![index].urlToImage
                                          .toString(),
                                      snapshot.data!.articles![index].title
                                          .toString(),
                                      snapshot
                                          .data!.articles![index].publishedAt
                                          .toString(),
                                      snapshot.data!.articles![index].author
                                          .toString(),
                                      snapshot
                                          .data!.articles![index].description
                                          .toString(),
                                      snapshot.data!.articles![index].content
                                          .toString(),
                                      snapshot.data!.articles![index].source
                                          .toString(),
                                    ),
                                  ));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.04),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: height * 0.6,
                                    width: width * 0.9,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            SpinKitFadingCircle(
                                          color: Colors.white,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                          Icons.error_rounded,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 7.5,
                                    child: Card(
                                      color: Colors.grey[800],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Container(
                                        height: height * 0.22,
                                        color: Colors.transparent,
                                        alignment: Alignment.bottomCenter,
                                        child: Center(
                                            child: Column(
                                          children: [
                                            Container(
                                              color: Colors.transparent,
                                              width: width * 0.85,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  snapshot.data!
                                                      .articles![index].title
                                                      .toString(),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 17,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.85,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: Text(
                                                  snapshot
                                                      .data!
                                                      .articles![index]
                                                      .description
                                                      .toString(),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.fade,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 11,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.02,
                                            ),
                                            Container(
                                              width: width * 0.85,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 11,
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Text(
                                                    format.format(datetime),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 11,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(width: 0.01, color: Colors.black)),
            elevation: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                  indicator: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(12)),
                      color: Colors.black),
                  controller: tabController,
                  labelPadding: EdgeInsets.symmetric(horizontal: 10),
                  tabs: [
                    Tab(
                      child: Text(
                        "Science",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text("Environment",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 10)),
                    ),
                    Tab(
                      child: Text("Animals",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 10)),
                    ),
                    Tab(
                      child: Text("War",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 12)),
                    ),
                  ]),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: BouncingScrollPhysics(),
              children: [
                // Contents for the "Science" tab,
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recommended',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 11.54,
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Category_page(categ: 'Biology'),
                                    ));
                              },
                              child: Text(
                                'Show All',
                                style: GoogleFonts.poppins(
                                  color: Colors.blue[800],
                                  fontSize: 7.69,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // height: height * 0.35,
                        child: FutureBuilder(
                            future:
                                newsViewModel.FetchCategoriesNewsapi('biology'),
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SpinKitFadingCircle(
                                  color: Colors.white,
                                );
                              } else if (snapshot.hasError) {
                                print('Error: ${snapshot.error}');
                                return Center(
                                  child: Text(
                                    'Error loading data',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ),
                                );
                              } else if (snapshot.data == null ||
                                  snapshot.data!.articles == null) {
                                return Center(
                                  child: Text('No data available'),
                                );
                              } else {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      DateTime datetime = DateTime.parse(
                                          snapshot.data!.articles![index]
                                              .publishedAt
                                              .toString());
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            12, 0, 12, 5),
                                        child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        NewsDetailScreen(
                                                      snapshot
                                                          .data!
                                                          .articles![index]
                                                          .urlToImage
                                                          .toString(),
                                                      snapshot
                                                          .data!
                                                          .articles![index]
                                                          .title
                                                          .toString(),
                                                      snapshot
                                                          .data!
                                                          .articles![index]
                                                          .publishedAt
                                                          .toString(),
                                                      snapshot
                                                          .data!
                                                          .articles![index]
                                                          .author
                                                          .toString(),
                                                      snapshot
                                                          .data!
                                                          .articles![index]
                                                          .description
                                                          .toString(),
                                                      snapshot
                                                          .data!
                                                          .articles![index]
                                                          .content
                                                          .toString(),
                                                      snapshot
                                                          .data!
                                                          .articles![index]
                                                          .source
                                                          .toString(),
                                                    ),
                                                  ));
                                            },
                                            child: Expanded(
                                                child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Container(
                                                color: Colors.grey[800],
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                height: height * 0.6,
                                                width: width * 0.50,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        child:
                                                            CachedNetworkImage(
                                                          height: height * 0.1,
                                                          width: width * 0.45,
                                                          imageUrl: snapshot
                                                              .data!
                                                              .articles![index]
                                                              .urlToImage
                                                              .toString(),
                                                          fit: BoxFit.cover,
                                                          placeholder: (context,
                                                                  url) =>
                                                              SpinKitFadingCircle(
                                                            color: Colors.white,
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(
                                                            Icons.error_rounded,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: Text(
                                                          snapshot
                                                              .data!
                                                              .articles![index]
                                                              .title
                                                              .toString(),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .line_style_rounded,
                                                            color: Colors.blue,
                                                            size: 11,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            'Read More',
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color: Colors
                                                                        .blue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w100,
                                                                    fontSize:
                                                                        11),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ))),
                                      );
                                    });
                              }
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recommended',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 11.54,
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Category_page(categ: 'science'),
                                    ));
                              },
                              child: Text(
                                'Show All',
                                style: GoogleFonts.poppins(
                                  color: Colors.blue[800],
                                  fontSize: 7.69,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // height: height * 0.35,
                        child: FutureBuilder(
                            future:
                                newsViewModel.FetchCategoriesNewsapi('science'),
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SpinKitFadingCircle(
                                  color: Colors.white,
                                );
                              } else if (snapshot.hasError) {
                                print('Error: ${snapshot.error}');
                                return Center(
                                  child: Text(
                                    'Error loading data',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ),
                                );
                              } else if (snapshot.data == null ||
                                  snapshot.data!.articles == null) {
                                return Center(
                                  child: Text('No data available'),
                                );
                              } else {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: 20,
                                    itemBuilder: (context, index) {
                                      DateTime datetime = DateTime.parse(
                                          snapshot.data!.articles![index]
                                              .publishedAt
                                              .toString());
                                      return Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewsDetailScreen(
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .urlToImage
                                                        .toString(),
                                                    snapshot.data!
                                                        .articles![index].title
                                                        .toString(),
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .publishedAt
                                                        .toString(),
                                                    snapshot.data!
                                                        .articles![index].author
                                                        .toString(),
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .description
                                                        .toString(),
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .content
                                                        .toString(),
                                                    snapshot.data!
                                                        .articles![index].source
                                                        .toString(),
                                                  ),
                                                ));
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Container(
                                              color: Colors.grey[800],
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        child:
                                                            CachedNetworkImage(
                                                          height: height * 0.18,
                                                          width: width * 0.3,
                                                          imageUrl: snapshot
                                                              .data!
                                                              .articles![index]
                                                              .urlToImage
                                                              .toString(),
                                                          fit: BoxFit.cover,
                                                          placeholder: (context,
                                                                  url) =>
                                                              SpinKitFadingCircle(
                                                            color: Colors.white,
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(
                                                            Icons.error_rounded,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    height: height * 0.2,
                                                    width: width * 0.8,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          child: Text(
                                                            snapshot
                                                                .data!
                                                                .articles![
                                                                    index]
                                                                .title
                                                                .toString(),
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8),
                                                          child: Text(
                                                            snapshot
                                                                .data!
                                                                .articles![
                                                                    index]
                                                                .description
                                                                .toString(),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        11,
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .articles![
                                                                      index]
                                                                  .source!
                                                                  .name
                                                                  .toString(),
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .blue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                            Text(
                                                              format.format(
                                                                  datetime),
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }
                            }),
                      ),
                    ),
                  ],
                ),

                // Contents for the "Environment" tab
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recommended',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 11.54,
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Category_page(categ: 'environment'),
                                    ));
                              },
                              child: Text(
                                'Show All',
                                style: GoogleFonts.poppins(
                                  color: Colors.blue[800],
                                  fontSize: 7.69,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // height: height * 0.35,
                        child: FutureBuilder(
                            future: newsViewModel.FetchCategoriesNewsapi(
                                'environment'),
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SpinKitFadingCircle(
                                  color: Colors.white,
                                );
                              } else if (snapshot.hasError) {
                                print('Error: ${snapshot.error}');
                                return Center(
                                  child: Text(
                                    'Error loading data',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ),
                                );
                              } else if (snapshot.data == null ||
                                  snapshot.data!.articles == null) {
                                return Center(
                                  child: Text('No data available'),
                                );
                              } else {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: 20,
                                    itemBuilder: (context, index) {
                                      DateTime datetime = DateTime.parse(
                                          snapshot.data!.articles![index]
                                              .publishedAt
                                              .toString());
                                      return Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewsDetailScreen(
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .urlToImage
                                                        .toString(),
                                                    snapshot.data!
                                                        .articles![index].title
                                                        .toString(),
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .publishedAt
                                                        .toString(),
                                                    snapshot.data!
                                                        .articles![index].author
                                                        .toString(),
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .description
                                                        .toString(),
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .content
                                                        .toString(),
                                                    snapshot.data!
                                                        .articles![index].source
                                                        .toString(),
                                                  ),
                                                ));
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Container(
                                              color: Colors.grey[800],
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        child:
                                                            CachedNetworkImage(
                                                          height: height * 0.18,
                                                          width: width * 0.3,
                                                          imageUrl: snapshot
                                                              .data!
                                                              .articles![index]
                                                              .urlToImage
                                                              .toString(),
                                                          fit: BoxFit.cover,
                                                          placeholder: (context,
                                                                  url) =>
                                                              SpinKitFadingCircle(
                                                            color: Colors.white,
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(
                                                            Icons.error_rounded,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    height: height * 0.2,
                                                    width: width * 0.8,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          child: Text(
                                                            snapshot
                                                                .data!
                                                                .articles![
                                                                    index]
                                                                .title
                                                                .toString(),
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8),
                                                          child: Text(
                                                            snapshot
                                                                .data!
                                                                .articles![
                                                                    index]
                                                                .description
                                                                .toString(),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        11,
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .articles![
                                                                      index]
                                                                  .source!
                                                                  .name
                                                                  .toString(),
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .blue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                            Text(
                                                              format.format(
                                                                  datetime),
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }
                            }),
                      ),
                    ),
                  ],
                ),

                //Contents for the "Animals"
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recommended',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 11.54,
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Category_page(categ: 'animals'),
                                    ));
                              },
                              child: Text(
                                'Show All',
                                style: GoogleFonts.poppins(
                                  color: Colors.blue[800],
                                  fontSize: 7.69,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // height: height * 0.35,
                        child: FutureBuilder(
                            future:
                                newsViewModel.FetchCategoriesNewsapi('animals'),
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SpinKitFadingCircle(
                                  color: Colors.white,
                                );
                              } else if (snapshot.hasError) {
                                print('Error: ${snapshot.error}');
                                return Center(
                                  child: Text(
                                    'Error loading data',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ),
                                );
                              } else if (snapshot.data == null ||
                                  snapshot.data!.articles == null) {
                                return Center(
                                  child: Text('No data available'),
                                );
                              } else {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: 20,
                                    itemBuilder: (context, index) {
                                      DateTime datetime = DateTime.parse(
                                          snapshot.data!.articles![index]
                                              .publishedAt
                                              .toString());
                                      return Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewsDetailScreen(
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .urlToImage
                                                        .toString(),
                                                    snapshot.data!
                                                        .articles![index].title
                                                        .toString(),
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .publishedAt
                                                        .toString(),
                                                    snapshot.data!
                                                        .articles![index].author
                                                        .toString(),
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .description
                                                        .toString(),
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .content
                                                        .toString(),
                                                    snapshot.data!
                                                        .articles![index].source
                                                        .toString(),
                                                  ),
                                                ));
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Container(
                                              color: Colors.grey[800],
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        child:
                                                            CachedNetworkImage(
                                                          height: height * 0.18,
                                                          width: width * 0.3,
                                                          imageUrl: snapshot
                                                              .data!
                                                              .articles![index]
                                                              .urlToImage
                                                              .toString(),
                                                          fit: BoxFit.cover,
                                                          placeholder: (context,
                                                                  url) =>
                                                              SpinKitFadingCircle(
                                                            color: Colors.white,
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(
                                                            Icons.error_rounded,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    height: height * 0.2,
                                                    width: width * 0.8,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          child: Text(
                                                            snapshot
                                                                .data!
                                                                .articles![
                                                                    index]
                                                                .title
                                                                .toString(),
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8),
                                                          child: Text(
                                                            snapshot
                                                                .data!
                                                                .articles![
                                                                    index]
                                                                .description
                                                                .toString(),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        11,
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .articles![
                                                                      index]
                                                                  .source!
                                                                  .name
                                                                  .toString(),
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .blue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                            Text(
                                                              format.format(
                                                                  datetime),
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }
                            }),
                      ),
                    ),
                  ],
                ),
                // Contents for the "war" tab
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recommended',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 11.54,
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Category_page(categ: 'war'),
                                    ));
                              },
                              child: Text(
                                'Show All',
                                style: GoogleFonts.poppins(
                                  color: Colors.blue[800],
                                  fontSize: 7.69,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // height: height * 0.35,
                        child: FutureBuilder(
                            future: newsViewModel.FetchCategoriesNewsapi('war'),
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SpinKitFadingCircle(
                                  color: Colors.white,
                                );
                              } else if (snapshot.hasError) {
                                print('Error: ${snapshot.error}');
                                return Center(
                                  child: Text(
                                    'Error loading data',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ),
                                );
                              } else if (snapshot.data == null ||
                                  snapshot.data!.articles == null) {
                                return Center(
                                  child: Text('No data available'),
                                );
                              } else {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: 20,
                                    itemBuilder: (context, index) {
                                      DateTime datetime = DateTime.parse(
                                          snapshot.data!.articles![index]
                                              .publishedAt
                                              .toString());
                                      return Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewsDetailScreen(
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .urlToImage
                                                        .toString(),
                                                    snapshot.data!
                                                        .articles![index].title
                                                        .toString(),
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .publishedAt
                                                        .toString(),
                                                    snapshot.data!
                                                        .articles![index].author
                                                        .toString(),
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .description
                                                        .toString(),
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .content
                                                        .toString(),
                                                    snapshot.data!
                                                        .articles![index].source
                                                        .toString(),
                                                  ),
                                                ));
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Container(
                                              color: Colors.grey[800],
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        child:
                                                            CachedNetworkImage(
                                                          height: height * 0.18,
                                                          width: width * 0.3,
                                                          imageUrl: snapshot
                                                              .data!
                                                              .articles![index]
                                                              .urlToImage
                                                              .toString(),
                                                          fit: BoxFit.cover,
                                                          placeholder: (context,
                                                                  url) =>
                                                              SpinKitFadingCircle(
                                                            color: Colors.white,
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(
                                                            Icons.error_rounded,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    height: height * 0.2,
                                                    width: width * 0.8,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          child: Text(
                                                            snapshot
                                                                .data!
                                                                .articles![
                                                                    index]
                                                                .title
                                                                .toString(),
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8),
                                                          child: Text(
                                                            snapshot
                                                                .data!
                                                                .articles![
                                                                    index]
                                                                .description
                                                                .toString(),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        11,
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.015,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .articles![
                                                                      index]
                                                                  .source!
                                                                  .name
                                                                  .toString(),
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .blue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                            Text(
                                                              format.format(
                                                                  datetime),
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }
                            }),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
