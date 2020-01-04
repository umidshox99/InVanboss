import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() => runApp(MaterialApp(
      home: RegPage(),
      debugShowCheckedModeBanner: false,
    ));

class RegPage extends StatefulWidget {
  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  final number = TextEditingController();
  var ccp = "+998";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              end: Alignment.topRight,
              begin: Alignment.bottomLeft,
              colors: [Colors.blue, Colors.red])),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 125, 0, 0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.account_circle,
                size: 100,
                color: Colors.white,
              ),
              Text(
                'Добро пожаловать !',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Пожалуйста введите свой номер',
                style: TextStyle(fontSize: 12.0, color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 20, 40, 10),
                child: Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(
                            5.0) //                 <--- border radius here
                        ),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CountryCodePicker(
                            textStyle:
                                TextStyle(fontSize: 15, color: Colors.black),
                            onChanged: (value) {
                              this.ccp = "+" + value.code;
                            },
                            initialSelection: 'UZ',
                            favorite: ['+998', 'UZ'],
                            showCountryOnly: false,
                          ),
                        ),
                        flex: 3,
                      ),
                      Expanded(
                        flex: 4,
                        child: TextField(
                            controller: number,
                            decoration: InputDecoration(
                                labelText: 'Enter your username'),
                            style: TextStyle(fontSize: 15),
                            maxLength: 9,
                            keyboardType: TextInputType.number),
                      ),
                    ],
                  ),
                ),
              ),
              RaisedButton(
                  onPressed: () {
                    _makePostRequest(ccp + number.text);
                  },
                  textColor: Colors.white,
                  color: Colors.grey,
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "Send",
                  )),
            ],
          ),
        ),
      ),
    )));
  }

  _makePostRequest(String text) async {
    String url = 'http://purch.invan.uz/user/login';
    Map<String, String> headers = {
      "Accept-Version": "1.0.0",
      "Content-type": "application/json",
      "Accept-User": "boss"
    };
    String json = '{"phone_number": "${text}"}';
    // make POST request
    try {
      Response response = await post(url, headers: headers, body: json);
      print(response.body);
      print(response.headers);
      print(json);
    } catch (e) {}
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    number.dispose();
    super.dispose();
  }
}
