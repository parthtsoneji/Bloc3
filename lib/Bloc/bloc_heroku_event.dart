part of 'bloc_heroku_bloc.dart';

abstract class HerokuEvent extends Equatable {
  const HerokuEvent();
}

class ClickEvent extends HerokuEvent{

  final HerokuPizza herokuPizza;

  ClickEvent(this.herokuPizza);
  @override
  List<Object?> get props =>  [herokuPizza];

}
