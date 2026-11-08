# Matriz de Evaluación de Madurez de Gobierno TI — AgroVerde S.A.
**Marco de Referencia:** ISACA COBIT 2019 / CMMI Capability Levels (0 - 5)

---

## 1. Resumen Ejecutivo
AgroVerde S.A. es una corporación dedicada a la producción y exportación agroindustrial que ha iniciado su proceso de agricultura de precisión (sensores IoT de humedad de suelo, telemetría de tractores autónomos y ERP en la nube).

Para garantizar que estas inversiones tecnológicas generen valor de negocio, mitiguen riesgos cibernéticos y cumplan con regulaciones de exportación, se aplicó el modelo de capacidad de procesos de **COBIT 2019**.

---

## 2. Escala de Capacidad de Procesos (CMMI)
- **Nivel 0 (Incompleto):** El proceso no se ejecuta o no alcanza su objetivo.
- **Nivel 1 (Inicial):** El proceso alcanza de manera intuitiva su propósito mediante actividades ad-hoc.
- **Nivel 2 (Gestionado):** El proceso se planifica, supervisa y documenta a nivel de proyecto.
- **Nivel 3 (Definido):** El proceso está estandarizado e integrado en toda la organización.
- **Nivel 4 (Cuantitativo):** El proceso se mide con métricas estadísticas y KPIs predictivos.
- **Nivel 5 (Optimizado):** Mejora continua sistemática e innovación automatizada.

---

## 3. Matriz de Brechas por Dominio Evaluado

| Dominio COBIT | Proceso | Nivel Actual | Nivel Objetivo | Brecha (Gap) | Impacto de Riesgo |
|:-------------:|:--------|:------------:|:--------------:|:------------:|:-----------------:|
| **APO** | **APO12: Gestión del Riesgo** | 2 (Gestionado) | 4 (Cuantitativo) | -2 Niveles | **ALTO**: Fallas en sensores pueden parar riego de 500 hectáreas sin alerta temprana. |
| **APO** | **APO13: Seguridad de la Info.** | 1 (Inicial) | 4 (Cuantitativo) | -3 Niveles | **CRÍTICO**: Dispositivos IoT sin segmentación pueden ser vector de ransomware. |
| **BAI** | **BAI03: Soluciones TI** | 3 (Definido) | 4 (Cuantitativo) | -1 Nivel | **MEDIO**: Desarrollo ágil existente pero falta automatización de pruebas de carga. |
| **DSS** | **DSS05: Operaciones Seguras** | 2 (Gestionado) | 4 (Cuantitativo) | -2 Niveles | **ALTO**: Respaldos manuales; se requiere RTO y RPO menores a 2 horas. |
| **MEA** | **MEA01: Monitoreo Desempeño** | 3 (Definido) | 4 (Cuantitativo) | -1 Nivel | **MEDIO**: Tableros PowerBI existentes pero sin correlación predictiva de incidentes. |
