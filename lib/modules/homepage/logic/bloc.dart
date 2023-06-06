import 'package:blur_hasher_app/logic/files_number/files_number_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

final List<SingleChildWidget> providers = [
  BlocProvider<FilesNumberBloc>(
    create: (BuildContext context) => FilesNumberBloc(),
  ),
];
