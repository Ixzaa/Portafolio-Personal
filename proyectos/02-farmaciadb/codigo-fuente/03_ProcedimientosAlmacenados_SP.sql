-- ===================================================================
-- PROYECTO: FarmaciaDB
-- ARCHIVO: 03_ProcedimientosAlmacenados_SP.sql
-- ===================================================================

USE FarmaciaDB;
GO

-- Procedimiento Almacenado: Registro Transaccional de Venta
CREATE OR ALTER PROCEDURE sp_RegistrarVentaMedicamento
    @NombreCliente NVARCHAR(100),
    @LoteId INT,
    @Cantidad INT,
    @MetodoPago NVARCHAR(30) = 'Efectivo',
    @NuevoVentaId INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Validar existencia y stock suficiente
        DECLARE @StockActual INT;
        DECLARE @PrecioVenta DECIMAL(10,2);
        DECLARE @MedicamentoNombre NVARCHAR(120);

        SELECT 
            @StockActual = lt.StockDisponible,
            @PrecioVenta = lt.PrecioVenta,
            @MedicamentoNombre = m.NombreComercial
        FROM LotesMedicamentos lt
        INNER JOIN Medicamentos m ON lt.MedicamentoId = m.Id
        WHERE lt.Id = @LoteId;

        IF @StockActual IS NULL
        BEGIN
            THROW 50001, 'El lote especificado no existe en el sistema.', 1;
        END

        IF @StockActual < @Cantidad
        BEGIN
            DECLARE @ErrorMsg NVARCHAR(250) = CONCAT('Stock insuficiente. Disponible: ', @StockActual, ' - Solicitado: ', @Cantidad);
            THROW 50002, @ErrorMsg, 1;
        END

        -- 2. Crear encabezado de venta
        DECLARE @NumeroFactura NVARCHAR(20) = CONCAT('FAC-', NEXT VALUE FOR dbo.Seq_Factura);
        DECLARE @TotalCalculado DECIMAL(12,2) = @Cantidad * @PrecioVenta;

        INSERT INTO Ventas (NumeroFactura, NombreCliente, TotalVenta, MetodoPago)
        VALUES (@NumeroFactura, @NombreCliente, @TotalCalculado, @MetodoPago);

        SET @NuevoVentaId = SCOPE_IDENTITY();

        -- 3. Crear detalle de venta
        INSERT INTO DetalleVentas (VentaId, LoteId, Cantidad, PrecioUnitario)
        VALUES (@NuevoVentaId, @LoteId, @Cantidad, @PrecioVenta);

        -- El descuento de inventario se gestiona automáticamente mediante el Trigger

        COMMIT TRANSACTION;
        PRINT CONCAT('Venta registrada con éxito. Factura N° ', @NumeroFactura);
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO
