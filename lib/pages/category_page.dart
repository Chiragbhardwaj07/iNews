import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inews/pages/choose_CategoryScreen.dart';
import 'package:inews/pages/news_detail.dart';
import 'package:inews/view_model/news_view_model.dart';
import 'package:intl/intl.dart';

class Category_page extends StatefulWidget {
  final String categ;
  Category_page({super.key, required this.categ});

  @override
  State<Category_page> createState() => _Category_pageState();
}

class _Category_pageState extends State<Category_page> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          widget.categ.toUpperCase(),
          style: GoogleFonts.poppins(color: Colors.black, letterSpacing: 2),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showOverlay(context);
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.grid_view_rounded,
                color: Colors.black,
              ))
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.99,
            width: width,
            child: FutureBuilder(
                future: newsViewModel.FetchCategoriesNewsapi(widget.categ),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: SpinKitFadingCircle(
                      color: Colors.black,
                    ));
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.data == null ||
                      snapshot.data!.articles == null) {
                    return Center(
                      child: Text('No data available'),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.articles!.length,
                          itemBuilder: (context, index) {
                            DateTime datetime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NewsDetailScreen(
                                          snapshot
                                              .data!.articles![index].urlToImage
                                              .toString(),
                                          snapshot.data!.articles![index].title
                                              .toString(),
                                          snapshot.data!.articles![index]
                                              .publishedAt
                                              .toString(),
                                          snapshot.data!.articles![index].author
                                              .toString(),
                                          snapshot.data!.articles![index]
                                              .description
                                              .toString(),
                                          snapshot
                                              .data!.articles![index].content
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
                                        height: height * 0.45,
                                        width: width * 0.9,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: CachedNetworkImage(
                                            imageUrl: snapshot.data!
                                                .articles![index].urlToImage
                                                .toString(),
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                SpinKitFadingCircle(
                                              color: Colors.black,
                                            ),
                                            errorWidget:
                                                (context, url, error) => Icon(
                                              Icons.error_rounded,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 5,
                                        child: Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Container(
                                            height: height * 0.22,
                                            width: width * 0.80,
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
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      snapshot
                                                          .data!
                                                          .articles![index]
                                                          .title
                                                          .toString(),
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: width * 0.85,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8),
                                                    child: Text(
                                                      snapshot
                                                          .data!
                                                          .articles![index]
                                                          .description
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.fade,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 11,
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 11,
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                      Text(
                                                        format.format(datetime),
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 11,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
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
                              ),
                            );
                          }),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
