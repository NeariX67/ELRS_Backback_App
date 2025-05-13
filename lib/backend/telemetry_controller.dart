import 'dart:typed_data';

import 'package:elrs_telem/telem_packet.dart';
import 'package:elrs_telem/elrs_telem.dart';

class TelemetryController {
  void onTelemetryDataReceived(Uint8List data) {
    TelemetryPacket? packet = ElrsTelem.parsePacket(data);
    if (packet != null) {
      ElrsTelem.processPacket(packet);
    } else {
      print('Invalid packet received');
    }
  }
}
