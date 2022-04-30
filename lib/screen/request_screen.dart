
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:maqpoon_trust/models/request_for_help_data.dart';
import 'package:maqpoon_trust/providers/all_categories_provider.dart';
import 'package:maqpoon_trust/providers/request_for_help_provider.dart';
import 'package:maqpoon_trust/utils/size_config.dart';
import 'package:maqpoon_trust/utils/styles.dart';
import 'package:maqpoon_trust/utils/utils.dart';
import 'package:maqpoon_trust/widgets/blue_btn.dart';
import 'package:provider/provider.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _fatherCnicController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _helpController = TextEditingController();
  final TextEditingController _careOfController = TextEditingController();

  String? errorMsg;

  //String categoryDropdownValue = 'Select Category';
  String? categoryDropdownValue;

  String? selectedCategoryId;

  BoxDecoration kBlueBtnDecoration = BoxDecoration(
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

      //Provider.of<AllCategoriesProvider>(context, listen: false).getAllCategoriesResponse(context);

      AllCategoriesProvider allCategoriesProvider = Provider.of<AllCategoriesProvider>(context, listen: false);
      allCategoriesProvider.getAllCategoriesResponse(context).then((value) {

        categoryDropdownValue = allCategoriesProvider.categoriesList!.first.name!;
        selectedCategoryId = allCategoriesProvider.categoriesList!.first.id!;

      });

    });


  }

  @override
  Widget build(BuildContext context) {
    final requestForHelpProvider = Provider.of<RequestForHelpProvider>(context);
    final allCategoriesProvider = Provider.of<AllCategoriesProvider>(context);

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
                  Container(
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
                            'Request'.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                          const Expanded(child: SizedBox()),
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.1,
                          )
                        ],
                      )),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      primary: true,
                      children: [
                        _logo(),
                        _requestForm(allCategoriesProvider, requestForHelpProvider),
                      ],
                    ),
                  ),
                ],
              ),

              Visibility(
                visible: requestForHelpProvider.loading || allCategoriesProvider.loading,
                child: Utils.loadingIndicator(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _logo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: SizeConfig.screenHeight * 0.25,
          child: Image.asset('assets/images/logo.png'),
        ),
      ],
    );
  }

  Widget _requestForm(AllCategoriesProvider allCategoriesProvider, RequestForHelpProvider requestForHelpProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 16.0, horizontal: SizeConfig.screenWidth * 0.12),
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

            //cnic field
            TextFormField(
              controller: _cnicController,
              keyboardType: TextInputType.number,
              style: kTextFieldStyle,
              validator: (value) {
                String patttern = r'(^(?:[0-9])?[0-9]{13}$)';
                RegExp regExp = RegExp(patttern);

                if (value == null || value.isEmpty) {
                  errorMsg = 'CNIC field empty';
                  return errorMsg;
                } else if (!regExp.hasMatch(value)) {
                  errorMsg = 'Please enter a valid 13 digits CNIC number';
                  return errorMsg;
                }

                return null;
              },
              decoration: InputDecoration(
                hintText: '',
                labelText: 'CNIC',
                labelStyle: hintAndLabelStyle,
                hintStyle: hintAndLabelStyle,
              ),
            ),

            SizedBox(
              height: SizeConfig.screenHeight * 0.01,
            ),

            //father cnic field
            TextFormField(
              controller: _fatherCnicController,
              keyboardType: TextInputType.number,
              style: kTextFieldStyle,
              validator: (value) {
                String patttern = r'(^(?:[0-9])?[0-9]{13}$)';
                RegExp regExp = RegExp(patttern);

                if (value == null || value.isEmpty) {
                  errorMsg = 'Father CNIC field empty';
                  return errorMsg;
                } else if (!regExp.hasMatch(value)) {
                  errorMsg =
                      'Please enter a valid 13 digits Father CNIC number';
                  return errorMsg;
                }

                return null;
              },
              decoration: InputDecoration(
                hintText: '',
                labelText: 'Father CNIC',
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
                FilteringTextInputFormatter.allow(RegExp(r'[0-9+-]')),
              ],
              style: kTextFieldStyle,
              validator: (value) {
                String patttern = r'(^(?:[+][0-9])?[0-9]{10,12}$)';

                RegExp regExp = RegExp(patttern);

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

            //help needed field
            TextFormField(
              controller: _helpController,
              keyboardType: TextInputType.text,
              style: kTextFieldStyle,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  errorMsg = 'Help needed field empty';
                  return errorMsg;
                }

                return null;
              },
              decoration: InputDecoration(
                hintText: '',
                labelText: 'Help needed',
                labelStyle: hintAndLabelStyle,
                hintStyle: hintAndLabelStyle,
              ),
            ),

            SizedBox(
              height: SizeConfig.screenHeight * 0.01,
            ),

            //care of / referred by field
            TextFormField(
              controller: _careOfController,
              keyboardType: TextInputType.text,
              style: kTextFieldStyle,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  errorMsg = 'Care of field empty';
                  return errorMsg;
                }

                return null;
              },
              decoration: InputDecoration(
                hintText: '',
                labelText: 'Care of / Referred by',
                labelStyle: hintAndLabelStyle,
                hintStyle: hintAndLabelStyle,
              ),
            ),

            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),

            //submit request button
            Center(
              child: BlueBtn(
                  kBlueBtnDecoration: kBlueBtnDecoration,
                  text: 'submit request',
                  callback: () {

                    if(allCategoriesProvider.loading == false && requestForHelpProvider.loading == false) {
                      requestCallback();
                    }

                  }),
            ),

            SizedBox(
              height: SizeConfig.screenHeight * 0.1,
            ),
          ],
        ),
      ),
    );
  }

  requestCallback() {

    if (_formKey.currentState!.validate()) {
      print('form validation ok');

      print('full name sending: ${_fullNameController.text}');
      print('cnic sending: ${_cnicController.text}');
      print(
          'father cnic sending: ${_fatherCnicController.text}');
      print('phone no sending: ${_phoneNumberController.text}');
      print('category sending: $categoryDropdownValue');
      print('help needed sending: ${_helpController.text}');
      print(
          'care of/ referred by sending: ${_careOfController.text}');

      RequestForHelpData requestForHelpData =
      RequestForHelpData(
        fullName: _fullNameController.text,
        cnic: _cnicController.text,
        fatherCNIC: _fatherCnicController.text,
        phoneNo: _phoneNumberController.text,
        //category: categoryDropdownValue,
        category: selectedCategoryId,
        helpNeeded: _helpController.text,
        careOf: _careOfController.text,
      );

      final requestForHelpMdl = Provider.of<RequestForHelpProvider>(context, listen: false);
      requestForHelpMdl.getRequestForHelpResponse(context, requestForHelpData);

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
    _cnicController.dispose();
    _fatherCnicController.dispose();
    _phoneNumberController.dispose();
    _helpController.dispose();
    _careOfController.dispose();
  }
}
