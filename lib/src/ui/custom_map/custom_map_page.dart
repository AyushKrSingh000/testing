import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:auto_route/auto_route.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:testing/src/ui/custom_map/map_view.dart';

import '../widgets/boxx.dart';
import '../widgets/custom_text_field.dart';

@RoutePage()
class CustomMapPage extends ConsumerStatefulWidget {
  const CustomMapPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomMapPageState();
}

class _CustomMapPageState extends ConsumerState<CustomMapPage> {
  final List<IconData> icons = const [
    Icons.message,
    Icons.call,
    Icons.mail,
    Icons.notifications,
    Icons.settings,
  ];
  bool indexx = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: DraggableBottomSheet(
        minExtent: 60,
        useSafeArea: false,
        barrierColor: Colors.transparent,
        barrierDismissible: false,
        curve: Curves.easeIn,
        previewWidget: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.15),
                    offset: Offset(0, -2),
                    blurRadius: 10)
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Container(
                height: 5,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            )),
        expandedWidget: indexx == false ? _initialWidget() : _expandedWidget(),
        backgroundWidget: Stack(
          children: [
            const MapPage(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomTextField(
                label: '',
                hintText: 'Patiala,Punjab',
                onChanged: (value) {},
                initialText: '',
                maxLength: null,
              ),
            ),
          ],
        ),
        maxExtent: MediaQuery.of(context).size.height * 0.8,
        onDragging: (pos) {},
      ),
    ));
  }

  Widget _initialWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, -2),
              blurRadius: 10)
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 5,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: <Widget>[
                  CustomBox(
                    text: "Open Second Bottom Sheet",
                    onTap: () {
                      if (mounted) {
                        setState(() {
                          indexx = !indexx;
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _expandedWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, -2),
              blurRadius: 10)
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 5,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              itemCount: icons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      indexx = false;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icons[index], color: Colors.white, size: 40),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
