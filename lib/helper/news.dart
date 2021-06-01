import 'dart:convert';

import '../Models/ArticleModel.dart';
import 'package:http/http.dart' as http;

class News {
  String category;
  News({this.category});

  Future<void> getNews() async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&category=Technology&apiKey=b62abbf777b64c56997280c44a97c0bd";
    List<ArticleModel> news = [];
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element["title"],
              author: element["author"],
              content: element["content"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"]);
          news.add(articleModel);
        }
      });
    }
  }
}
