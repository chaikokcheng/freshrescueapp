import 'package:flutter/material.dart';
import 'package:grocery_app/screens/gemini/sections/chat.dart';
import 'package:grocery_app/screens/gemini/sections/embed_batch_contents.dart';
import 'package:grocery_app/screens/gemini/sections/embed_content.dart';
import 'package:grocery_app/screens/gemini/sections/response_widget_stream.dart';
import 'package:grocery_app/screens/gemini/sections/stream.dart';
import 'package:grocery_app/screens/gemini/sections/text_and_image.dart';
import 'package:grocery_app/screens/gemini/sections/text_only.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:grocery_app/styles/colors.dart';

class GeminiApp extends StatelessWidget {
  const GeminiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Gemini',
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        cardTheme: CardTheme(color: AppColors.primaryColor),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class SectionItem {
  final int index;
  final String title;
  final Widget widget;

  SectionItem(this.index, this.title, this.widget);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedItem = 0;

  final _sections = <SectionItem>[
    SectionItem(0, 'Stream text', const SectionTextStreamInput()),
    SectionItem(1, 'textAndImage', const SectionTextAndImageInput()),
    SectionItem(2, 'chat', const SectionChat()),
    SectionItem(3, 'text', const SectionTextInput()),
    SectionItem(4, 'embedContent', const SectionEmbedContent()),
    SectionItem(5, 'batchEmbedContents', const SectionBatchEmbedContents()),
    SectionItem(
        6, 'response without setState()', const ResponseWidgetSection()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _selectedItem != 0
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => setState(() => _selectedItem = 0),
              )
            : null,
        title: Text(_sections[_selectedItem].title),
        backgroundColor: AppColors.primaryColor,
        actions: [
          PopupMenuButton<int>(
            initialValue: _selectedItem,
            onSelected: (value) => setState(() => _selectedItem = value),
            itemBuilder: (context) => _sections.map((e) {
              return PopupMenuItem<int>(value: e.index, child: Text(e.title));
            }).toList(),
            child: const Icon(Icons.more_vert_rounded),
          )
        ],
      ),
      body: IndexedStack(
        index: _selectedItem,
        children: _sections.map((e) => e.widget).toList(),
      ),
    );
  }
}
