import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'generated/local_keys.dart';
import 'models/locale.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  String convertToRespectiveNumber(String number, BuildContext context) {
    String res = '';

    if (context.locale == const Locale('ar')) {
      final arabics = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
      for (var element in number.characters) {
        final no = int.tryParse(element);
        if (no != null) {
          res += arabics[no];
        } else {
          res += element;
        }
      }
      return res;
    }
    return number;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Localization Github Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: AppLocale.supportedLocales.map((e) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        context.setLocale(e.locale);
                      },
                      child: Chip(
                        label: Text(
                          e.localeName,
                          style: TextStyle(
                            color: context.locale == e.locale
                                ? Colors.white
                                : null,
                          ),
                        ),
                        color: context.locale == e.locale
                            ? const WidgetStatePropertyAll(Colors.green)
                            : null,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Text(
              convertToRespectiveNumber(_counter.toString(), context),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text("welcome_header".tr()),
            Text(
              "rate_us".tr(),
              style: const TextStyle(fontSize: 46),
            ),
            Text(
              LocaleKeys.helloName.tr(
                namedArgs: {"userName": "John Doe"},
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
