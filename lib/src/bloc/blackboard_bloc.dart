import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:digital_blackboard/src/models/createbbitem.dart';
import 'package:digital_blackboard/src/repository/blackboardRepo.dart';
import 'package:meta/meta.dart';

import '../models/bbitem.dart';

part 'blackboard_event.dart';
part 'blackboard_state.dart';

class BlackBoardBloc extends Bloc<BlackBoardEvent, BlackBoardState> {
  BlackboardRepository repo = BlackboardRepository();
  BlackBoardBloc() : super(BlackBoardInitial()) {

    on<BlackBoardEvent>((event, emit) async {
      if (event is BlackBoardInitEvent) {
        try {
          emit(BlackBoardLoadingState());
          List<BBItem> result = await repo.getAllItems();
          emit(BlackBoardLoadedState(resultList: result));
        } catch (e) {
          emit(BlackBoardErrorState(msg: e.toString()));
          print(e.toString());
        }
      }
      if (event is BlackBoardGetAllItemsEvent) {
        try {
          emit(BlackBoardLoadingState());
          List<BBItem> result = await repo.getAllItems();
          emit(BlackBoardLoadedState(resultList: result));
        } catch (e) {
          emit(BlackBoardErrorState(msg: e.toString()));
          print(e.toString());
        }
      }
      if (event is BlackBoardAddItemEvent) {
        emit(BlackBoardInProgressState());
        try {
          await repo.addItem(item: event.item, imagepost: event.imgPost, image: event.image);
          List<BBItem> result = await repo.getAllItems();
          emit(BlackBoardLoadedState(resultList: result));
        } catch (e) {
          print("Error: "+ e.toString());
          emit(BlackBoardErrorState(msg: e.toString()));

        }
        
        
      }
    });
  }
}
