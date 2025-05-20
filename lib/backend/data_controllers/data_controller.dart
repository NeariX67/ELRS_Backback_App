import 'package:get/get.dart';

abstract class DataController extends GetxController {
  void Function(Map<String, dynamic> json) onDataReceived;

  DataController({required this.onDataReceived});
}
