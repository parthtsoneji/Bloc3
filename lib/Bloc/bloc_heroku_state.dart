part of 'bloc_heroku_bloc.dart';

abstract class HerokuState extends Equatable {
  const HerokuState();
}

class HerokuLoadingState extends HerokuState {
  @override
  List<Object> get props => [];
}

class HerokuClickState extends HerokuState {
  @override
  List<Object> get props => [];
}
class HerokuLoadedState extends HerokuState {

  final HerokuPizza heroku;

  HerokuLoadedState(this.heroku);
  @override
  List<Object> get props => [heroku];
}
class HerokuErrorState extends HerokuState {
  final String messgae;

  HerokuErrorState(this.messgae);

  @override
  List<Object> get props => [messgae];
}