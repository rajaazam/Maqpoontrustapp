
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maqpoon_trust/models/request_records_response.dart';
import 'package:maqpoon_trust/utils/size_config.dart';
import 'package:maqpoon_trust/widgets/record.dart';


class RecordItem extends StatelessWidget {
  const RecordItem({
    Key? key,
    //required RecordModel item,
    required RequestRecordsData item,
  })  : _item = item,
        super(key: key);

  //final RecordModel _item;
  final RequestRecordsData _item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight * 0.54,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Color(0xFFF1F8FF),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                  child: Text(
                'Request Status',
                style: TextStyle(fontSize: 16, color: Color(0xFF0060AE)),
              ),),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: _getColor(_item.status!),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    _getStatusValue(_item.status!),
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Divider(
            color: Colors.black.withOpacity(0.2),
          ),

          SizedBox(
            height: SizeConfig.screenHeight * 0.02,
          ),

          //name
          RecordData(
            icon: 'assets/images/name.svg',
            title: 'NAME: ',
            text: _item.fullName!,
          ),

          SizedBox(
            height: SizeConfig.screenHeight * 0.01,
          ),

          //phone
          RecordData(
            icon: 'assets/images/phone.svg',
            title: 'PHONE: ',
            text: _item.phoneNumber!,
          ),

          SizedBox(
            height: SizeConfig.screenHeight * 0.01,
          ),

          //cnic
          RecordData(
            icon: 'assets/images/cnic.svg',
            title: 'CNIC: ',
            text: _item.cnic!,
          ),

          SizedBox(
            height: SizeConfig.screenHeight * 0.01,
          ),

          //care of
          RecordData(
            icon: 'assets/images/care_of.svg',
            title: 'CARE OF: ',
            text: _item.careOf!,
          ),

          SizedBox(
            height: SizeConfig.screenHeight * 0.01,
          ),

          //amount
          RecordData(
            icon: 'assets/images/amount.svg',
            title: 'AMOUNT: ',
            text: _item.amount!,
          ),

          SizedBox(
            height: SizeConfig.screenHeight * 0.01,
          ),

          //category
          Container(
            width: SizeConfig.screenWidth,
            padding: const EdgeInsets.all(12.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/category.svg',
                  width: 16,
                  height: 16,
                ),
                SizedBox(width: SizeConfig.screenWidth * 0.04),
                const Expanded(
                    child: Text(
                  'CATEGORY: ',
                  style: TextStyle(fontSize: 12, color: Color(0xFF0060AE)),
                )),
                Expanded(
                  child: Text(
                    _item.categoryName!,
                    style: const TextStyle(fontSize: 14, color: Color(0xFF2A2A2A)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }

  Color _getColor(String status) {

    //0 is for pending
    //1 is for rejected
    //2 is for approved

    if(status == '0') {

      //pending
      return const Color(0xFFFFA200);
    }
    else if(status == '1') {

      //rejected
      return const Color(0xFFFF0000);
    }
    else if(status == '2') {

      //approved
      return const Color(0xFF24BE24);
    }

    //pending by default
    return const Color(0xFFFFA200);

  }


  String _getStatusValue(String status) {

    if(status == '0') {

      //pending
      return 'Pending';
    }
    else if(status == '1') {

      //rejected
      return 'Rejected';
    }
    else if(status == '2') {

      //approved
      return 'Approved';
    }

    return '';
  }

}
