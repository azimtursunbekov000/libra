import 'dart:async';

import 'package:stack_trace/stack_trace.dart';

import 'core/util/logger.dart';
import 'feature/initialization/runner.dart';

void main([List<String>? args]) => runZonedGuarded<Future<void>>(
  () async {
    await Runner.initializeAndRun();
  },
  (error, stackTrace) {
    logger.e(
      'runZonedGuarded.onError',
      error: error,
      stackTrace: Chain.forTrace(stackTrace),
    );
  },
);
