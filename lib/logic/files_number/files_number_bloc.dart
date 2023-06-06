import 'package:blur_hasher_app/constant/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'files_number_event.dart';
part 'files_number_state.dart';

class FilesNumberBloc extends Bloc<FilesNumberEvent, FilesNumberState> {
  FilesNumberBloc() : super(const FilesNumberInitial(null)) {
    on<FilesNumberEvent>((event, emit) {
      emit(const FilesNumberInitial(null));
    });
    on<FilesNumberChangeEvent>(
      (event, emit) => emit(
        FilesNumberInitial(event.number),
      ),
    );
  }
}
