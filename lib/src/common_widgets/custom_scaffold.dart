import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, required this.body, required this.extendBodyBehindAppBar}); // and maybe other Scaffold properties

  final Widget body;
  final bool extendBodyBehindAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: this.extendBodyBehindAppBar,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.

      ),
      //backgroundColor: Color(0xFFfc5c7d),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFFF23D5E),
          Color(0xFF6a82fb),
        ], stops: [
          0.35,
          0.8,
        ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
        child: body,
      ),
    );
  }
}
