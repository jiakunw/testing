import 'const.dart';
import 'package:flutter/material.dart';

Widget CustomMajorButton(
  BuildContext context,
  String buttonString,
  Future<void> Function() func, {
  Color backgroundColor = const Color(0xFF00A096),
  Color textColor = const Color(0xFFFFFFFF),
  double percentWidth = 0.80,
}) {
  return Container(
    width: anyPercentOfScreenWidth(context, percentWidth),
    height: 60.0,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      onPressed: func,
      child: Text(
        buttonString,
        style: TextStyle(
            color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

// ignore: non_constant_identifier_names
Widget CustomSingleTextField(
    String name, String hintText, TextEditingController controller,
    {bool obscure = false, maxlines = 1, maxLength = 50, counterText = ''}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.fromLTRB(4, 8, 8, 8),
        child: Text(
          name,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(color: Colors.white),
        maxLines: maxlines,
        maxLength: maxLength,
        decoration: InputDecoration(
          counterText: counterText,
          fillColor: const Color(
              0xFF292929), // Replace with your desired background color
          filled: true,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // Desired border radius
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // Desired border radius
            borderSide: BorderSide.none,
          ),
          labelText: null, // Removes the label above the TextField
          hintText: hintText, // Placeholder text
          hintStyle: const TextStyle(color: Color(0xFF797979)),
        ),
        onChanged: (text) {
          final lineBreakCount =
              RegExp(r'\n', multiLine: true).allMatches(text).length;
          if (lineBreakCount > 3) {
            // Remove any extra line breaks beyond the limit
            final lines = text.split('\n').take(3);
            controller.text = lines.join('\n');
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length),
            );
          }
        },
      ),
    ],
  );
}

Widget CustomSingleTextField2(String name, String subname, String hintText,
    TextEditingController controller,
    {bool obscure = false, maxlines = 1, maxLength = 50, counterText = ''}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.fromLTRB(4, 8, 8, 8),
        child: Row(
          children: [
            Text(
              name,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(
              width: 14,
            ),
            Text(
              subname,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
      TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(color: Colors.white),
        maxLines: maxlines,
        maxLength: maxLength,
        decoration: InputDecoration(
          counterText: counterText,
          fillColor: const Color(
              0xFF292929), // Replace with your desired background color
          filled: true,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // Desired border radius
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // Desired border radius
            borderSide: BorderSide.none,
          ),
          labelText: null, // Removes the label above the TextField
          hintText: hintText, // Placeholder text
          hintStyle: const TextStyle(color: Color(0xFF797979)),
        ),
        onChanged: (text) {
          final lineBreakCount =
              RegExp(r'\n', multiLine: true).allMatches(text).length;
          if (lineBreakCount > 3) {
            // Remove any extra line breaks beyond the limit
            final lines = text.split('\n').take(3);
            controller.text = lines.join('\n');
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length),
            );
          }
        },
      ),
    ],
  );
}
