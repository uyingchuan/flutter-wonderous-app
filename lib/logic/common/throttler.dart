import 'dart:async';

import 'package:flutter/material.dart';

class Throttler {
  Throttler(this.interval);
  final Duration interval;

  VoidCallback? _action;
  Timer? _timer;

  void call(VoidCallback action, {bool immediateCall = true}) {
    _action = action;
    if (_timer == null) {
      if (immediateCall) {
        _callAction();
      }
      _timer = Timer(interval, _callAction);
    }
  }

  void _callAction() {
    _action?.call();
    _timer = null;
  }

  void reset() {
    _action = null;
    _timer = null;
  }
}
