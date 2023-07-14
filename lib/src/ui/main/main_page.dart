import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_widget/home_widget.dart';

import 'notification_handler.dart';

@RoutePage()
class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  int _counter = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () => ref.read(notificationHandlerProvider.notifier).onUiInit(context),
    );
    HomeWidget.widgetClicked.listen((Uri? uri) => loadData());
    updateAppWidget();
  }

  void loadData() async {
    await HomeWidget.getWidgetData<String>('tineline',
            defaultValue: 'Saturnalia')
        .then((value) {});
    setState(() {});
  }

  Future<void> updateAppWidget() async {
    await HomeWidget.saveWidgetData('title', "Code For good");
    await HomeWidget.saveWidgetData('timeline', "15th July 2023");
    await HomeWidget.updateWidget(
        name: 'HomeScreenWidgetProvider', iOSName: 'HomeScreenWidgetProvider');
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
    updateAppWidget();
  }

  @override
  void dispose() {
    super.dispose();
    ref.read(notificationHandlerProvider.notifier).onUiDispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(notificationHandlerProvider, (previous, next) {});
    return Scaffold(
      body: Center(
        child: Text(_counter.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
