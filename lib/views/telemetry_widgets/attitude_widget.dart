import 'package:elrs_telem/models.dart';
import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';

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
            (context, child) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: SceneBuilderWidget(
                builder:
                    () => SceneController(
                      front: ArtificialHorizon(attitude: attitude),
                      config: SceneConfig.games,
                    ),
                autoSize: true,
              ),
            ),
      ),
    );
  }
}
