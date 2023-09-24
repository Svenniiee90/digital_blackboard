import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/bbitem.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc() : super(ItemInitial()) {
    on<ItemEvent>((event, emit) {
      if (event is ItemInitEvent) {

      }
    });
  }
}
