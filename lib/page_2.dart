import 'package:flutter/material.dart';

class PageTwo extends StatefulWidget {
  final String email;
  const PageTwo({super.key, required this.email});

  @override
  State<PageTwo> createState() => _PageOneState();
}

class _PageOneState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      leading: const BackButton(color: Colors.pink),
    ));
  }
}
