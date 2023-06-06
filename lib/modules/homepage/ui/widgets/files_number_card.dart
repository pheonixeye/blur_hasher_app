import 'package:blur_hasher_app/constant/constant.dart';
import 'package:blur_hasher_app/logic/files_number/files_number_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilesNumberCard extends StatelessWidget {
  const FilesNumberCard({super.key, required this.numberOfFiles});
  final NumberOfFiles numberOfFiles;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: BlocBuilder<FilesNumberBloc, FilesNumberState>(
          builder: (context, state) {
            return Card(
              elevation: numberOfFiles == state.number ? 0 : 8,
              color:
                  numberOfFiles == state.number ? Colors.orange : Colors.white,
              child: RadioListTile<NumberOfFiles>(
                value: numberOfFiles,
                groupValue: state.number,
                onChanged: (val) {
                  context
                      .read<FilesNumberBloc>()
                      .add(FilesNumberChangeEvent(numberOfFiles));
                },
                title: Text(numberOfFiles.name.toUpperCase()),
              ),
            );
          },
        ),
      ),
    );
  }
}
