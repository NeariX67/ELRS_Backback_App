import 'package:elrs_telem/models.dart';
import 'package:flutter/material.dart';

import 'artificial_horizon.dart';

class AttitudeWidget extends StatelessWidget {
  final Attitude attitude;
  const AttitudeWidget(this.attitude, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListenableBuilder(
        listenable: attitude,
        builder:
            (context, child) =>
                ArtificialHorizon(pitch: attitude.pitch, roll: attitude.roll),
      ),
    );
  }
}
