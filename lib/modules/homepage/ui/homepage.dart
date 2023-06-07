// import 'package:blur_hasher_app/components/info_snackbar.dart';
// import 'package:blur_hasher_app/constant/constant.dart';
// import 'package:blur_hasher_app/modules/homepage/ui/widgets/files_number_card.dart';
// import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'dart:io';

import 'package:blur_hasher_app/components/info_snackbar.dart';
import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image/image.dart' as img;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final inputController = TextEditingController();
  final outputController = TextEditingController();
  int counter = 0;
  @override
  void dispose() {
    inputController.dispose();
    outputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate BlurHash'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return const AboutDialog(
                    applicationName: 'BlurHash Generator',
                    applicationVersion: '1.0.0',
                    applicationLegalese: '''
                    Copyright 2023 drkaz.dev. All rights reserved.
                    
                    * Redistributions of source code must retain the above copyright
                    notice, this list of conditions and the following disclaimer.
 
                    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS''',
                  );
                },
              );
            },
            icon: const Icon(Icons.info),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          //select single or multiple files
          // const Padding(
          //   padding: EdgeInsets.all(18),
          //   child: Row(
          //     children: [
          //       Text('One / Many Files :'),
          //       FilesNumberCard(numberOfFiles: NumberOfFiles.one),
          //       FilesNumberCard(numberOfFiles: NumberOfFiles.many),
          //     ],
          //   ),
          // ),
          //output folder path
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                const Text('Input Folder Path :'),
                Flexible(
                  child: Card(
                    //TODO: add state to textfield
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: inputController,
                        enabled: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                const Text('Output Folder Path :'),
                Flexible(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: outputController,
                        enabled: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // pick image(s)
          Padding(
            padding: const EdgeInsets.all(18),
            child: ElevatedButton.icon(
              onPressed: () async {
                await EasyLoading.show(
                  status: 'LOADING...',
                  indicator: CircularProgressIndicator.adaptive(
                    value: counter.toDouble() / 100,
                  ),
                );
                final inputPath = inputController.text;
                final outputPath = outputController.text;
                final Stream<FileSystemEntity> files =
                    Directory(inputPath).list();
                final jsonFile = File('$outputPath/result_test.json')
                  ..createSync();
                List<Map<String, dynamic>> info = [];
                await for (FileSystemEntity e in files) {
                  final data = File(e.path);
                  final image = img.decodeJpg(await data.readAsBytes());
                  final blurHash =
                      BlurHash.encode(image!, numCompX: 4, numCompY: 3);

                  info.add({
                    'path': e.uri.toFilePath(windows: true),
                    'hash': blurHash.hash,
                  });

                  setState(() {
                    counter++;
                  });
                  print('done $counter');
                }
                await jsonFile.writeAsString(
                  jsonEncode(info),
                  mode: FileMode.append,
                );
                // files.map((e) async {}).toList();
                print(files);
                await EasyLoading.dismiss().then((value) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(infoSnackbar('Processing Complete...'));
                  }
                });
              },
              icon: const Icon(Icons.file_copy),
              label: const Text('Process files'),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Center(
            child: Text('done : $counter'),
          ),
        ],
      ),
    );
  }
}
