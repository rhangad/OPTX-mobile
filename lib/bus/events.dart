import 'package:event_bus/event_bus.dart';
EventBus eventBus = EventBus();

class UpdateVersionEvent {
  String text;

  UpdateVersionEvent(this.text);
}

class ResetVersionEvent {
  ResetVersionEvent();
}