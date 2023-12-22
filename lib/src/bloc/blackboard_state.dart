part of 'blackboard_bloc.dart';

@immutable
sealed class BlackBoardState {}

final class BlackBoardInitial extends BlackBoardState {}

final class BlackBoardLoadingState extends BlackBoardState {}

final class BlackBoardLoadedState extends BlackBoardState {
  final List<BBItem> resultList;
  BlackBoardLoadedState({required this.resultList});
}

final class BlackBoardInProgressState extends BlackBoardState {}

final class BlackBoardErrorState extends BlackBoardState {
  final String msg;
  BlackBoardErrorState({required this.msg});
}

