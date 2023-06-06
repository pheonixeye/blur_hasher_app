part of 'files_number_bloc.dart';

@immutable
abstract class FilesNumberState {
  final NumberOfFiles? number;

  const FilesNumberState(this.number);
}

class FilesNumberInitial extends FilesNumberState {
  final NumberOfFiles? number;

  const FilesNumberInitial(this.number) : super(null);
}
