import 'package:flutter/material.dart';

class CityView extends StatelessWidget {
  CityView({Key key}) : super(key: key);
  final _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Find By City'.toUpperCase()),
        elevation: 0.0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back_photo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textEditingController,
              style: const TextStyle(color: Colors.white, fontSize: 22.0),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  borderSide: BorderSide(color: Colors.teal),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  borderSide: BorderSide(width: 1, color: Colors.white),
                ),
                hintText: 'Шаардын атын жаз',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();

                Navigator.of(context).pop(_textEditingController.text);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 12.0),
                child: Text(
                  'Аба ырайын изде',
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
