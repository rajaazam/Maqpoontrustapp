import 'package:flutter/material.dart';
import 'package:maqpoon_trust/models/record_model.dart';
import 'package:maqpoon_trust/providers/request_records_provider.dart';
import 'package:maqpoon_trust/utils/size_config.dart';
import 'package:maqpoon_trust/utils/utils.dart';
import 'package:maqpoon_trust/widgets/record_item.dart';
import 'package:provider/provider.dart';
class DashboardSreeen extends StatefulWidget {
  final TextEditingController? controller;

   DashboardSreeen({Key? key, this.controller}) : super(key: key);


  @override
  _DashboardSreeenState createState() => _DashboardSreeenState();
}

class _DashboardSreeenState extends State<DashboardSreeen> {
  
 // final TextEditingController search= TextEditingController();
  TextEditingController _searchController = TextEditingController();
   List<RecordModel> _recordeList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
     RequestRecordsProvider requestRecordsProvider = Provider.of<RequestRecordsProvider>(context, listen: false);
     requestRecordsProvider.getRequestRecordsResponse(context).then((value) {


          });
    });
   // _getRecordsList();
  
  }

  @override
  Widget build(BuildContext context) {
    final requestRecordsMdl = Provider.of<RequestRecordsProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            color: Colors.white,
          ),
          Positioned(
              left: -60,
              bottom: -40,
              child: Image.asset(
                'assets/images/bg1.png',
                width: SizeConfig.screenWidth * 1.2,
              )),
          Column(
            children: [
              Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 0.37,
                decoration: const BoxDecoration(
                    color: Color(0xFF0060AE),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.05,
                    )
                  ],
                ),
              ),
              Expanded(
                  child: requestRecordsMdl.recordsList!.isEmpty
                      ? ListView.builder(itemBuilder: (context, int index) {
                          return RecordItem(
                              item: requestRecordsMdl.recordsList![index]);
                        })
                      : const Center(
                          child: Text(
                            'No recder Found',
                            style: TextStyle(fontSize: 14),
                          ),
                        )),
              Visibility(
                  visible: requestRecordsMdl.loading,
                  child: Utils.loadingIndicator())
            ],
          )
        ],
      ),
    );
  }
}

// /// wideget

Widget _header() {
  return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'reocrd'.toUpperCase(),
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Enter CNIC No. to search reocder',
            style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w100),
          )
        ],
      ));
}

//2 widget

Widget _customerApp(BuildContext context){

  return Row(
    mainAxisAlignment:MainAxisAlignment.spaceBetween,
    children: [
      IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon:const Icon(Icons.keyboard_arrow_left,color: Colors.white,)
      ),
      Text('dashboard'.toUpperCase(),style: 
      TextStyle(color: Colors.white,fontSize: 14),),
       IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon:const Icon(Icons.exit_to_app,color: Colors.white,)
      ),
    ],
  );
}


// 3 

 Widget _search(BuildContext context, RequestRecordsProvider requestRecordsProvider,TextEditingController _searchController) {
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
                controller:_searchController,
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

//   _getRecordsList() {
//     _recordeList.add(RecordModel(
//         name: 'Ali Ahamd Khan',
//         phone: '+923344355',
//         cnic: '1344551210333',
//         careOf: 'Hasnat Khan',
//         amount: '54000.0',
//         category: 'test',
//         status: 'approved'));

//     _recordsList.add(RecordModel(
//         name: 'Ali',
//         phone: '+923344355',
//         cnic: '1344551210333',
//         careOf: 'Hasnat Khan',
//         amount: '54000.0',
//         category: 'test',
//         status: 'approved'));

//     _recordsList.add(RecordModel(
//         name: 'Ali',
//         phone: '+923344355',
//         cnic: '1344551210333',
//         careOf: 'Hasnat Khan',
//         amount: '54000.0',
//         category: 'test',
//         status: 'in progress'));

//     _recordsList.add(RecordModel(
//         name: 'Ali',
//         phone: '+923344355',
//         cnic: '1344551210333',
//         careOf: 'Hasnat Khan',
//         amount: '54000.0',
//         category: 'test',
//         status: 'in progress'));

//     _recordeList.add(RecordModel(
//         name: 'Ali',
//         phone: '+923344355',
//         cnic: '1344551210333',
//         careOf: 'Hasnat Khan',
//         amount: '54000.0',
//         category: 'test',
//         status: 'in progress'));

//     _recordsList.add(RecordModel(
//         name: 'Ali',
//         phone: '+923344355',
//         cnic: '1344551210333',
//         careOf: 'Hasnat Khan',
//         amount: '54000.0',
//         category: 'test',
//         status: 'approved'));
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();

//     _searchController.dispose();
//   }}