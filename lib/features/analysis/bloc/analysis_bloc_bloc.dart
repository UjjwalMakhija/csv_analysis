import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'analysis_bloc_event.dart';
part 'analysis_bloc_state.dart';

class AnalysisBlocBloc extends Bloc<AnalysisBlocEvent, AnalysisBlocState> {
  AnalysisBlocBloc() : super(AnalysisBlocInitial()) {
    on<AnalysisBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
