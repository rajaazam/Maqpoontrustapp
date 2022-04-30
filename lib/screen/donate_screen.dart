
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:maqpoon_trust/models/donate_now_data.dart';
import 'package:maqpoon_trust/providers/all_categories_provider.dart';
import 'package:maqpoon_trust/providers/donate_now_provider.dart';
import 'package:maqpoon_trust/utils/size_config.dart';
import 'package:maqpoon_trust/utils/styles.dart';
import 'package:maqpoon_trust/utils/utils.dart';
import 'package:maqpoon_trust/widgets/simple_blue_btn.dart';
import 'package:provider/provider.dart';


class DonateScreen extends StatefulWidget {
  const DonateScreen({Key? key}) : super(key: key);

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {

  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  String? errorMsg;

  String? categoryDropdownValue;
  String? selectedCategoryId;


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
        offset: const Offset(0, 3), // changes position of shadow
      ),
    ],
  );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {

      AllCategoriesProvider allCategoriesProvider = Provider.of<AllCategoriesProvider>(context, listen: false);
      allCategoriesProvider.getAllCategoriesResponse(context).then((value) {

        categoryDropdownValue = allCategoriesProvider.categoriesList!.first.name!;
        selectedCategoryId = allCategoriesProvider.categoriesList!.first.id!;

      });

    });


  }

  @override
  Widget build(BuildContext context) {

    final allCategoriesProvider = Provider.of<AllCategoriesProvider>(context);
    final donateNowProvider = Provider.of<DonateNowProvider>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return Stack(
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
                  _customAppbar(context),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      primary: true,
                      children: [

                        _donateImg(),

                        _donateForm(allCategoriesProvider, donateNowProvider),

                      ],
                    ),
                  ),
                ],
              ),

              Visibility(
                visible: donateNowProvider.loading || allCategoriesProvider.loading,
                child: Utils.loadingIndicator(),
              ),

            ],
          );
        },

      ),
    );
  }


  Widget _donateImg() {
    return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                    children:  [
                    
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.22,
                        child: Image.asset('assets/images/donate.png',fit: BoxFit.cover,),
                      ),
                    ],
                  );
  }

  Widget _customAppbar(BuildContext context) {
    return Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight * 0.16,
        decoration: const BoxDecoration(
          color: Color(0xFF0060AE),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.keyboard_arrow_left_outlined,
                  color: Colors.white),
            ),
            const Expanded(child: SizedBox()),
            Text(
              'Donate Request'.toUpperCase(),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const Expanded(child: SizedBox()),
            SizedBox(
              width: SizeConfig.screenWidth * 0.1,
            )
          ],
        ));
  }

  Widget _donateForm(AllCategoriesProvider allCategoriesProvider, DonateNowProvider donateNowProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: SizeConfig.screenWidth * 0.12),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //full name field
            TextFormField(
              controller: _fullNameController,
              keyboardType: TextInputType.text,
              style: kTextFieldStyle,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  errorMsg = 'Name field empty';
                  return errorMsg;
                } else if (value.length < 3) {
                  errorMsg = 'Name must be at least 3 characters long !';
                  return errorMsg;
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: '',
                labelText: 'Full Name',
                labelStyle: hintAndLabelStyle,
                hintStyle: hintAndLabelStyle,
              ),
            ),

            SizedBox(
              height: SizeConfig.screenHeight * 0.01,
            ),

            //phone number field
            TextFormField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9+-]')),
              ],
              style: kTextFieldStyle,
              validator: (value) {
                String patttern =
                    r'(^(?:[+][0-9])?[0-9]{10,12}$)';

                RegExp regExp = new RegExp(patttern);

                if (value == null || value.isEmpty) {
                  errorMsg = 'Phone number field empty';
                  return errorMsg;
                } else if (!regExp.hasMatch(value)) {
                  errorMsg = 'Please enter valid phone number';
                  return errorMsg;
                }

                return null;
              },
              decoration: InputDecoration(
                hintText: '',
                labelText: 'Phone Number',
                labelStyle: hintAndLabelStyle,
                hintStyle: hintAndLabelStyle,
              ),
            ),

            SizedBox(
              height: SizeConfig.screenHeight * 0.01,
            ),

            //email field
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: kTextFieldStyle,
              validator: (value) {

                bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(value.toString());

                if (value == null || value.isEmpty) {
                  errorMsg = 'Email field empty';
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

            //amount field
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9.]')),
              ],
              style: kTextFieldStyle,
              validator: (value) {
                return null;
              },
              decoration: InputDecoration(
                hintText: '',
                labelText: 'Amount',
                labelStyle: hintAndLabelStyle,
                hintStyle: hintAndLabelStyle,
              ),
            ),

            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),

            //category drop down
            DropdownButton<String>(
              value: categoryDropdownValue,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.normal),
              underline: Container(
                height: 1,
                color: Colors.black.withOpacity(0.3),
              ),
              onChanged: (String? newValue) {

                for(int i=0; i<allCategoriesProvider.categoriesList!.length; i++) {
                  if(allCategoriesProvider.categoriesList![i].name! == newValue) {
                    setState(() {
                      categoryDropdownValue = newValue!;
                      selectedCategoryId = allCategoriesProvider.categoriesList![i].id!;
                    });
                  }
                }

              },
              items: allCategoriesProvider.categoriesStrList!
                .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),


            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),

            //donate button
            Center(
              child: SimpleBlueBtn(
                text: 'donate',
                kSimpleBlueBtnDecoration:
                kSimpleBlueBtnDecoration,
                callback: () {

                  if(donateNowProvider.loading == false && allCategoriesProvider.loading == false) {
                    donateCallback();
                  }

                },
              ),
            ),

            SizedBox(
              height: SizeConfig.screenHeight * 0.1,
            ),
          ],
        ),
      ),
    );
  }

  donateCallback() {
    print('donate button clicked');

    if (_formKey.currentState!.validate()) {
      print('form validation ok');

      print('full name sending: ${_fullNameController.text}');
      print('phone no sending: ${_phoneNumberController.text}');
      print('email sending: ${_emailController.text}');
      print('amount sending: ${_amountController.text}');
      print('category sending: $categoryDropdownValue');

      DonateNowData donateNowData = DonateNowData(
        fullName: _fullNameController.text,
        phoneNo: _phoneNumberController.text,
        email: _emailController.text,
        amount: _amountController.text,
        category: selectedCategoryId,
      );

      final donateNowMdl = Provider.of<DonateNowProvider>(context, listen: false);
      donateNowMdl.getDonateNowResponse(context, donateNowData);

    } else {
      print(errorMsg);
      Utils.toast(errorMsg!);

      errorMsg = '';
    }

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _amountController.dispose();
  }

}
