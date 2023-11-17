import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inews/utils/shareSheet.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsDetailScreen extends StatefulWidget {
  String newsImage;
  String newsTitle;
  String newsDate;
  String newsAuthor;
  String newsDesc;
  String newsContent;
  String newsSource;
  NewsDetailScreen(this.newsImage, this.newsTitle, this.newsDate,
      this.newsAuthor, this.newsDesc, this.newsContent, this.newsSource);

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

// Existing imports...

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final format = DateFormat('MMMM dd,yyyy');

  @override
  void initState() {
    super.initState();
    print(widget.newsDesc);
  }

  @override
  Widget build(BuildContext context) {
    double Kwidth = MediaQuery.of(context).size.width;
    double Kheight = MediaQuery.of(context).size.height;
    DateTime dateTime = DateTime.parse(widget.newsDate);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    showShareBottomSheet(context);
                  },
                  icon: Icon(Icons.share))
            ],
            expandedHeight: Kheight * 0.45,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: "${widget.newsImage}",
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.newsTitle}',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: Kheight * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                child: Text(
                                  '${widget.newsSource}',
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              '${format.format(dateTime)}',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Kheight * 0.03,
                        ),
                        Text(
                          '${widget.newsContent}',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines:
                              null, // Set maxLines to null for unlimited lines
                        ),
                        SizedBox(
                          height: Kheight * 0.03,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
