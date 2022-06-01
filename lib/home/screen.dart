import 'package:flutter/material.dart';

const _kEmptyUnicodeCharacter = "\u200b";

// https://github.com/flutter/flutter/issues/14809
// https://medium.com/super-declarative/why-you-cant-detect-a-delete-action-in-an-empty-flutter-text-field-3cf53e47b631
// https://github.com/flutter/flutter/issues/14809
// https://medium.com/flutter-community/working-with-unicode-and-grapheme-clusters-in-dart-b054faab5705

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final firstField = TextEditingController(text: _kEmptyUnicodeCharacter);
  final secondField = TextEditingController(text: _kEmptyUnicodeCharacter);
  final thirdField = TextEditingController(text: _kEmptyUnicodeCharacter);
  final fourField = TextEditingController(text: _kEmptyUnicodeCharacter);
  final fiveField = TextEditingController(text: _kEmptyUnicodeCharacter);
  final sixField = TextEditingController(text: _kEmptyUnicodeCharacter);

  @override
  void dispose() {
    firstField.dispose();
    secondField.dispose();
    thirdField.dispose();
    fourField.dispose();
    fiveField.dispose();
    sixField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {},
        ),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Informe o código',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const SizedBox(height: 16),
              Text(
                'Enviamos um código para',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                '55 21 *******37',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Flexible(
                    child: _PinCodeField(
                      controller: firstField,
                      autoFocus: true,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: _PinCodeField(
                      controller: secondField,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: _PinCodeField(
                      controller: thirdField,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const SizedBox(
                    width: 40,
                    height: 40,
                    child: Center(
                      child: Text(
                        '-',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: _PinCodeField(
                      controller: fourField,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: _PinCodeField(
                      controller: fiveField,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: _PinCodeField(
                      controller: sixField,
                      textInputAction: TextInputAction.done,
                      onSubmit: () {
                        print('called');
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const _CodeValid(),
              const SizedBox(height: 32),
              const CircularProgressIndicator(
                strokeWidth: 1.0,
                valueColor: AlwaysStoppedAnimation(Colors.grey),
              ),
              ElevatedButton(
                onPressed: () {
                  firstField.text
                    ..replaceAll(_kEmptyUnicodeCharacter, "")
                    ..trim();
                  secondField.text
                    ..replaceAll(_kEmptyUnicodeCharacter, "")
                    ..trim();
                  thirdField.text
                    ..replaceAll(_kEmptyUnicodeCharacter, "")
                    ..trim();
                  fourField.text
                    ..replaceAll(_kEmptyUnicodeCharacter, "")
                    ..trim();
                  fiveField.text
                    ..replaceAll(_kEmptyUnicodeCharacter, "")
                    ..trim();
                  sixField.text
                    ..replaceAll(_kEmptyUnicodeCharacter, "")
                    ..trim();

                  print(
                    'final String ${firstField.text} ${secondField.text} ${thirdField.text} ${fourField.text} ${fiveField.text} ${sixField.text}',
                  );
                },
                child: Text('Tap'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PinCodeField extends StatelessWidget {
  const _PinCodeField({
    Key? key,
    required this.controller,
    this.autoFocus = false,
    this.textInputAction,
    this.onSubmit,
  }) : super(key: key);

  final TextEditingController controller;
  final bool autoFocus;
  final TextInputAction? textInputAction;
  final VoidCallback? onSubmit;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 3,
      textAlign: TextAlign.center,
      controller: controller,
      autofocus: autoFocus,
      keyboardType: TextInputType.number,
      textInputAction: textInputAction,
      decoration: const InputDecoration(
        counterText: "",
      ),
      onTap: () {
        if (controller.text.isEmpty) {
          controller.text = _kEmptyUnicodeCharacter;
        }
      },
      onChanged: (value) {
        print(value);
        print(value.length);
        if (value.length <= 1) {
          FocusScope.of(context).previousFocus();
          controller.text = _kEmptyUnicodeCharacter;
          return;
        }

        if (value.startsWith(_kEmptyUnicodeCharacter) && value.length > 1) {
          if (value.length > 2) {
            controller.text = "$_kEmptyUnicodeCharacter${value[2]}";
          }

          if (onSubmit != null) {
            onSubmit!();
            FocusScope.of(context).unfocus();
          } else {
            FocusScope.of(context).nextFocus();
          }
        } else {
          controller.text = _kEmptyUnicodeCharacter +
              value.characters.firstWhere(
                (e) => e != _kEmptyUnicodeCharacter,
              );
          FocusScope.of(context).nextFocus();

          // controller.text = "$_kEmptyUnicodeCharacter${value.replaceAll(
          //   _kEmptyUnicodeCharacter,
          //   "",
          // )}";
        }
        // else if (value.startsWith(_kEmptyUnicodeCharacter)) {
        //   FocusScope.of(context).previousFocus();
        // } else {
        //   controller.text = "$_kEmptyUnicodeCharacter$value";
        // }

        // if (value.isEmpty) {
        //   FocusScope.of(context).previousFocus();
        // } else {}
      },
    );
  }
}

class _CodeValid extends StatelessWidget {
  const _CodeValid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.check_circle_outline,
          color: Colors.green,
          size: 20,
        ),
        const SizedBox(width: 4),
        Text(
          'Código validado',
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: Colors.green),
        ),
      ],
    );
  }
}
