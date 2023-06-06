part of 'files_number_bloc.dart';

@immutable
abstract class FilesNumberEvent {
  final NumberOfFiles? number;

  const FilesNumberEvent(this.number);
}

class FilesNumberChangeEvent extends FilesNumberEvent {
  @override
  final NumberOfFiles? number;

  const FilesNumberChangeEvent(this.number) : super(null);
}
