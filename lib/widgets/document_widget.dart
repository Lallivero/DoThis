import 'package:flutter/material.dart';

class DocumentWidget extends StatelessWidget {
  const DocumentWidget({
    Key? key,
    required this.name,
    required this.onLongPress,
    required this.onTap,
  }) : super(key: key);
  final String name;

  final Function() onLongPress;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.tealAccent,
        elevation: 10.0,
        child: Center(
          child: ListTile(
            title: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 25.0),
            ),
            onLongPress: onLongPress,
            onTap: onTap,
            tileColor: Colors.tealAccent,
          ),
        ));
  }
}
