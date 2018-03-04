import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:stereo/stereo.dart';

void main() {
  const MethodChannel channel = const MethodChannel('com.twofind.stereo');

  final List<MethodCall> log = <MethodCall>[];

  Stereo stereo = new Stereo();

  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    log.add(methodCall);
  });

  tearDown(() => log.clear());

  // Tests that the method 'app.load' is correctly sent to the platform.
  test('load test', () async {
    final String path = 'dubstep.mp3';

    await stereo.load(path);

    expect(log, <Matcher>[
      isMethodCall('app.load', arguments: path),
      isMethodCall('app.isPlaying', arguments: null)
    ]);
  });

  // Tests that the method 'app.pause' is correctly sent to the platform.
  test('pause test', () async {
    await stereo.pause();

    expect(log, <Matcher>[
      isMethodCall('app.pause', arguments: null),
      isMethodCall('app.isPlaying', arguments: null)
    ]);
  });

  // Tests that the method 'app.play' is correctly sent to the platform.
  test('play test', () async {
    await stereo.play();

    expect(log, <Matcher>[
      isMethodCall('app.play', arguments: null),
      isMethodCall('app.isPlaying', arguments: null)
    ]);
  });

  // Tests that the method 'app.stop' is correctly sent to the platform.
  test('stop test', () async {
    await stereo.stop();

    expect(log, <Matcher>[
      isMethodCall('app.stop', arguments: null),
      isMethodCall('app.isPlaying', arguments: null)
    ]);
  });

  // No need to test if the method 'app.isPlaying' is correctly sent to the
  // platform since it's tested in each of the tests above.
}
