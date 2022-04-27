import 'package:flutter/material.dart';

import 'misal2_page.dart';

const String nameder = 'Manas';

class MisalPage extends StatefulWidget {
  const MisalPage({Key key, this.name, this.baa}) : super(key: key);
  final String name;
  final int baa;
  @override
  _MisalPageState createState() => _MisalPageState();
}

class _MisalPageState extends State<MisalPage> {
  String _name = 'Kubat';
  int _baa = 5;
  Future<void> attyOzgort() async {
    await Future.delayed(Duration(seconds: 4));
    _baa = 3;
    _name = 'Timur';
    setState(() {});
  }

  @override
  initState() {
    attyOzgort();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(nameder)),
      backgroundColor: Colors.black,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (con) => Misal2Page())),
            child: const Text(
              'FINAL EMES',
              style: TextStyle(fontSize: 25.0, color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            'ATY: $_name',
            style: const TextStyle(fontSize: 25.0, color: Colors.white),
          ),
          Text('Baasy: $_baa',
              style: const TextStyle(fontSize: 25.0, color: Colors.white)),
          const SizedBox(
            height: 30.0,
          ),
          const Text('-------FINAL-----',
              style: TextStyle(fontSize: 25.0, color: Colors.white)),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            'ATY: ${widget.name}',
            style: const TextStyle(fontSize: 25.0, color: Colors.white),
          ),
          Text('Baasy: ${widget.baa}',
              style: const TextStyle(fontSize: 25.0, color: Colors.white)),
        ],
      )),
    );
  }
}

class MYp extends StatelessWidget {
  const MYp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('$nameder'),
    );
  }
}
