import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recordatorio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final recordatoriosData = Provider.of<RecordatoriosProvider>(context);
    final lista = recordatoriosData.items;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.between,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Hola de nuevo,', style: TextStyle(color: Colors.grey, fontSize: 13)),
                      Text('Carlos Mendoza', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const CircleAvatar(
                    backgroundColor: Color(0xFF06B6D4),
                    child: Text('CM', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Cita Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0284C7), Color(0xFF06B6D4)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('PRÓXIMA CONSULTA', style: TextStyle(fontSize: 11, letterSpacing: 1.1, color: Colors.white70)),
                    SizedBox(height: 4),
                    Text('Dra. Elena Ruiz (Cardiología)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 4),
                    Text('Mañana, 10:30 AM • Hospital Central', style: TextStyle(fontSize: 12, color: Colors.white)),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Medicamentos List Header
              Row(
                mainAxisAlignment: MainAxisAlignment.between,
                children: const [
                  Text('Medicamentos de Hoy', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Text('Ver todos', style: TextStyle(color: Color(0xFF06B6D4), fontSize: 12)),
                ],
              ),
              const SizedBox(height: 10),

              // ListView de recordatorios
              Expanded(
                child: ListView.separated(
                  itemCount: lista.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (ctx, i) {
                    final item = lista[i];
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(
                          '${item.nombreMedicamento} ${item.dosis}',
                          style: TextStyle(
                            decoration: item.tomado ? TextDecoration.lineThrough : null,
                            color: item.tomado ? Colors.grey : Colors.white,
                          ),
                        ),
                        subtitle: Text(item.hora, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        trailing: IconButton(
                          icon: Icon(
                            item.tomado ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: item.tomado ? const Color(0xFF06B6D4) : Colors.grey,
                          ),
                          onPressed: () => recordatoriosData.toggleTomado(item.id),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: const Color(0xFF0F172A),
        selectedItemColor: const Color(0xFF06B6D4),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Citas'),
          BottomNavigationBarItem(icon: Icon(Icons.medication), label: 'Recetas'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
