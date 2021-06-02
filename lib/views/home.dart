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
  final newsbloc = NewsBloc();

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    newsbloc.eventSink.add(NewsActions.Technology);
  }

  @override
  void dispose() {
    super.dispose();
    newsbloc.dispose();
  }

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
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 10 * cst.responsiveCofficient(context)),
                height: 80 * cst.responsiveCofficient(context),
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (categories[index].categoryName == "Technology") {
                            newsbloc.eventSink.add(NewsActions.Technology);
                          } else if (categories[index].categoryName ==
                              "Entertainment") {
                            newsbloc.eventSink.add(NewsActions.Entertainment);
                          } else if (categories[index].categoryName ==
                              "General") {
                            newsbloc.eventSink.add(NewsActions.General);
                          } else if (categories[index].categoryName ==
                              "Health") {
                            newsbloc.eventSink.add(NewsActions.Health);
                          } else if (categories[index].categoryName ==
                              "Science") {
                            newsbloc.eventSink.add(NewsActions.Science);
                          } else if (categories[index].categoryName ==
                              "Sports") {
                            newsbloc.eventSink.add(NewsActions.Sports);
                          } else if (categories[index].categoryName ==
                              "Business") {
                            newsbloc.eventSink.add(NewsActions.Business);
                          }
                        },
                        child: CategoryTile(
                          categoryName: categories[index].categoryName,
                          imageUrl: categories[index].imageUrl,
                        ),
                      );
                    }),
              ),

              /// News Bolgs
              StreamBuilder<List<ArticleModel>>(
                  stream: newsbloc.newsStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
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
