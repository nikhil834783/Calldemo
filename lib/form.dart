import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api.dart';

class CallForm extends StatefulWidget {
  @override
  _CallFormState createState() => _CallFormState();
}

class _CallFormState extends State<CallForm> {
  final _loginformKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
        centerTitle: true,
      ),
      body: Form(
        key: _loginformKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 10),
              child: Theme(
                data: Theme.of(context).copyWith(),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(),
                  autocorrect: true,
                  controller: emailController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter mobile number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.call),
                    labelText: 'Mobile Number',
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    if (_loginformKey.currentState.validate()) {
                      // print("validate");
                      call(emailController.text);
                    }
                    FocusScope.of(context).unfocus();
                  },
                  child: Text(
                    'Call'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  call(String number) async {
    Map data = {
      "to_mobile": "$number",
    };
    print(json.encode(data));
    var response = await http.post(
      Api.domain,
      body: json.encode(data),
      headers: {
        'content-type': 'application/json',
      },
    );
    print(response.body);
  }
}
