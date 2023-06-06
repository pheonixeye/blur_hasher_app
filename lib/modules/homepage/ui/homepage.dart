import 'package:blur_hasher_app/components/info_snackbar.dart';
import 'package:blur_hasher_app/constant/constant.dart';
import 'package:blur_hasher_app/modules/homepage/ui/widgets/files_number_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
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
          const Padding(
            padding: EdgeInsets.all(18),
            child: Row(
              children: [
                Text('One / Many Files :'),
                FilesNumberCard(numberOfFiles: NumberOfFiles.one),
                FilesNumberCard(numberOfFiles: NumberOfFiles.many),
              ],
            ),
          ),
          //output folder path
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                const Text('Output Folder Path :'),
                Flexible(
                  child: Card(
                    //TODO: add state to textfield
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: controller,
                        enabled: false,
                      ),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.browse_gallery),
                  label: const Text('Browse'),
                  onPressed: () async {
                    final String? directory =
                        await FilePicker.platform.getDirectoryPath(
                      dialogTitle: 'Select output directory',
                      lockParentWindow: true,
                    );
                    if (directory != null) {
                      setState(() {
                        controller.text = directory;
                      });
                    } else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            infoSnackbar('No directory selected.'));
                      }
                    }
                  },
                ),
              ],
            ),
          ),
          // pick image(s)
          Padding(
            padding: const EdgeInsets.all(18),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.file_copy),
              label: const Text('Pick Image(s)'),
            ),
          ),
        ],
      ),
    );
  }
}
