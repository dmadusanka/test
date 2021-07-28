import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class SignaturePad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sign to Confirm the order"),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent, width: 1),
                          ),
                          child: SfSignaturePad(
                            minimumStrokeWidth: 2,
                            maximumStrokeWidth: 5,
                            strokeColor: Colors.black,
                            backgroundColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text('Done'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
