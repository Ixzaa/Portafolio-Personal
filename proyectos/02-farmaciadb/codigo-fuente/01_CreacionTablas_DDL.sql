-- ===================================================================
-- PROYECTO: FarmaciaDB - Sistema Integral de Gestión Farmacéutica
-- ARCHIVO: 01_CreacionTablas_DDL.sql
-- MOTOR: Microsoft SQL Server 2019 / 2022
-- ===================================================================

CREATE DATABASE FarmaciaDB;
GO

USE FarmaciaDB;
GO

-- 1. Tabla de Laboratorios Fabricantes
CREATE TABLE Laboratorios (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    NombreLaboratorio NVARCHAR(100) NOT NULL UNIQUE,
    PaisOrigen NVARCHAR(50) NOT NULL DEFAULT 'Nacional',
    Contacto NVARCHAR(100),
    Telefono NVARCHAR(20),
    Activo BIT NOT NULL DEFAULT 1,
    FechaRegistro DATETIME2 DEFAULT SYSDATETIME()
);
GO

-- 2. Tabla de Medicamentos
CREATE TABLE Medicamentos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CodigoBarras NVARCHAR(30) NOT NULL UNIQUE,
    NombreComercial NVARCHAR(120) NOT NULL,
    PrincipioActivo NVARCHAR(120) NOT NULL,
    Concentracion NVARCHAR(50) NOT NULL, -- Ej: '500mg', '10ml'
    FormaFarmaceutica NVARCHAR(50) NOT NULL, -- Comprimidos, Jarabe, Inyectable
    RequiereReceta BIT NOT NULL DEFAULT 0,
    LaboratorioId INT NOT NULL,
    Activo BIT NOT NULL DEFAULT 1,
    FechaRegistro DATETIME2 DEFAULT SYSDATETIME(),
    CONSTRAINT FK_Medicamento_Laboratorio FOREIGN KEY (LaboratorioId) REFERENCES Laboratorios(Id)
);
GO

-- Índice no agrupado para búsquedas rápidas por principio activo y nombre
CREATE NONCLUSTERED INDEX IX_Medicamentos_PrincipioActivo 
ON Medicamentos(PrincipioActivo, NombreComercial);
GO

-- 3. Tabla de Lotes y Control de Caducidad
CREATE TABLE LotesMedicamentos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    NumeroLote NVARCHAR(50) NOT NULL,
    MedicamentoId INT NOT NULL,
    StockDisponible INT NOT NULL CHECK (StockDisponible >= 0),
    StockMinimoAlerta INT NOT NULL DEFAULT 15,
    FechaFabricacion DATE NOT NULL,
    FechaVencimiento DATE NOT NULL,
    PrecioCompra DECIMAL(10,2) NOT NULL CHECK (PrecioCompra > 0),
    PrecioVenta DECIMAL(10,2) NOT NULL CHECK (PrecioVenta > 0),
    CONSTRAINT FK_Lote_Medicamento FOREIGN KEY (MedicamentoId) REFERENCES Medicamentos(Id),
    CONSTRAINT CHK_Fechas_Lote CHECK (FechaVencimiento > FechaFabricacion)
);
GO

CREATE NONCLUSTERED INDEX IX_Lotes_Vencimiento 
ON LotesMedicamentos(FechaVencimiento) INCLUDE (MedicamentoId, StockDisponible);
GO

-- 4. Tabla de Ventas (Encabezado)
CREATE TABLE Ventas (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    NumeroFactura NVARCHAR(20) NOT NULL UNIQUE,
    FechaVenta DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    NombreCliente NVARCHAR(100) DEFAULT 'Consumidor Final',
    TotalVenta DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    MetodoPago NVARCHAR(30) NOT NULL DEFAULT 'Efectivo'
);
GO

-- 5. Detalle de Ventas
CREATE TABLE DetalleVentas (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    VentaId INT NOT NULL,
    LoteId INT NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    Subtotal AS (Cantidad * PrecioUnitario),
    CONSTRAINT FK_Detalle_Venta FOREIGN KEY (VentaId) REFERENCES Ventas(Id),
    CONSTRAINT FK_Detalle_Lote FOREIGN KEY (LoteId) REFERENCES LotesMedicamentos(Id)
);
GO

-- 6. Tabla de Auditoría de Movimientos y Seguridad
CREATE TABLE AuditoriaStock (
    LogId INT IDENTITY(1,1) PRIMARY KEY,
    TipoOperacion NVARCHAR(10) NOT NULL, -- INSERT, UPDATE, DELETE
    TablaModificada NVARCHAR(50) NOT NULL,
    UsuarioSQL NVARCHAR(100) NOT NULL DEFAULT SUSER_NAME(),
    FechaEvento DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    DetalleCambio NVARCHAR(MAX)
);
GO
