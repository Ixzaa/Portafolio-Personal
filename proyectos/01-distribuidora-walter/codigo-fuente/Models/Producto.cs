using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DistribuidoraWalter.Models
{
    [Table("Productos")]
    public class Producto
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [Required(ErrorMessage = "El nombre del producto es obligatorio")]
        [StringLength(150, ErrorMessage = "El nombre no puede exceder 150 caracteres")]
        public string Nombre { get; set; } = string.Empty;

        [Required]
        [StringLength(50)]
        public string Categoria { get; set; } = string.Empty;

        [Required]
        [Column(TypeName = "decimal(18,2)")]
        [Range(0.01, 99999.99, ErrorMessage = "El precio debe ser mayor a cero")]
        public decimal Precio { get; set; }

        [Required]
        [Range(0, int.MaxValue, ErrorMessage = "El stock no puede ser negativo")]
        public int Stock { get; set; }

        public bool Activo { get; set; } = true;

        public DateTime FechaRegistro { get; set; } = DateTime.UtcNow;
    }
}
