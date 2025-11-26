import 'sensor_interface.dart';

class IotController {
  final HumiditySensor humiditySensor;
  final COxDetector coDetector;
  final LightDetector lightDetector;
  
  // Propiedad para probar el estado de carga
  bool isLoading = false;
  bool actionTriggered = false; // Para verificar llamadas internas

  // Inyección de Dependencias (DI)
  IotController({
    required this.humiditySensor,
    required this.coDetector,
    required this.lightDetector,
  });

  // Método simple asíncrono
  Future<double> getHumidity() async {
    return await humiditySensor.readValue();
  }

  // Método con manejo de errores
  Future<double> getCOLevel() async {
    try {
      return await coDetector.readValue();
    } catch (e) {
      return -1.0; // Fallback value en caso de error
    }
  }

  // Método que verifica condiciones críticas
  Future<void> checkLightSensor() async {
    final val = await lightDetector.readValue();
    if (val < 10) {
      _triggerEmergencyLights();
    }
  }

  void _triggerEmergencyLights() {
    actionTriggered = true;
  }

  // Método para simular latencia
  Future<void> syncData() async {
    isLoading = true;
    // Simulamos una operación que toma tiempo real (en producción)
    // En el test, mockeamos el tiempo.
    await Future.delayed(const Duration(seconds: 1)); 
    isLoading = false;
  }

  // Método para Timeout
  Future<void> heavyComputation() async {
    // Simula una tarea que tarda 10 segundos
    await Future.delayed(const Duration(seconds: 10));
  }
}