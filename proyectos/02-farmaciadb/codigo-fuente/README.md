# FarmaciaDB — Sistema Relacional en Microsoft SQL Server

## 📖 Descripción
Base de datos relacional para control de inventario de medicamentos, lotes farmacéuticos, fechas de caducidad, auditoría y facturación con integridad transaccional.

## 🛠️ Características Técnicas
- **Motor:** Microsoft SQL Server 2019 / 2022 / Azure SQL
- **Integridad Referencial:** Llaves Foráneas (FK), restricciones CHECK y DEFAULT
- **Optimización:** Índices no agrupados compuestos e índices con cláusula `INCLUDE`
- **Lógica en el Servidor:** Stored Procedures con manejo transaccional `BEGIN TRANSACTION` / `TRY...CATCH`
- **Automatización:** Triggers para reducción atómica de stock y bitácora de auditoría
- **Reportería:** Vistas calculadas para prevención de pérdidas por vencimiento

## 🚀 Cómo ejecutar en Visual Studio 2022
1. Abre **Visual Studio 2022**.
2. Ve a la pestaña **Ver -> Explorador de objetos de SQL Server** (SQL Server Object Explorer).
3. Conéctate a tu instancia local (`(localdb)\MSSQLLocalDB` o `localhost`).
4. Haz clic derecho en *Databases* -> *New Query* y ejecuta los archivos en orden:
   - `01_CreacionTablas_DDL.sql`
   - `02_InsercionDatos_DML.sql`
   - `03_ProcedimientosAlmacenados_SP.sql`
   - `04_Triggers_Vistas.sql`
