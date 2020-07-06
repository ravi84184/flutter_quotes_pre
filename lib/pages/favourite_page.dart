import 'package:flutter/material.dart';
import 'package:flutterquotes/database/quotes_repository.dart';
import 'package:flutterquotes/model/quotes_data.dart';
import 'package:flutterquotes/widgets/quote_card_widget.dart';
import 'package:share/share.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  List<Quote> _list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadQuotes();
  }

  loadQuotes() async {
    _list = await FavouriteRepository.getAllFavouriteQuotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Favourite App",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _list.isEmpty
          ? Center(
              child: Text("No favourite Qoutes Found"),
            )
          : ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, index) {
                var model = _list[index];
                return QuoteCardWidget(
                  id: model.id.toString(),
                  quote: model.body,
                  author: model.author,
                  bgColor: Colors.white,
                  tags: model.tags,
                  onLikeClick: () {
                    FavouriteRepository.removeFavourite(model.id.toString())
                        .then(
                      (value) {
//                        _list.removeWhere((element) => element.id == model.id);
                        _list.removeAt(index);
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("Remove from favourite")));
                        setState(() {});
                      },
                    );
                  },
                  onShareClick: () {
                    Share.share("${model.body}\n\nBy:- ${model.author}");
                  },
                );
              }),
    );
  }
}
