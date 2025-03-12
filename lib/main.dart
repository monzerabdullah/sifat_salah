import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sifat alsalah',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'NotoKufiArabic',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future loadBook() async {
    final jsonData = await rootBundle.loadString('assets/book.json');
    final data = json.decode(jsonData);
    setState(() {
      book = data;
    });
  }

  var book;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadBook();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('صفة الصلاة'),
      ),
      body: SafeArea(
          child: book != null
              ? PageView.builder(
                  itemCount: book['pages'].length,
                  itemBuilder: (context, index) {
                    final text = book['pages'][index]['text'];
                    return ListView(
                      children: [
                        Text(
                          text,
                        ),
                      ],
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}
