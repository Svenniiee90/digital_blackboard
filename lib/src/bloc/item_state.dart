part of 'item_bloc.dart';

@immutable
sealed class ItemState {}

final class ItemInitial extends ItemState {}

final class ItemLoadingSuccessState extends ItemState {
  final List<BBItem> resultList;

  ItemLoadingSuccessState({required this.resultList});
}

