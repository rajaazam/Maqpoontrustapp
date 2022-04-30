import 'package:flutter/material.dart';

Color orangeColors = Color(0xffF5591F);
Color orangeLightColors = Color(0xffF2861E);

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       // padding: EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            HeaderContiner(
              "Sign Up Free",
            ),
            Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Column(
                   // mainAxisSize: MainAxisSize.max,
                    children: [
                      _textInput(hint: 'Full Name', icon: Icons.person),
                      _textInput(hint: 'Email', icon: Icons.email),
                      _textInput(hint: 'Phone No', icon: Icons.call),
                      _textInput(hint: 'Password', icon: Icons.vpn_key),
                      Expanded(
                          child: Center(
                        child: ButtomWidget(
                          btntxt: 'SIGNUP',
                          onclick: () {
                            Navigator.pop(context);
                          },
                        ),
                      )),
                      RichText(
                          text: TextSpan(children: [
                        const TextSpan(
                            text: " Already a  Number ?",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: 'SIGNIN',
                            style: TextStyle(color: orangeLightColors))
                      ]))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

// new cls
class HeaderContiner extends StatelessWidget {
  final text;
  HeaderContiner(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [orangeColors, orangeLightColors],
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
          ),
          borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(100))),
      child: Stack(
        children: [
          Positioned(
              bottom: 10,
              right: 20,
              child: Text(
                text,
                style: const TextStyle(
                  
                  fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.right,
              )),
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: 200,
              width: 200,
            ),
          )
        ],
      ),
    );
  }
}

// widget

Widget _textInput({conterller, hint, icon}) {
  return Container(
    margin: const EdgeInsetsDirectional.only(top: 10),
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(22),
        )),
    padding: const EdgeInsets.only(left: 10),
    child: TextField(
      controller: conterller,
      decoration: InputDecoration(
          prefixIcon: Icon(icon), hintText: hint,
           border: InputBorder.none),
    ),
  );
}

///2
class ButtomWidget extends StatelessWidget {
  String? btntxt;
  var onclick;
  ButtomWidget({this.btntxt, this.onclick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onclick,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [orangeColors, orangeLightColors],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            // colors: [orangeLightColors]
          ),
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        alignment: Alignment.center,
        child: Text(
          btntxt!,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
