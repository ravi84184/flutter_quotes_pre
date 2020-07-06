import 'package:flutter/material.dart';
import 'package:flutterquotes/pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = 40;
    double width = 40;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Image.asset(
              "assets/quote.png",
              height: height,
              width: width,
            ),
            SizedBox(
              height: 50,
            ),
            RichText(
              text: TextSpan(
                style: GoogleFonts.lato(
                  textStyle: TextStyle(fontSize: 50, color: Colors.black),
                ),
                children: [
                  TextSpan(text: "Get\n"),
                  TextSpan(
                      text: "Inspired",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (Route<dynamic> route) => false);
                },
                color: Colors.black,
                textColor: Colors.white,
                child: Text("Let's Go"),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
