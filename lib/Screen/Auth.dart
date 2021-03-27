import 'package:Stock/Screen/otp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Stocks"),
          backgroundColor: const Color(0xFF4F6367),
        ),
        body: Container(
          color: const Color(0xFFEEF5DB),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                Container(
                  margin: EdgeInsets.only(top: 60),
                  child: Center(
                    child: Text('Phone Verification',
                        style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Phone Number',
                        prefixIcon: Icon(Icons.call),
                        prefix: Padding(
                          padding: EdgeInsets.all(4),
                          child: Text('+91'),
                        )),
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: _controller,
                  ),
                )
              ]),
              Container(
                margin: EdgeInsets.all(25),
                color: Colors.amber,
                width: double.infinity,
                child: TextButton(
                  child: Text('Verify',
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFFEEF5DB),
                      )),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF7A9E9F)),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OTPScreen(_controller.text)));
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
