import 'package:elrs_telem/models.dart';
import 'package:flutter/material.dart';

class DownLinkStatisticsWidget extends StatelessWidget {
  final LinkStatistics linkStatistics;
  const DownLinkStatisticsWidget(this.linkStatistics, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListenableBuilder(
        listenable: linkStatistics,
        builder:
            (context, child) => Column(
              children: [
                Text('Downlink Statistics'),
                Text('Rssi: ${linkStatistics.downlinkRssi} dBm'),
                Text('LinkQuality: ${linkStatistics.downlinkLinkQuality} %'),
                Text('Snr: ${linkStatistics.downlinkSnr} dB'),
              ],
            ),
      ),
    );
  }
}
