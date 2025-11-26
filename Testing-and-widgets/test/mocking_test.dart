import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
// CAMBIOS IMPORTANTES AQUÍ ABAJO:
import 'package:test12/sensor_interface.dart';
import 'package:test12/iot_controller.dart';

// Crear MockSensor que implemente las interfaces
class MockHumiditySensor extends Mock implements HumiditySensor {}
class MockCOxDetector extends Mock implements COxDetector {}
class MockLightDetector extends Mock implements LightDetector {}

void main() {
  late IotController controller;
  late MockHumiditySensor mockHumidity;
  late MockCOxDetector mockCO;
  late MockLightDetector mockLight;

  setUp(() {
    mockHumidity = MockHumiditySensor();
    mockCO = MockCOxDetector();
    mockLight = MockLightDetector();
    
    controller = IotController(
      humiditySensor: mockHumidity,
      coDetector: mockCO,
      lightDetector: mockLight,
    );
  });

  group('Parte 2: Mocking Tests', () {
    
    test('should return humidity value when sensor reads successfully', () async {
      when(() => mockHumidity.readValue()).thenAnswer((_) async => 45.5);
      final result = await controller.getHumidity();
      expect(result, 45.5);
    });

    test('should return -1.0 when CO sensor throws exception', () async {
      when(() => mockCO.readValue()).thenThrow(Exception('Sensor Error'));
      final result = await controller.getCOLevel();
      expect(result, -1.0);
    });

    test('should trigger internal action when light level is critical', () async {
      when(() => mockLight.readValue()).thenAnswer((_) async => 5.0);
      await controller.checkLightSensor();
      verify(() => mockLight.readValue()).called(1);
      expect(controller.actionTriggered, isTrue);
    });

    test('should set isLoading true while syncing', () async {
      final future = controller.syncData();
      expect(controller.isLoading, isTrue);
      await future;
      expect(controller.isLoading, isFalse);
    });

    test('should fail with TimeoutException when task takes too long', () async {
      expect(
        () async => await controller.heavyComputation().timeout(const Duration(milliseconds: 100)),
        throwsA(isA<TimeoutException>()),
      );
    });
  });
}