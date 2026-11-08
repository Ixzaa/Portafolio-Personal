using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DistribuidoraWalter.Models
{
    [Table("Pedidos")]
    public class Pedido
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(100)]
        public string Cliente { get; set; } = string.Empty;

        public DateTime FechaPedido { get; set; } = DateTime.UtcNow;

        [Column(TypeName = "decimal(18,2)")]
        public decimal Total { get; set; }

        [StringLength(30)]
        public string Estado { get; set; } = "Pendiente"; // Pendiente, Facturado, Entregado

        public List<DetallePedido> Detalles { get; set; } = new();
    }

    [Table("DetallesPedidos")]
    public class DetallePedido
    {
        [Key]
        public int Id { get; set; }

        public int PedidoId { get; set; }
        public Pedido? Pedido { get; set; }

        public int ProductoId { get; set; }
        public Producto? Producto { get; set; }

        public int Cantidad { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal PrecioUnitario { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal Subtotal => Cantidad * PrecioUnitario;
    }
}
