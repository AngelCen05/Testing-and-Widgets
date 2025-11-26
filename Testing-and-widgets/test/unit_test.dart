import 'package:flutter_test/flutter_test.dart';
import 'package:test12/business_logic.dart'; // <--- CAMBIO IMPORTANTE: package:test12

void main() {
  group('Parte 1: Unit Testing Básico', () {
    
    // Thermostat Tests
    test('Thermostat should set temperature when within range', () {
      final thermostat = Thermostat();
      thermostat.setTemperature(20.0);
      expect(thermostat.temperature, 20.0);
    });

    test('Thermostat should throw ArgumentError when temperature is too high', () {
      final thermostat = Thermostat();
      expect(() => thermostat.setTemperature(31.0), throwsArgumentError);
    });

    // LEDController Tests
    test('LEDController should be true when turned on', () {
      final led = LEDController();
      led.turnOn();
      expect(led.isOn, isTrue);
    });

    // DataValidator Tests
    test('DataValidator should return false when value is out of range', () {
      final validator = DataValidator();
      expect(validator.isValid(101), isFalse);
    });

    // CommandProtocol Tests
    test('CommandProtocol should format string correctly when valid data provided', () {
      final protocol = CommandProtocol();
      final result = protocol.createCommand('ACTIVATE', 'PUMP');
      expect(result, 'ACTIVATE:PUMP');
    });

    // BatteryMonitor Tests
    test('BatteryMonitor should return true when level is exactly 10 (Critical)', () {
      final monitor = BatteryMonitor();
      expect(monitor.isCritical(10), isTrue);
    });

    test('BatteryMonitor should return false when level is 11', () {
      final monitor = BatteryMonitor();
      expect(monitor.isCritical(11), isFalse);
    });

    // LogBuffer Tests
    test('LogBuffer should keep only last 5 logs when more are added', () {
      final buffer = LogBuffer();
      for (int i = 1; i <= 6; i++) {
        buffer.add('Log $i');
      }
      expect(buffer.getLogs().length, 5);
      expect(buffer.getLogs().first, 'Log 2'); 
      expect(buffer.getLogs().last, 'Log 6');
    });
  });
}