import 'dart:convert';

import 'package:flutterquotes/model/quotes_data.dart';
import 'package:http/http.dart' as http;

var apiURL = "https://favqs.com/api/qotd";
Future _future;

Future<QuoteModel> getQoutes() async {
  final response = await http.get('$apiURL');
  return postFromJson(response.body);
}

QuoteModel postFromJson(String str) {
  return QuoteModel.fromJson(json.decode(str));
}