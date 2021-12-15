import 'package:flutter/material.dart';

class FAB extends StatelessWidget {
  const FAB({Key? key, required this.targetScreen}) : super(key: key);

  final Widget targetScreen;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.add,
        size: 40.0,
      ),
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent.withOpacity(0),
          context: context,
          isScrollControlled: true,
          builder: (context) => SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: targetScreen,
            ),
          ),
        );
      },
    );
  }
}
