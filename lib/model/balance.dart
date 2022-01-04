import 'package:hive/hive.dart';

part 'balance.g.dart';

@HiveType(typeId: 1)
class Balance {
  Balance({required this.value});
  @HiveField(0)
  int value;
}
