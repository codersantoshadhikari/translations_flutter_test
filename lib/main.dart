import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translations_flutter_test/counter/counter_cubit.dart';
import 'package:translations_flutter_test/translation.dart';
import 'home.dart';
import 'models/locale.dart';

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  Map<String, dynamic> finalData =
      await TranslationFromGithub.getLocalizationDataFromGithub();

  runApp(EasyLocalization(
      supportedLocales: AppLocale.supportedLocales
          .map((e) => Locale(e.languageCode))
          .toList(),
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      assetLoader: MyHttpLocalizationLoader(finalData),
      child: const MyApp()));
}

class MyHttpLocalizationLoader extends AssetLoader {
  final Map<String, dynamic> data;
  const MyHttpLocalizationLoader(this.data);

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) async {
    return data[locale.toString()];
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterCubit, CounterState>(
              builder: (context, state) {
                return Text(
                  state.count.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            TextButton(
                onPressed: () {
                  context.read<CounterCubit>().decrement();
                },
                child: const Text("ok")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CounterCubit>().increment(),
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
