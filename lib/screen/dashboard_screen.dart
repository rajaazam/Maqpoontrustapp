

import 'package:flutter/material.dart';
import 'package:maqpoon_trust/models/record_model.dart';
import 'package:maqpoon_trust/providers/request_records_provider.dart';
import 'package:maqpoon_trust/utils/size_config.dart';
import 'package:maqpoon_trust/utils/utils.dart';
import 'package:maqpoon_trust/widgets/record_item.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  final TextEditingController _searchController = TextEditingController();

  List<RecordModel> _recordsList = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {

      RequestRecordsProvider requestRecordsProvider = Provider.of<RequestRecordsProvider>(context, listen: false);
      requestRecordsProvider.getRequestRecordsResponse(context).then((value) {

      });

    });

    _getRecordsList();
  }

  @override
  Widget build(BuildContext context) {

    final requestRecordsMdl = Provider.of<RequestRecordsProvider>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
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
            child: Image.asset(
              'assets/images/bg1.png',
              width: SizeConfig.screenWidth * 1.2,
            ),
          ),

          //main content
          Column(
            children: [
              Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 0.37,
                decoration: const BoxDecoration(
                  color: Color(0xFF0060AE),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.05,
                    ),

                    //back button row
                    _customAppbar(context),

                    SizedBox(
                      height: SizeConfig.screenHeight * 0.05,
                    ),

                    _header(),

                    SizedBox(
                      height: SizeConfig.screenHeight * 0.03,
                    ),

                    //search
                    _search(context, requestRecordsMdl),
                  ],
                ),
              ),

              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),

              //records listview
              Expanded(
                child: requestRecordsMdl.recordsList!.isNotEmpty ? ListView.builder(
                    shrinkWrap: true,
                    primary: true,
                    //itemCount: _recordsList.length,
                    itemCount: requestRecordsMdl.recordsList!.length,
                    padding: const EdgeInsets.all(16.0),
                    itemBuilder: (context, int index) {
                      //return RecordItem(item: _recordsList[index]);
                      return RecordItem(item: requestRecordsMdl.recordsList![index]);
                    }) : const Center(child: Text('No records found !', style: TextStyle(fontSize: 16),)),
              ),
            ],
          ),

          Visibility(
            visible: requestRecordsMdl.loading,
            child: Utils.loadingIndicator(),
          ),

        ],
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Check record'.toUpperCase(),
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Enter CNIC No. to check record',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w100,
            ),
          ),
        ],
      ),
    );
  }

  Widget _customAppbar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.keyboard_arrow_left_outlined, color: Colors.white),
        ),
        //const Expanded(child: SizedBox()),
        Text(
          'Dashboard'.toUpperCase(),
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),

        IconButton(
          onPressed: () {

            Navigator.pop(context);
          },
          icon: const Icon(Icons.exit_to_app, color: Colors.white),
        ),

        //const Expanded(child: SizedBox()),
        /*SizedBox(
          width: SizeConfig.screenWidth * 0.1,
        ),*/
      ],
    );
  }

  Widget _search(BuildContext context, RequestRecordsProvider requestRecordsProvider) {
    return Center(
      child: Container(
        width: SizeConfig.screenWidth * 0.85,
        height: SizeConfig.screenHeight * 0.072,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            )),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 4),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintStyle:
                      TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 4),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                      left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Search Record",
                ),
                onChanged: (value) {

                  if(value.isEmpty) {
                    Provider.of<RequestRecordsProvider>(context, listen: false).getRequestRecordsResponse(context);
                  }

                },
                onEditingComplete: () async {
                  //hide keyboard
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
            const SizedBox(width: 2.0),
            InkWell(
              onTap: () {

                if(_searchController.text.isNotEmpty) {
                  requestRecordsProvider.getSearchRequestRecordResponse(context, _searchController.text);
                }

              },
              child: Container(
                padding: EdgeInsets.all(4.0),
                decoration: const BoxDecoration(
                  color: Color(0xFF0060AE),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Icon(Icons.search, color: Colors.white, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getRecordsList() {
    _recordsList.add(RecordModel(
        name: 'Ali Ahamd Khan',
        phone: '+923344355',
        cnic: '1344551210333',
        careOf: 'Hasnat Khan',
        amount: '54000.0',
        category: 'test',
        status: 'approved'));

    _recordsList.add(RecordModel(
        name: 'Ali',
        phone: '+923344355',
        cnic: '1344551210333',
        careOf: 'Hasnat Khan',
        amount: '54000.0',
        category: 'test',
        status: 'approved'));

    _recordsList.add(RecordModel(
        name: 'Ali',
        phone: '+923344355',
        cnic: '1344551210333',
        careOf: 'Hasnat Khan',
        amount: '54000.0',
        category: 'test',
        status: 'in progress'));

    _recordsList.add(RecordModel(
        name: 'Ali',
        phone: '+923344355',
        cnic: '1344551210333',
        careOf: 'Hasnat Khan',
        amount: '54000.0',
        category: 'test',
        status: 'in progress'));

    _recordsList.add(RecordModel(
        name: 'Ali',
        phone: '+923344355',
        cnic: '1344551210333',
        careOf: 'Hasnat Khan',
        amount: '54000.0',
        category: 'test',
        status: 'in progress'));

    _recordsList.add(RecordModel(
        name: 'Ali',
        phone: '+923344355',
        cnic: '1344551210333',
        careOf: 'Hasnat Khan',
        amount: '54000.0',
        category: 'test',
        status: 'approved'));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _searchController.dispose();
  }
}

///////
///
/// new code
