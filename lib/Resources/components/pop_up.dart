import 'package:flutter/material.dart';

Widget buildPopupDialog(BuildContext context, title) {
  return AlertDialog(
    insetPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 1),
    title: Text('Info'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title),
      ],
    ),
    actions: <Widget>[
      FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: Text('Close'),
      ),
    ],
  );
}

void popUp(context, string) {
  showDialog(
    context: context,
    builder: (BuildContext context) => buildPopupDialog(context, string),
  );
}

class PopUpButton extends StatelessWidget {
  final String image;
  final String text;
  final double scale;
  final Widget widget;

  const PopUpButton({
    this.widget,
    this.image,
    @required this.text,
    this.scale,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () {
          popUp(context, text);
        },
        child: widget);
  }
}
