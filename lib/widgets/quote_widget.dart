import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:flutterquotes/database/quotes_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

class QuoteWidget extends StatefulWidget {
  var id = "";
  var quote = "";
  var author = "";
  var bgColor;
  var tags = [];

  QuoteWidget({this.id, this.bgColor, this.quote, this.author, this.tags});

  @override
  _QuoteWidgetState createState() => _QuoteWidgetState();
}

class _QuoteWidgetState extends State<QuoteWidget> {
  var isFavourite = false;

  @override
  void initState() {
    super.initState();
    checkIsFavourite();
  }

  checkIsFavourite() async {
    isFavourite = await FavouriteRepository.isFavourite(widget.id);
    setState(() {
      print(isFavourite);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.bgColor,
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          Image.asset(
            "assets/quote.png",
            height: 30,
            width: 30,
            color: Colors.black,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            widget.quote,
            style: GoogleFonts.lato(
              textStyle: TextStyle(color: Colors.black, fontSize: 28),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            widget.author,
            style: GoogleFonts.lato(
              textStyle:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Tags(
            itemCount: widget.tags.length,
            itemBuilder: (index) {
              return ItemTags(
                index: index,
                title: widget.tags[index],
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              );
            },
          ),
          Spacer(),
          Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if(isFavourite){
                      FavouriteRepository.removeFavourite(widget.id)
                          .then(
                            (value) {
                              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Remove from favourite")));
                          checkIsFavourite();
                        },
                      );
                    } else {
                      FavouriteRepository.addFavourite(widget.id, widget.author,
                          widget.tags.toString(), widget.quote)
                          .then(
                            (value) {
                              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Add to favourite")));
                          checkIsFavourite();
                        },
                      );
                    }

                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1, color: Colors.black)),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      isFavourite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.black,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Share.share("${widget.quote}\n\nBy:- ${widget.author}");
                  },
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
          Spacer(),
        ],
      ),
    );
  }
}
