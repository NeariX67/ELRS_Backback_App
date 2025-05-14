import 'package:elrs_telem/models.dart';
import 'package:flutter/material.dart';

class Template extends StatelessWidget {
  final Attitude attitude = Attitude(roll: 0, pitch: 0, yaw: 0);
  Template({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListenableBuilder(
        listenable: attitude,
        builder: (context, child) => Placeholder(),
      ),
    );
  }
}
