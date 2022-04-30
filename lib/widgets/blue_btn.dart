
import 'package:flutter/material.dart';
import 'package:maqpoon_trust/utils/size_config.dart';
import 'package:maqpoon_trust/utils/styles.dart';


class BlueBtn extends StatelessWidget {

  const BlueBtn({
    Key? key,
    required this.kBlueBtnDecoration,
    required this.text,
    required this.callback,
  }) : super(key: key);

  final Decoration kBlueBtnDecoration;
  final String text;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => callback(),
      child: Container(
        width: SizeConfig.screenWidth * 0.80,
        padding: EdgeInsets.all(24),
        decoration: kBlueBtnDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text.toUpperCase(),
              style: blueBtnTextStyle,
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
