import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_widget/home_widget.dart';
import 'package:testing/src/constants/colors.dart';
import 'package:testing/src/routing/router.dart';
import 'package:testing/src/ui/app/app_list_page.dart';

import 'package:testing/src/ui/main/widgets/testings.dart';
import 'package:testing/src/ui/widgets/boxx.dart';

import 'notification_handler.dart';

@RoutePage()
class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  void initState() {
    super.initState();

    HomeWidget.setAppGroupId('fdj');

    Future.delayed(
      Duration.zero,
      () => ref.read(notificationHandlerProvider.notifier).onUiInit(context),
    );
    HomeWidget.widgetClicked.listen((Uri? uri) => loadData());
    updateAppWidget();
  }

  void loadData() async {
    await HomeWidget.getWidgetData<String>('timeline',
            defaultValue: 'Saturnalia')
        .then((value) {});
    setState(() {});
  }

  Future<void> updateAppWidget() async {

    await HomeWidget.saveWidgetData('title', "It Works😃\n");
    await HomeWidget.saveWidgetData('timeline', "😍");
    await HomeWidget.renderFlutterWidget(
      const Testing(),
      key: 'lineChart',
      logicalSize: const Size(100, 100),
    );

    await HomeWidget.updateWidget(
        name: 'HomeScreenWidgetProvider', iOSName: 'HomeScreenWidgetProvider');
  }

  @override
  void dispose() {
    super.dispose();
    ref.read(notificationHandlerProvider.notifier).onUiDispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(notificationHandlerProvider, (previous, next) {});
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              CustomBox(
                onTap: () => context.navigateTo(const AppListRoute()),
                text: 'View Apps',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomBox(
                onTap: () {},
                text: 'Pending Work',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomBox(
                onTap: () {},
                text: 'Yet To Decide',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomBox(
                onTap: () {},
                text: 'Comming Soon',
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: updateAppWidget,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
