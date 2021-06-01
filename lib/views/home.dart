import 'package:flutter/material.dart';
import 'package:newsApp/Models/ArticleModel.dart';
import 'dart:convert';
import 'package:newsApp/Models/CategoryModel.dart';
import 'package:newsApp/components/blogTile.dart';
import 'package:newsApp/components/categoryTile.dart';
import 'package:newsApp/helper/data.dart';
import 'package:newsApp/helper/news.dart';
import 'package:http/http.dart' as http;
import 'package:newsApp/constants.dart' as cst;
import 'package:newsApp/newsbloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: deprecated_member_use
  List<CategoryModel> categories = new List<CategoryModel>();
  // ignore: deprecated_member_use
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = false;
  final newsbloc = NewsBloc();

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    newsbloc.eventSink.add(NewsActions.Fetch);
  }

  // getNews() async {
  //   News newsClass = News();
  //   await newsClass.getNews();
  //   articles = newsClass.news;
  //   setState(() {
  //     _loading = false;
  //   });
  // }

  // getCatNews(String cat) async {
  //   List<ArticleModel> news = [];
  //   String url =
  //       "http://newsapi.org/v2/top-headlines?country=in&category=$cat&apiKey=b62abbf777b64c56997280c44a97c0bd";

  //   var response = await http.get(url);

  //   var jsonData = jsonDecode(response.body);

  //   if (jsonData["status"] == "ok") {
  //     jsonData["articles"].forEach((element) {
  //       if (element["urlToImage"] != null && element["description"] != null) {
  //         ArticleModel articleModel = ArticleModel(
  //             title: element["title"],
  //             author: element["author"],
  //             content: element["content"],
  //             description: element["description"],
  //             url: element["url"],
  //             urlToImage: element["urlToImage"]);
  //         news.add(articleModel);
  //         setState(() {
  //           _loading = false;
  //           articles = news;
  //         });
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Daily',
              style: TextStyle(
                fontSize: 22 * cst.responsiveCofficient(context),
              ),
            ),
            Text(
              'News',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 22 * cst.responsiveCofficient(context),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              ///Categories
              // Container(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: 10 * cst.responsiveCofficient(context)),
              //   height: 80 * cst.responsiveCofficient(context),
              //   child: ListView.builder(
              //       shrinkWrap: true,
              //       scrollDirection: Axis.horizontal,
              //       itemCount: categories.length,
              //       itemBuilder: (context, index) {
              //         return InkWell(
              //           onTap: () {
              //             setState(() {
              //               _loading = true;
              //               getCatNews(categories[index].categoryName);
              //             });
              //           },
              //           child: CategoryTile(
              //             categoryName: categories[index].categoryName,
              //             imageUrl: categories[index].imageUrl,
              //           ),
              //         );
              //       }),
              // ),

              /// News Bolgs
              StreamBuilder<List<ArticleModel>>(
                  stream: newsbloc.newsStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data.length);
                      return ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return BlogTile(
                              url: snapshot.data[index].url,
                              desc: snapshot.data[index].description,
                              imageUrl: snapshot.data[index].urlToImage,
                              title: snapshot.data[index].title,
                            );
                          });
                    } else {
                      return Container();
                    }
                  })
            ],
          ),
        ),
      ),
    ));
  }
}
