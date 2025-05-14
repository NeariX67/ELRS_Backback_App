import 'package:elrs_telem/models.dart';
import 'package:flutter/material.dart';

class UpLinkStatisticsWidget extends StatelessWidget {
  final LinkStatistics linkStatistics;
  const UpLinkStatisticsWidget(this.linkStatistics, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListenableBuilder(
        listenable: linkStatistics,
        builder:
            (context, child) => Column(
              children: [
                Text('Uplink Statistics'),
                Text('Rssi1: ${linkStatistics.uplinkRssi1} dBm'),
                Text('Rssi2: ${linkStatistics.uplinkRssi2} dBm'),
                Text('LinkQuality: ${linkStatistics.uplinkLinkQuality} %'),
                Text('Snr: ${linkStatistics.uplinkSnr} dB'),
                Text('activeAntenna: ${linkStatistics.activeAntenna}'),
                Text('rfMode: ${linkStatistics.rfMode} Hz'),
                Text('TxPower: ${linkStatistics.uplinkTxPower} mW'),
              ],
            ),
      ),
    );
  }
}
