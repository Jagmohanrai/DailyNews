import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newsApp/constants.dart' as cst;

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;
  CategoryTile({this.categoryName, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16 * cst.responsiveCofficient(context)),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius:
                BorderRadius.circular(6 * cst.responsiveCofficient(context)),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 120 * cst.responsiveCofficient(context),
              height: 70 * cst.responsiveCofficient(context),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 120 * cst.responsiveCofficient(context),
            height: 70 * cst.responsiveCofficient(context),
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(
                    6 * cst.responsiveCofficient(context))),
            child: Text(
              categoryName,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16 * cst.responsiveCofficient(context),
              ),
            ),
          )
        ],
      ),
    );
  }
}
