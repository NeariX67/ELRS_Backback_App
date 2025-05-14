import 'package:elrs_telem/models.dart';
import 'package:flutter/material.dart';

class VideoTransmitterWidget extends StatelessWidget {
  final VideoTransmitter videoTransmitter;
  const VideoTransmitterWidget(this.videoTransmitter, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListenableBuilder(
        listenable: videoTransmitter,
        builder:
            (context, child) => Column(
              children: [
                Text('Video Transmitter'),
                Text('originAddress: ${videoTransmitter.originAddress}'),
                Text('Status: ${videoTransmitter.status}'),
                Text('BandChannel: ${videoTransmitter.bandChannel}'),
                Text('Userfrequency: ${videoTransmitter.userFrequency}'),
                Text('PitModeAndPower: ${videoTransmitter.pitModeAndPower}'),
              ],
            ),
      ),
    );
  }
}
