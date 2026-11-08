import 'package:flutter/foundation.dart';

class Recordatorio {
  final String id;
  final String nombreMedicamento;
  final String dosis;
  final String hora;
  bool tomado;

  Recordatorio({
    required this.id,
    required this.nombreMedicamento,
    required this.dosis,
    required this.hora,
    this.tomado = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombreMedicamento': nombreMedicamento,
    'dosis': dosis,
    'hora': hora,
    'tomado': tomado,
  };

  factory Recordatorio.fromJson(Map<String, dynamic> json) => Recordatorio(
    id: json['id'],
    nombreMedicamento: json['nombreMedicamento'],
    dosis: json['dosis'],
    hora: json['hora'],
    tomado: json['tomado'] ?? false,
  );
}

class RecordatoriosProvider with ChangeNotifier {
  final List<Recordatorio> _items = [
    Recordatorio(id: '1', nombreMedicamento: 'Losartán', dosis: '50mg', hora: '08:00 AM'),
    Recordatorio(id: '2', nombreMedicamento: 'Omega 3', dosis: '1 Cápsula', hora: '01:30 PM'),
    Recordatorio(id: '3', nombreMedicamento: 'Magnesio Quelado', dosis: '400mg', hora: '09:00 PM'),
  ];

  List<Recordatorio> get items => [..._items];

  void toggleTomado(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _items[index].tomado = !_items[index].tomado;
      notifyListeners();
    }
  }

  void agregarRecordatorio(Recordatorio nuevo) {
    _items.add(nuevo);
    notifyListeners();
  }
}
