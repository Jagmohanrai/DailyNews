import 'package:flutter/material.dart';
import 'package:newsApp/views/article_view.dart';
import 'package:newsApp/constants.dart' as cst;

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  BlogTile(
      {@required this.desc,
      @required this.imageUrl,
      @required this.title,
      @required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(
              url: url,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 30 * cst.responsiveCofficient(context)),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(
                    10 * cst.responsiveCofficient(context)),
                child: Image.network(imageUrl)),
            SizedBox(
              height: 10 * cst.responsiveCofficient(context),
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 20 * cst.responsiveCofficient(context),
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 8 * cst.responsiveCofficient(context),
            ),
            Text(
              desc,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16 * cst.responsiveCofficient(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
