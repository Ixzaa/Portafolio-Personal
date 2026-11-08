-- ===================================================================
-- PROYECTO: FarmaciaDB
-- ARCHIVO: 02_InsercionDatos_DML.sql
-- ===================================================================

USE FarmaciaDB;
GO

-- Inserción de Laboratorios
INSERT INTO Laboratorios (NombreLaboratorio, PaisOrigen, Contacto, Telefono) VALUES
('Genfar Labs', 'Colombia', 'contacto@genfar.com', '+57-1-800-4363'),
('Bayer S.A.', 'Alemania', 'ventas@bayer.com', '+49-214-30-1'),
('Pfizer Pharmaceuticals', 'Estados Unidos', 'info@pfizer.com', '+1-800-879-7007'),
('MK Farmacéutica', 'Colombia', 'soporte@mk.com', '+57-2-880-9900'),
('Sandoz Novartis', 'Suiza', 'info@sandoz.com', '+41-61-324-1111');
GO

-- Inserción de Medicamentos
INSERT INTO Medicamentos (CodigoBarras, NombreComercial, PrincipioActivo, Concentracion, FormaFarmaceutica, RequiereReceta, LaboratorioId) VALUES
('77021001', 'Paracetamol 500mg', 'Acetaminofén', '500mg', 'Comprimidos', 0, 1),
('77021002', 'Ibuprofeno 400mg', 'Ibuprofeno', '400mg', 'Cápsulas Blandas', 0, 2),
('77021003', 'Amoxicilina 500mg', 'Amoxicilina Trihidrato', '500mg', 'Cápsulas', 1, 3),
('77021004', 'Losartán 50mg', 'Losartán Potásico', '50mg', 'Comprimidos', 1, 4),
('77021005', 'Omeprazol 20mg', 'Omeprazol', '20mg', 'Cápsulas', 0, 5),
('77021006', 'Loratadina 10mg', 'Loratadina', '10mg', 'Comprimidos', 0, 1);
GO

-- Inserción de Lotes
INSERT INTO LotesMedicamentos (NumeroLote, MedicamentoId, StockDisponible, StockMinimoAlerta, FechaFabricacion, FechaVencimiento, PrecioCompra, PrecioVenta) VALUES
('LT-9921', 1, 12, 15, '2025-01-10', '2027-04-15', 0.80, 1.50),
('LT-9922', 2, 14, 15, '2024-12-01', '2026-12-30', 1.20, 2.30),
('LT-8810', 3, 65, 20, '2025-06-15', '2027-08-20', 2.50, 4.50),
('LT-7740', 4, 120, 25, '2025-03-20', '2028-01-10', 3.00, 5.80),
('LT-6632', 5, 88, 20, '2025-05-10', '2027-11-05', 1.80, 3.20),
('LT-3310', 6, 8, 15, '2024-11-15', '2026-12-24', 0.90, 1.80);
GO
