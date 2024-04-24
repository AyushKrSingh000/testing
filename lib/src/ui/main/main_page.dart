import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import 'package:pdf/pdf.dart';
import "package:printing/printing.dart";
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_widget/home_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:testing/src/logic/repositories/app_repository/app_repository.dart';
import 'package:testing/src/routing/router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:testing/src/ui/main/widgets/testings.dart';
import 'package:testing/src/ui/widgets/boxx.dart';
import 'package:testing/src/utils/file_utils.dart';
import 'notification_handler.dart';

@RoutePage()
class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  Uint8List? bytes = Uint8List(10);
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  static Future<String> getExternalDocumentPath() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    Directory _directory = Directory("");
    if (Platform.isAndroid) {
      _directory = Directory("/storage/emulated/0/Download");
    } else {
      _directory = await getApplicationDocumentsDirectory();
    }

    final exPath = _directory.path;
    print("Saved Path: $exPath");
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  static Future<String> get _localPath async {
    final String directory = await getExternalDocumentPath();
    return directory;
  }

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

  // String fnv1aHash(String str) {
  //   int deys = 1465595;
  //   const int dey = 109951;

  //   int hash = deys;
  //   for (int i = 0; i < str.length; i++) {
  //     // print('\n ${str.codeUnitAt(i)}');
  //     hash ^= str.codeUnitAt(i);
  //     hash *= dey;
  //   }
  //   hash = (hash >>> 0) &
  //       0x7FFFFFFF; // Ensure unsigned 31-bit integer (non-negative value)

  //   // Create a 10-digit hash using modulo operation with a large prime number
  //   hash = hash % 1000000000; // 10 digits (10^10)
  //   return hash.toString();
  // }
  final pdf = pw.Document();
  @override
  Widget build(BuildContext context) {
    File? file;

    ref.listen(notificationHandlerProvider, (previous, next) {});
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                CustomBox(
                  onTap: () => context.navigateTo(const AppListRoute()),
                  text: 'Nice to Have you  here!',//purely for testing purposes only!!
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomBox(
                  onTap: () => context.navigateTo(const WebViewRoute()),
                  text: 'Generate PDF',//purely for testing purposes
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 300,
                  child: PdfPreview(
                    build: (format) => pdf.save(),
                  ),
                ),
                CustomBox(
                    onTap: () async {
                      final topImageFile = await getImageFileFromAssets(
                          'images/pdf_top_img.png');
                      final topImage = pw.MemoryImage(
                        topImageFile.readAsBytesSync(),
                      );
                      final bottomImageFile =
                          await getImageFileFromAssets('images/acm.png');
                      final bottomImage = pw.MemoryImage(
                        bottomImageFile.readAsBytesSync(),
                      );
                      final font = await PdfGoogleFonts.nunitoBold();

                      pdf.addPage(pw.Page(
                          pageFormat: PdfPageFormat.undefined,
                          orientation: pw.PageOrientation.natural,
                          margin: pw.EdgeInsets.zero,
                          clip: true,
                          build: (pw.Context context) {
                            return pw.Center(
                              child: pw.Container(
                                color: PdfColors.white,
                                child: pw.Stack(
                                  alignment: pw.Alignment.center,
                                  children: [
                                    // pw.Image.asset(
                                    //     'assets/images/pdf_top_img.png'),
                                    pw.Image(bottomImage),
                                    pw.Padding(
                                      padding:
                                          const pw.EdgeInsets.only(top: 60),
                                      child: pw.Text(
                                        'Ayush Kumar Singh',
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 60,
                                            font: font),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                            // Center
                          }));
                      setState(() {});
                    },
                    text: "OK"),
                CustomBox(
                  //
                  onTap: () async {
                    final path = await _localPath;
                    final output = await getTemporaryDirectory();
                    final time = DateTime.now().day.toString() +
                        DateTime.now().minute.toString();
                    file = File("$path/$time.pdf");
                    await file!.writeAsBytes(await pdf.save());
                  },
                  text: 'Create PDF',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomBox(
                    onTap: () async {
                      String username = 'oyusflutterdev@gmail.com';
                      String password = 'wtbg voiw dbdl oupj';

                      final smtpServer = gmail(username, password);
                      final equivalentMessage = Message()
                        ..from = Address(username, 'Your name 😀')
                        ..recipients
                            .add(const Address('ayushkumarsingh0708@gmail.com'))
                        ..subject =
                            'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
                        ..text =
                            'This is the plain text.\nThis is line 2 of the text part.'
                        ..html =
                            '<h1>Test</h1>\n<p>Hey! Here is some HTML content</p>/>'
                        ..attachments = file != null
                            ? [
                                FileAttachment(File(file!.path))
                                  ..location = Location.attachment
                              ]
                            : [];
                      var connection = PersistentConnection(smtpServer);
                      if (file != null) {
                        await connection.send(equivalentMessage);
                      } else {
                        print("Something Went Wrong");
                      }

                      // close the connection
                      await connection.close();
                    },
                    text: 'mail pdf'),
                CustomBox(
                  onTap: () {
                    ref.read(appRepositoryProvider.notifier).logout();
                  },
                  text: 'Sign Out',
                ),
              ],
            ),
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
