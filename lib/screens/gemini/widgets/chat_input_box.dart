import 'package:flutter/material.dart';
import 'package:grocery_app/styles/colors.dart';

class ChatInputBox extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onSend, onClickCamera;

  const ChatInputBox({
    super.key,
    this.controller,
    this.onSend,
    this.onClickCamera,
  });

  @override
  Widget build(BuildContext context) {
    // Define a custom theme for ChatInputBox
    final ThemeData customTheme = ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        onSecondary: const Color.fromARGB(255, 0, 0, 0),
        // Example color for the IconButton
      ),
      // cardTheme: CardTheme(color: Color.fromARGB(255, 191, 231, 206)),
    );

    return Theme(
      data: customTheme,
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (onClickCamera != null)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: IconButton(
                    onPressed: onClickCamera,
                    color: customTheme.colorScheme.onSecondary,
                    icon: const Icon(Icons.file_copy_rounded)),
              ),
            Expanded(
                child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 6,
              cursorColor: customTheme.colorScheme.inversePrimary,
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                hintText: 'Message',
                border: InputBorder.none,
              ),
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
            )),
            Padding(
              padding: const EdgeInsets.all(4),
              child: FloatingActionButton.small(
                onPressed: onSend,
                child: const Icon(Icons.send_rounded),
              ),
            )
          ],
        ),
      ),
    );
  }
}
