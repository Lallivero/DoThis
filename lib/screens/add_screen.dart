import 'package:do_this/provider/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({Key? key, required this.onPressed}) : super(key: key);

  final Function(String value) onPressed;

  @override
  Widget build(BuildContext context) {
    late String? _fieldValue;
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(50.0),
            topLeft: Radius.circular(50.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add Task List',
              style: TextStyle(fontSize: 30.0),
              textAlign: TextAlign.center,
            ),
            TextField(
              autofocus: true,
              onChanged: (value) {
                _fieldValue = value;
              },
              textAlign: TextAlign.center,
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            TextButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal)),
              onPressed: () {
                onPressed(_fieldValue!);
              },
              child: const Text(
                'Add',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
