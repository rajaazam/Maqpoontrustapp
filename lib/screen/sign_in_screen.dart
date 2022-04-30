
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:maqpoon_trust/providers/sign_in_provider.dart';
import 'package:maqpoon_trust/utils/size_config.dart';
import 'package:maqpoon_trust/utils/styles.dart';
import 'package:maqpoon_trust/utils/utils.dart';
import 'package:maqpoon_trust/widgets/simple_blue_btn.dart';
import 'package:provider/provider.dart';


class SignInScreen extends StatefulWidget {

  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool passwordObscure = true;

  String? errorMsg;

  Decoration kSimpleBlueBtnDecoration = BoxDecoration(

    gradient: const LinearGradient(
      colors: [
        Color(0xFF0073D1),
        Color(0xFF005398),
      ],
      stops: [0.0, 1.0],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      tileMode: TileMode.clamp,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(20.0),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 7,
        offset: const Offset(0, 3),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {

    final signInnMdl = Provider.of<SignInProvider>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,

      body: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return Stack(
            //alignment: AlignmentDirectional.bottomCenter,
            alignment: AlignmentDirectional.center,
            children: [

              //white bg behind background image
              Container(
                color: Colors.white,
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
              ),

              //bg image
              Positioned(
                left: -60,
                bottom: -40,
                child: Visibility(
                  visible: !isKeyboardVisible,
                  child: Image.asset(
                    'assets/images/bg1.png',
                    width: SizeConfig.screenWidth * 1.2,
                  ),
                ),
              ),

              //main content
              Column(
                children: [

                  _header(context),

                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),

                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      primary: true,
                      children: [

                        //fields
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0, 
                          horizontal: SizeConfig.screenWidth * 0.12),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                //email field
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.text,
                                  style: kTextFieldStyle,
                                  validator: (value) {

                                    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(value.toString());

                                    if (value == null || value.isEmpty) {
                                      errorMsg = 'email field empty';
                                      return errorMsg;
                                    } else if (!emailValid) {
                                      errorMsg = 'Invalid Email !';
                                      return errorMsg;
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: '',
                                    labelText: 'Email',
                                    labelStyle: hintAndLabelStyle,
                                    hintStyle: hintAndLabelStyle,
                                  ),
                                ),

                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.01,
                                ),

                                //password field
                                TextFormField(
                                  controller: _passwordController,
                                  keyboardType: TextInputType.text,
                                  obscureText: passwordObscure,
                                  style: kTextFieldStyle,
                                  validator: (value) {

                                    if (value == null || value.isEmpty) {

                                      errorMsg = 'Password field empty';
                                      return errorMsg;
                                    }
                                    else if(_passwordController.text.isNotEmpty && value != _passwordController.text) {

                                      errorMsg = 'Password didn\'t match !';
                                      return errorMsg;
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {

                                  },
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {

                                        setState(() {
                                          passwordObscure = !passwordObscure;
                                        });

                                      },
                                      icon: Icon(passwordObscure ? Icons.visibility_off : Icons.visibility, color: Colors.blue,),
                                    ),
                                    hintText: '••••••',
                                    labelText: 'Password',
                                    labelStyle: hintAndLabelStyle,
                                    hintStyle: hintAndLabelStyle,
                                  ),
                                ),


                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.04,
                                ),

                                //sign in button
                                Center(
                                  child: SimpleBlueBtn(text: 'sign in', kSimpleBlueBtnDecoration: kSimpleBlueBtnDecoration, callback: () {

                                    if(signInnMdl.loading == false) {
                                      signInCallback();
                                    }

                                  },),

                                ),

                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.1,
                                ),
                               

                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),


                ],
              ),


              Visibility(
                visible: signInnMdl.loading,
                child: Utils.loadingIndicator(),
              ),


            ],
          );
        },
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 0.32,
                decoration: const BoxDecoration(
                  color: Color(0xFF0060AE),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                ),
                child: Column(
                  children: [

                    SizedBox(height: SizeConfig.screenHeight * 0.05,),

                    //back button row
                    Row(
                      children: [

                        IconButton(
                          onPressed: () {

                            Navigator.pop(context);

                          },
                          icon: Icon(Icons.keyboard_arrow_left_outlined, color: Colors.white),
                        ),


                      ],
                    ),

                    SizedBox(height: SizeConfig.screenHeight * 0.05,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        children: [

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text('Sign In'.toUpperCase(), style: const TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold,),),

                                Text('Proceed with your', style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.8), fontWeight: FontWeight.w100,),),

                              ],
                            ),
                          ),

                          Image.asset('assets/images/just_logo.png', scale: 2,),

                        ],
                      ),
                    ),


                  ],
                ),
            );
  }

  signInCallback() {
    if (_formKey.currentState!.validate()) {
      print('form validation ok');

      final signInMdl = Provider.of<SignInProvider>(context, listen: false);
      signInMdl.getSignInResponse(context, _emailController.text, _passwordController.text);

    }
    else {

      print(errorMsg);
      errorMsg = '';

    }
  }


  @override
  void dispose() {
   
    super.dispose();
    
    _emailController.dispose();
    _passwordController.dispose();
    
  }
  
}

