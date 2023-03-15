import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:herokuapp/Services/HerokuRepository.dart';

import '../Services/HerokuModel.dart';

part 'bloc_heroku_event.dart';

part 'bloc_heroku_state.dart';

class HerokuBloc extends Bloc<HerokuEvent, HerokuState> {
  final pizzaRepository = callApiHerokuPizza();

  HerokuBloc() : super(HerokuLoadingState()) {
    on<ClickEvent>((event, emit) async {
      emit(HerokuLoadingState());
      try {
        var apicall = await pizzaRepository.HerokuApi();
        emit(HerokuLoadedState(apicall!));
      } catch (e) {
        emit(HerokuErrorState(e.toString()));
      }
    });
  }
}
