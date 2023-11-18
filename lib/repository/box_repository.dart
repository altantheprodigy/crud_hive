import 'package:crud_hive/model/card.dart';
import 'package:hive/hive.dart';

class BoxRepository{
  static const String boxName = "CRUD";

  static openBox() async => await Hive.openBox<card>(boxName);

  static Box getBox() => Hive.box<card>(boxName);

  static closeBox() async => await Hive.box(boxName).close();
}