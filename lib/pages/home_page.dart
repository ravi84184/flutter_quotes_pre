import 'package:flutter/material.dart';
import 'package:flutterquotes/api/future_api.dart';
import 'package:flutterquotes/model/quotes_data.dart';
import 'package:flutterquotes/widgets/quote_widget.dart';

import 'favourite_page.dart';
//import 'package:random_color/random_color.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getQoutes();
  }

//  RandomColor _randomColor = RandomColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Quote App",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavouritePage()));
            },
            child: Icon(
              Icons.favorite,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _future = getQoutes();
              });
            },
            child: Icon(
              Icons.refresh,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 10) {
            // Right Swipe
            setState(() {
              _future = getQoutes();
            });
          } else if (details.delta.dx < -10) {
            //Left Swipe
            setState(() {
              _future = getQoutes();
            });
          }
        },
        child: FutureBuilder<QuoteModel>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return ErrorWidget(snapshot.error);
                }
                return QuoteWidget(
                  id: snapshot.data.quote.id.toString(),
                  quote: snapshot.data.quote.body,
                  author: snapshot.data.quote.author,
                  bgColor: Colors.white,
                  tags: snapshot.data.quote.tags,
                );
              } else
                return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
