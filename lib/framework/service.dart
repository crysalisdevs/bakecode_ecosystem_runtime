import 'dart:async';

import 'package:bakecode/framework/context.dart';
import 'package:bakecode/framework/mqtt.dart';
import 'package:meta/meta.dart';

abstract class BakeCodeService {
  /// Default constructor for [BakeCodeService].
  ///
  /// Registers onMessage stream controller's sink for listening to messages
  /// related to [context].
  BakeCodeService() {
    Mqtt.addListener(topic: context.path, sink: _onMessageSink);
  }

  /// Provides a handle for BakeCode services.
  ///
  /// Context makes every [BakeCodeService]s to be identifiable.
  Context get context;

  /// Publishes a [message] on [topic].
  ///
  /// By default [topic] is [this.context].
  @mustCallSuper
  void publish(String message, {Context to}) =>
      Mqtt.publish(message, to: (to ?? context).path);

  /// Sink of [_onMessageStreamController].
  StreamSink<String> get _onMessageSink => _onMessageStreamController.sink;

  /// Stream for receiving messages for my context.
  Stream<String> get onMessage => _onMessageStreamController.stream;

  /// Stream controller for on message events from [Mqtt].
  final _onMessageStreamController = StreamController<String>();
}