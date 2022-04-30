
import 'package:flutter/material.dart';
import 'package:maqpoon_trust/utils/size_config.dart';

class SimpleBlueBtn extends StatelessWidget {

  const SimpleBlueBtn({
    Key? key,
    required this.kSimpleBlueBtnDecoration,
    required this.text,
    required this.callback,
  }) : super(key: key);

  final Decoration kSimpleBlueBtnDecoration;
  final String text;
  final Function callback;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => callback(),
      child: Container(
        width: SizeConfig.screenWidth * 0.80,
        padding: EdgeInsets.all(24),
        decoration: kSimpleBlueBtnDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text.toUpperCase(),
              style: const TextStyle(
                  fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
