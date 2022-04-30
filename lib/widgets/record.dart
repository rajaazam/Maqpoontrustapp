
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maqpoon_trust/utils/size_config.dart';

class RecordData extends StatelessWidget {

  const RecordData({
    Key? key,
    required String icon,
    required String title,
    required String text,
  }) : _icon = icon, _title = title, _text = text, super(key: key);

  final String _icon;
  final String _title;
  final String _text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.all(12.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            _icon,
            width: 16,
            height: 16,
          ),
          SizedBox(
              width: SizeConfig.screenWidth * 0.04),
          Expanded(
              child: Text(
                _title,
                style: TextStyle(
                    fontSize: 12, color: Color(0xFF0060AE)),
              )),
          Expanded(
            child: Text(
              _text,
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF2A2A2A)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
