import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inews/models/categories_new_model.dart';

import 'package:inews/models/news_channel_headlines_model.dart';

class NewsRepository {
  Future<NewsChannelHeadlinesModel> FetchNewsChannelapi() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=40e2c14e5d0c4e9588e70c2f989b09bf";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }

  Future<CategoriesNewsModel> FetchCategoriesNewsapi(String category) async {
    String url =
        "https://newsapi.org/v2/everything?q=${category}&apiKey=40e2c14e5d0c4e9588e70c2f989b09bf";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('Error');
  }
}
