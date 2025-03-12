import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sifat_salah/constants.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: background),
        useMaterial3: true,
        fontFamily: 'NotoKufiArabic',
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: const HomePage(),
      ),
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
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: secondary,
          ),
        ),
        title: Text('صفة الصلاة'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.bookmark,
                color: primary,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit_note_outlined,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.font_download,
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: book != null
              ? PageView.builder(
                  itemCount: book['pages'].length,
                  itemBuilder: (context, index) {
                    final text = book['pages'][index]['text'];
                    return ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 15,
                          ),
                          child: Text(
                            text,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 18,
                              height: 2,
                            ),
                          ),
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
