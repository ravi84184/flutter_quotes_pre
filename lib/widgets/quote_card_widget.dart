import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:google_fonts/google_fonts.dart';

class QuoteCardWidget extends StatelessWidget {
  var id = "";
  var quote = "";
  var author = "";
  var bgColor;
  var tags = [];
  var onLikeClick;
  var onShareClick;

  QuoteCardWidget(
      {this.id,
      this.bgColor,
      this.quote,
      this.author,
      this.tags,
      this.onShareClick,
      this.onLikeClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quote ?? "",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Author:- " + author ?? "",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Tags(
                itemCount: tags.length ?? 0,
                itemBuilder: (index) {
                  return ItemTags(
                    index: index,
                    title: tags[index] ?? "",
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: onLikeClick,
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 1, color: Colors.black)),
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.favorite,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onShareClick,
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 1, color: Colors.black)),
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.share,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
