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
      pagesCount = paragraphCount(book);
    });
  }

  var book;
  var pagesCount;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadBook();
    // paragraphCount(book);
  }

  int paragraphCount(dynamic book) {
    if (book == null) return 0;
    int count = 0;
    for (var chapter in book['chapters']) {
      count += (chapter['content'] as List).length;
    }
    return count;
  }

  // int paragraphCount(dynamic book) {
  //   int count = 0;
  //   for (var chapter in book['chapters'] as List) {
  //     for (var content in chapter['content'] as List) {
  //       count += content.length as int;
  //     }
  //   }
  //   // setState(() {
  //   //   pagesCount = count;
  //   // });
  //   return count;
  // }

  @override
  Widget build(BuildContext context) {
    pagesCount = paragraphCount(book);
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: () {},
      //     icon: Icon(
      //       Icons.menu,
      //       color: secondary,
      //     ),
      //   ),
      //   title: Text('صفة الصلاة'),
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: IconButton(
      //         onPressed: () {},
      //         icon: Icon(
      //           Icons.bookmark,
      //           color: primary,
      //         ),
      //       ),
      //     ),
      //     IconButton(
      //       onPressed: () {},
      //       icon: IconButton(
      //         onPressed: () {},
      //         icon: Icon(
      //           Icons.edit_note_outlined,
      //         ),
      //       ),
      //     ),
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(
      //         Icons.font_download,
      //       ),
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: book != null
            ? PageView.builder(
                itemCount: pagesCount,
                itemBuilder: (context, index) {
                  final text =
                      book['chapters'][index]['content'][index]['text'];
                  final chapterTitle = book['chapters'][index]['title'];

                  return ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 20),
                        child: Text(
                          chapterTitle,
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 16.0,
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
              ),
      ),
    );
  }
}
