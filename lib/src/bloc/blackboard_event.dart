part of 'blackboard_bloc.dart';

@immutable
sealed class BlackBoardEvent {}

class BlackBoardInitEvent extends BlackBoardEvent {}

class BlackBoardGetAllItemsEvent extends BlackBoardEvent {}

class BlackBoardAddItemEvent extends BlackBoardEvent {
  final CreateBBItem item; 
  final bool imgPost;
  final File? image;
  BlackBoardAddItemEvent({required this.item, required this.imgPost, this.image});
}

class BlackBoardRefreshEvent extends BlackBoardEvent {
  final Function callback;
  BlackBoardRefreshEvent({required this.callback});
}
