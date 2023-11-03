import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'uploadbloc_event.dart';
part 'uploadbloc_state.dart';

class UploadblocBloc extends Bloc<UploadblocEvent, UploadblocState> {
  UploadblocBloc() : super(UploadblocInitial()) {
    on<UploadblocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
