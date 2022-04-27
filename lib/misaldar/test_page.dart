import 'dart:developer';

import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  // asychronous  -- Synchronous
  String _name = 'Text';
  @override
  void initState() {
    log('initState ====>>');
    getName();
    super.initState();
  }

  Future<void> getName() async {
    try {
      log('GetName ===>>>');
      await Future.delayed(Duration(seconds: 5), () {
        _name = 'Name 5 sekunddan kkiyin ozgordu';
      });
    } catch (kata) {
      throw Exception(kata);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    log('Build ===>>>');
    return Scaffold(
      body: Center(
        child: Text(
          _name,
          style: const TextStyle(fontSize: 40.0),
        ),
      ),
    );
  }
}
