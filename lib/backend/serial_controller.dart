import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:get/get.dart';

class SerialController extends GetxController {
  final String selectedPort;

  SerialPort? serialPort;
  SerialPortReader? reader;
  StreamSubscription? readerStream;

  void Function(Map<String, dynamic> json) onDataReceived;

  SerialController({required this.selectedPort, required this.onDataReceived});

  StringBuffer buffer = StringBuffer();

  @override
  Future<void> onInit() async {
    super.onInit();

    serialPort = SerialPort(selectedPort);
    bool success = serialPort!.openRead();
    serialPort!.config =
        SerialPortConfig()
          ..baudRate = 115200
          ..parity = SerialPortParity.none
          ..bits = 8
          ..stopBits = 1
          ..setFlowControl(SerialPortFlowControl.none);
    if (success) {
      reader = SerialPortReader(serialPort!);
      readerStream = reader!.stream.listen(
        (data) {
          _onData(data);
        },
        onError: (error) {
          // Handle error
          print('Error: $error');
        },
        cancelOnError: false,
      );
    } else {
      print('Failed to open port');
    }
  }

  @override
  void onClose() {
    super.onClose();
    readerStream?.cancel();
    reader?.close();
    serialPort?.close();
    serialPort?.dispose();
    serialPort = null;
    reader = null;
  }

  void _onData(Uint8List data) {
    // Handle incoming data
    if (data.isNotEmpty) {
      // print('Received data: ${utf8.decode(data)}');
      if (data.first == 0x7B) {
        // {
        buffer.clear();
        buffer.write(utf8.decode(data));
      } else {
        buffer.write(utf8.decode(data));
      }
      if (data.last == 0x7D) {
        // }
        String jsonString = buffer.toString();
        if (jsonString.contains("}{")) {
          // Handle the case where there are multiple JSON objects
          List<String> jsonStrings = jsonString.split("}{");
          for (String json in jsonStrings) {
            if (json.isEmpty) {
              continue;
            }
            if (!json.startsWith("{")) {
              json = '{$json';
            }
            if (!json.endsWith("}")) {
              json = '$json}';
            }
            _onCompleteJson(json);
          }
        } else {
          _onCompleteJson(jsonString);
        }
      }
    }
  }

  void _onCompleteJson(String json) {
    Map<String, dynamic> jsonData;
    try {
      jsonData = jsonDecode(json);
    } catch (e) {
      print('Error parsing JSON: $e');
      return;
    }
    onDataReceived(jsonData);
  }
}
