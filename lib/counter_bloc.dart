import 'dart:async';

enum CounterAction {
  Increment,
  Decrement,
  Reset,
}

class CounterBLoC {
  int counter = 0;
  final _stateStreamController = StreamController<int>.broadcast();

  StreamSink<int> get counterSink => _stateStreamController.sink;

  Stream<int> get counterStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<CounterAction>();

  StreamSink<CounterAction> get eventSink => _eventStreamController.sink;

  Stream<CounterAction> get eventStream => _eventStreamController.stream;

  CounterBLoC() {
    counterStream.listen((event) {});

    eventStream.listen((event) {
      if (event == CounterAction.Increment) {
        counter++;
      }
      if (event == CounterAction.Decrement) {
        counter--;
      }
      if (event == CounterAction.Reset) {
        counter = 0;
      }
      counterSink.add(counter);
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
