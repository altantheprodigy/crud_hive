import 'package:hive_flutter/adapters.dart';

part 'card.g.dart';

@HiveType(typeId: 0)
class card{
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? saldo;
  @HiveField(2)
  final String? image;

  card({this.name, this.saldo, this.image});
}