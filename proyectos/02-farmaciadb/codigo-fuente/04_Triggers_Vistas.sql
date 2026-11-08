-- ===================================================================
-- PROYECTO: FarmaciaDB
-- ARCHIVO: 04_Triggers_Vistas.sql
-- ===================================================================

USE FarmaciaDB;
GO

-- Secuencia para facturación
IF NOT EXISTS (SELECT * FROM sys.sequences WHERE name = 'Seq_Factura')
    CREATE SEQUENCE Seq_Factura START WITH 10001 INCREMENT BY 1;
GO

-- 1. Trigger para actualizar el stock al insertar en DetalleVentas
CREATE OR ALTER TRIGGER trg_ActualizarStockVenta
ON DetalleVentas
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Actualizar stock disponible restando la cantidad vendida
    UPDATE lt
    SET lt.StockDisponible = lt.StockDisponible - i.Cantidad
    FROM LotesMedicamentos lt
    INNER JOIN inserted i ON lt.Id = i.LoteId;

    -- Registrar evento en la tabla de auditoría
    INSERT INTO AuditoriaStock (TipoOperacion, TablaModificada, DetalleCambio)
    SELECT 
        'INSERT',
        'DetalleVentas',
        CONCAT('Salida de ', i.Cantidad, ' unidades del Lote ID ', i.LoteId, ' por Venta ID ', i.VentaId)
    FROM inserted i;
END;
GO

-- 2. Vista de Alertas de Caducidad y Lotes Críticos
CREATE OR ALTER VIEW vw_AlertasCaducidad AS
SELECT 
    m.CodigoBarras,
    m.NombreComercial,
    m.PrincipioActivo,
    l.NombreLaboratorio,
    lt.NumeroLote,
    lt.StockDisponible,
    lt.FechaVencimiento,
    DATEDIFF(day, CAST(SYSDATETIME() AS DATE), lt.FechaVencimiento) AS DiasParaVencer,
    CASE 
        WHEN DATEDIFF(day, CAST(SYSDATETIME() AS DATE), lt.FechaVencimiento) <= 30 THEN 'ALERTA ROJA: Vence en menos de 1 mes'
        WHEN DATEDIFF(day, CAST(SYSDATETIME() AS DATE), lt.FechaVencimiento) <= 60 THEN 'ALERTA AMARILLA: Próximo a vencer'
        ELSE 'ESTADO ÓPTIMO'
    END AS NivelAlerta
FROM LotesMedicamentos lt
INNER JOIN Medicamentos m ON lt.MedicamentoId = m.Id
INNER JOIN Laboratorios l ON m.LaboratorioId = l.Id
WHERE lt.StockDisponible > 0;
GO
