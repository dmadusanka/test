import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:MOrder/views/DASHBOARD/mainDashboard.dart';
import 'package:http/http.dart' as http;
import 'package:MOrder/views/AUTH/supplier.dart';

class Profile extends StatefulWidget {
  final logoutAction;
  String name;
  String picture;

  Profile(this.logoutAction, this.name, this.picture);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Business> businessList = [];

  Business dropdownValue;
  String picture =
      "https://s.gravatar.com/avatar/66cb0e36c3955fcc2e0480a012436a4f?s=480&r=pg&d=https%3A%2F%2Fcdn.auth0.com%2Favatars%2Fdm.png";

  Future<void> getMyBusiness() async {
    //GZxv8drDMXLPdkc

    final List<Business> business = [];

    var headers = {
      'X-AUTH-TOKEN':
          'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IkJEU2pBYnRPYWhFMEQtSjFmTXZ6MyJ9.eyJodHRwczovL3d3dy5tc2FsZXMuY29tL2VtYWlsIjoiZHVsYW5qYW5zZWpAZ21haWwuY29tIiwiaHR0cHM6Ly93d3cubXNhbGVzLmNvbS9lbWFpbF92ZXJpZmllZCI6dHJ1ZSwiaXNzIjoiaHR0cHM6Ly9tc2FsZXMuYXUuYXV0aDAuY29tLyIsInN1YiI6ImF1dGgwfDYwNzAwYzgyMGE0YjU1MDA2OTJkYjgyOSIsImF1ZCI6WyJodHRwOi8vcHVibGljLmFwaS5tc2FsZXNhcHAuY29tIiwiaHR0cHM6Ly9tc2FsZXMuYXUuYXV0aDAuY29tL3VzZXJpbmZvIl0sImlhdCI6MTYyNzAxNDgyMSwiZXhwIjoxNjI3MTAxMjIxLCJhenAiOiJCN0ZObXV2ZVRjZG4zZWthcVQ3eU1PZUs0Szgwd1FpOCIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgZW1haWwifQ.RmlpNB1UlsKXAmZBzqd7yXHBxYnuw9EVTcBT_oNOPl1HnbV7Qya9v2BwYF0IvkTZk5YUphBqSf_3tTphgAQsD01XAzOgpez-QyefnDeigQTq06CLxZmjn7fWx284B9rbM1H7Gdujj0TEDCo8ET2c3acTN9u-_x-QXW4sVfeCuhLX7pDwWM7voQG_2Dsc6z1TYbVPydAbglEBxA_O7LF-_qyC1v0dPEeRuzyVel4VHe5Gs4MmhP6Vr3DDiL91ams9D5h8Eex7VTP7cDomQq9YAmUG0vy6vBFBCyDf2i0ykbnH3aL0I2VuCxPjAQ6vsANPIumqkLzW4Fmar9ThXpU5IA',
      'Content-Type': 'application/json',
      'Cookie': 'JSESSIONID=B2E911507B6EE95774EC0246B10F5F5F'
    };

    var response = await http.post(
        Uri.parse(
            'https://central.msalesapp.com/central/modelng/performoperation/Federal/GetMyBuyingBusinesses'),
        body: json.encode({}),
        headers: headers);

    if (response.statusCode == 200) {
      var allBusiness = json.decode(response.body)["objects"]['Businesses'];

      for (int i = 0; i < allBusiness.length; i++) {
        business.add(Business.fromJson(allBusiness[i]));
      }
    } else {
      print(response.reasonPhrase);
    }
    setState(() {
      businessList = business;
    });
  }

  @override
  void initState() {
    super.initState();
    getMyBusiness();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "Hi Welcome",
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2.0),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(picture ?? ''),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                DropdownButton<Business>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (Business newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      // return mainDashBoard(newValue.id.toString());
                      return Supplier(newValue.id);
                    }));
                  },
                  items: businessList
                      .map<DropdownMenuItem<Business>>((Business value) {
                    return DropdownMenuItem<Business>(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Business {
  final int id;
  final String name;
  final String registrationNumber;
  final String owner;
  final String creationTime;
  final String accountBalance;

  Business(
      {this.id,
      this.name,
      this.registrationNumber,
      this.owner,
      this.creationTime,
      this.accountBalance});

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
        id: json['id'],
        name: json['name'],
        registrationNumber: json['registrationNumber'],
        owner: json['owner'],
        creationTime: json['creationTime'],
        accountBalance: json['accountBalance']);
  }
}
