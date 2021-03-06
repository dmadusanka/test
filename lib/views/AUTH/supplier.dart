import 'package:flutter/material.dart';
import 'package:MOrder/views/DASHBOARD/mainDashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Supplier extends StatefulWidget {
  final int businessId;

  Supplier(this.businessId);

  @override
  _SupplierState createState() => _SupplierState();
}

class _SupplierState extends State<Supplier> {
  Future<List<SupplierDetail>> getMySuppliers() async {
    final List<SupplierDetail> suppliers = [];

    var headers = {
      'X-AUTH-TOKEN':
          'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IkJEU2pBYnRPYWhFMEQtSjFmTXZ6MyJ9.eyJodHRwczovL3d3dy5tc2FsZXMuY29tL2VtYWlsIjoiZHVsYW5qYW5zZWpAZ21haWwuY29tIiwiaHR0cHM6Ly93d3cubXNhbGVzLmNvbS9lbWFpbF92ZXJpZmllZCI6dHJ1ZSwiaXNzIjoiaHR0cHM6Ly9tc2FsZXMuYXUuYXV0aDAuY29tLyIsInN1YiI6ImF1dGgwfDYwNzAwYzgyMGE0YjU1MDA2OTJkYjgyOSIsImF1ZCI6WyJodHRwOi8vcHVibGljLmFwaS5tc2FsZXNhcHAuY29tIiwiaHR0cHM6Ly9tc2FsZXMuYXUuYXV0aDAuY29tL3VzZXJpbmZvIl0sImlhdCI6MTYyNzQ4OTQxMSwiZXhwIjoxNjI3NTc1ODExLCJhenAiOiJCN0ZObXV2ZVRjZG4zZWthcVQ3eU1PZUs0Szgwd1FpOCIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgZW1haWwifQ.m_rdR7mTXAfP0w3VR6XW1YIFqKqsurTBuAG2YUfMi3q-lnGk_PbwEGpQTGkQwteXLlJ0x0eXZ0cp9vU-Kt5rDfCUrOmSAVzZFE5j9IGv-8QkBlDn_w3H-7Jwl3nSA7lldAAJN1eIZ2dv-2cHOFeYBKdLBye6WN27wez0XAaLWHIkCT3LCIdKPWgwFGfgwsHwLlK_fUK7ySl0Amd6FnPb26N7BigGt1iGlzaCZP9MpeFVx3JStVs6JISwKxULvRDgB5iZPrSKrn6pF2jBlSR5uP1Wm5PQfWgJYp-jFrddGaCORWvYy_sjjF1ybqcH7PmnBm7OetqiLXfFDDNJiV2FTw',
      'Content-Type': 'application/json',
      'Cookie': 'JSESSIONID=B2E911507B6EE95774EC0246B10F5F5F'
    };

    var response = await http.post(
        Uri.parse(
            'https://central.msalesapp.com/central/modelng/performoperation/Federal/GetMySuppliers'),
        body: json.encode({
          "parameters": {
            "BuyerBusinessId": widget.businessId,
          }
        }),
        headers: headers);
    if (response.statusCode == 200) {
      var allSuppliers = json.decode(response.body)["objects"]['Partnerships'];
      print(allSuppliers);

      for (int i = 0; i < allSuppliers.length; i++) {
        suppliers.add(SupplierDetail.fromJson(allSuppliers[i]));
      }
    } else {
      print(response.reasonPhrase);
    }
    return suppliers;
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Supplier"),
          backgroundColor: Colors.orange,
        ),
        body: FutureBuilder(
            future: getMySuppliers(),
            builder: (BuildContext context,
                AsyncSnapshot<List<SupplierDetail>> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  margin: EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
                  child: ListView.separated(
                    itemCount: snapshot.data.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemBuilder: (BuildContext context, int index) {
                      var baseUrl = snapshot.data[index].baseUrl;
                      var logoImage = snapshot.data[index].logoImage;
                      var logoURL = baseUrl + "/resources/getBlob/" + logoImage;

                      return ListTile(
                        //leading: Icon(Icons.account_circle, color: Colors.white,),
                        leading: Image.network(logoURL),
                        tileColor: Colors.amber,
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return MainDashBoard(snapshot.data[index].id);
                            //return Supplier();
                          }));
                        },
                        title: Text(
                          snapshot.data[index].name,
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                      );
                    },
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}

class SupplierDetail {
  final int id;
  final String name;
  final String baseUrl;
  final String logoImage;

  SupplierDetail({this.id, this.name, this.baseUrl, this.logoImage});

  factory SupplierDetail.fromJson(Map<String, dynamic> json) {
    return SupplierDetail(
        id: json['id'],
        name: json['tradingName'],
        baseUrl: json['seller']['baseUrl'],
        logoImage: json['logoImage']);
  }
}
