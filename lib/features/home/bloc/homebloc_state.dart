part of 'homebloc_bloc.dart';

@immutable
sealed class HomeblocState {}
sealed class HomeActionState extends HomeblocState{}

final class HomeblocInitial extends HomeblocState {}

class OnSeeanalysisbuttonClick extends HomeActionState{}