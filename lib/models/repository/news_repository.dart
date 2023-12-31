import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inews/models/categories_new_model.dart';

import 'package:inews/models/news_channel_headlines_model.dart';

class NewsRepository {
  Future<NewsChannelHeadlinesModel> FetchNewsChannelapi(String location) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=${location}&apiKey=a2336f3f1da8428caeb7bad4fb3e1bc7";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }

  Future<CategoriesNewsModel> FetchCategoriesNewsapi(String category) async {
    String url =
        "https://newsapi.org/v2/everything?q=${category}&apiKey=a2336f3f1da8428caeb7bad4fb3e1bc7";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('Error');
  }
}
