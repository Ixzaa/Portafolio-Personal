# Plan de Acción y Hoja de Ruta de Gobernanza TI — AgroVerde S.A.

## Fase 1: Remediación Inmediata de Ciberseguridad (Meses 1 - 3)
- **Objetivo (APO13):** Mitigar vulnerabilidades críticas en la red de telemetría IoT de campo.
- **Acciones:**
  1. Segmentación de red VLAN exclusiva para dispositivos agrícolas IoT.
  2. Implementación de autenticación multifactor (MFA) obligatoria para el acceso al ERP.
  3. Contratación de auditoría de pruebas de penetración externa (Pentesting).

## Fase 2: Automatización de Respaldo y Continuidad del Negocio (Meses 4 - 6)
- **Objetivo (DSS05 & APO12):** Asegurar continuidad operativa del empaque y despacho ante desastres.
- **Acciones:**
  1. Configuración de respaldos inmutables en la nube (Azure Backup / AWS S3 Glacier).
  2. Definición formal de RTO (Recovery Time Objective) <= 2 horas y RPO <= 30 minutos.
  3. Ejecución de un simulacro de contingencia eléctrica y caída de enlace satelital en plantas.

## Fase 3: Estandarización de Calidad y KPIs de Rendimiento (Meses 7 - 12)
- **Objetivo (BAI03 & MEA01):** Cerrar el ciclo con medición cuantitativa y predictiva.
- **Acciones:**
  1. Integración de SonarQube en el pipeline CI/CD para inspección continua de código.
  2. Tablero ejecutivo con alertas automáticas ante desviaciones de SLAs de los proveedores tecnológicos de campo.
