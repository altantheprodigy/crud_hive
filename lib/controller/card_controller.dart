import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';

import '../model/card.dart';
import '../repository/box_repository.dart';

class CardController extends GetxController {
  final Box _observableBox = BoxRepository.getBox();

  Box get observableBox => _observableBox;

  //gets count of notes
  int get cardsCount => _observableBox.length;

  createNote({required card kartu}) {
    _observableBox.add(kartu);
    update();
  }

  updateNote({required int index, required card kartu}) {
    _observableBox.putAt(index, kartu);
    update();
  }

  deleteNote({required int index}) {
    _observableBox.deleteAt(index);
    update();
  }
}