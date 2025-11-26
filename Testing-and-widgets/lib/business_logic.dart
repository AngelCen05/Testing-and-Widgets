// 1. Thermostat
class Thermostat {
  double _temperature = 20.0;

  double get temperature => _temperature;

  void setTemperature(double temp) {
    if (temp < 15.0 || temp > 30.0) {
      throw ArgumentError('Temperatura fuera de rango (15.0 - 30.0)');
    }
    _temperature = temp;
  }
}

// 2. LEDController
class LEDController {
  bool _isOn = false;
  bool get isOn => _isOn;

  void turnOn() => _isOn = true;
  void turnOff() => _isOn = false;
}

// 3. DataValidator
class DataValidator {
  bool isValid(int value) {
    return value >= 1 && value <= 100;
  }
}

// 4. CommandProtocol
class CommandProtocol {
  String createCommand(String action, String data) {
    return '$action:$data';
  }
}

// 5. BatteryMonitor
class BatteryMonitor {
  bool isCritical(int level) {
    return level <= 10;
  }
}

// 6. LogBuffer
class LogBuffer {
  final List<String> _logs = [];

  List<String> getLogs() => _logs;

  void add(String message) {
    if (_logs.length >= 5) {
      _logs.removeAt(0); // Elimina el más antiguo
    }
    _logs.add(message);
  }
}