import 'dart:typed_data';

class CommunicationModel {
  String? event;
  Uint8List? data;

  CommunicationModel._communicationModel({this.event, this.data});

  factory CommunicationModel.fromJson(Map<String, dynamic> json) {
    return CommunicationModel._communicationModel(
      event: json['event'] as String?,
      data: Uint8List.fromList(json['data'].cast<int>()),
    );
  }
}
