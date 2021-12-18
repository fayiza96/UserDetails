import 'package:flutter/material.dart';

class TextFieldUser extends StatelessWidget {
  final String? title;
  final String? value;
  TextFieldUser({Key? key, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 8,
            left: 36,
            right: 36,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Text(
            "$title",
            style: TextStyle(
              fontFamily: "OpenSans",
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
          Spacer(),
          Container(
            width:MediaQuery.of(context).size.width/2.2,
            child: Text(
            "$value",
            style: TextStyle(
              fontFamily: "OpenSans",
              fontSize: 12,
            ),
            textAlign: TextAlign.right,
          ),
          )
      ],
    ),
        ));
  }
}
