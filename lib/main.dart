import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/locale.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Load the initial counter value from SharedPreferences
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final int initialCount = prefs.getInt('counter') ?? 0;

  runApp(EasyLocalization(
      supportedLocales: AppLocale.supportedLocales
          .map((e) => Locale(e.languageCode))
          .toList(),
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MyApp(initialCount: initialCount)));
}

class MyApp extends StatelessWidget {
  final int initialCount;
  const MyApp({super.key, required this.initialCount});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterModel(initialCount),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: const HomeScreen(),
      ),
    );
  }
}

class CounterModel extends ChangeNotifier {
  int _count;

  CounterModel(this._count);

  int get count => _count;

  Future<void> increment() async {
    _count++;
    await _saveCounterValue();
    notifyListeners();
  }

  Future<void> decrement() async {
    _count--;
    await _saveCounterValue();
    notifyListeners();
  }

  Future<void> _saveCounterValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _count);
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Flutter Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Consumer<CounterModel>(
              builder: (context, counter, child) {
                return Text(
                  counter.count.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            TextButton(
              onPressed: () {
                context.read<CounterModel>().decrement();
              },
              child: const Text("Decrement"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CounterModel>().increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      children: [
        DrawerHeader(child: Image.asset("assets/images/figma_logo.png"))
      ],
    );
  }
}
