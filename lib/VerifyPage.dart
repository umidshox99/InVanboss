import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class VerifyPage extends StatefulWidget {
  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  var isLoading = false;
  var controller = TextEditingController();

  @override
  void deactivate() {
    controller.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: Center(
            child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              end: Alignment.topRight,
              begin: Alignment.bottomLeft,
              colors: [Colors.blue, Colors.red])),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Добро пожаловать !',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: controller,
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              child: !isLoading
                  ? RaisedButton(
                      onPressed: () {
                        _makeVerifyRequest(args, controller.text);
                      },
                      textColor: Colors.white,
                      color: Colors.grey,
                      padding: const EdgeInsets.all(8.0),
                      child: new Text(
                        "Send",
                      ))
                  : CircularProgressIndicator(),
            )
          ],
        ),
      ),
    )));
  }

  _makeVerifyRequest(String text, String code) async {
    setState(() {
      isLoading = true;
    });
    String url = 'http://purch.invan.uz/user/login/verify';
    Map<String, String> headers = {
      "Accept-Version": "1.0.0",
      "Content-type": "application/json",
      "Accept-User": "boss"
    };
    String json = '{"phone_number": "${text}","sms_code": "${code}"}';
    // make POST request
    try {
      Response response = await post(url, headers: headers, body: json);
      print(response.body);
      print(response.headers);
      print(json);
      setState(() {
        isLoading = false;
      });
      Navigator.pushNamed(context, '/home', arguments: text);
    } catch (e) {}
  }
}
