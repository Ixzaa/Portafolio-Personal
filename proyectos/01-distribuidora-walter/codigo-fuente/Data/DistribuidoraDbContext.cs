using Microsoft.EntityFrameworkCore;
using DistribuidoraWalter.Models;

namespace DistribuidoraWalter.Data
{
    public class DistribuidoraDbContext : DbContext
    {
        public DistribuidoraDbContext(DbContextOptions<DistribuidoraDbContext> options) : base(options)
        {
        }

        public DbSet<Producto> Productos => Set<Producto>();
        public DbSet<Pedido> Pedidos => Set<Pedido>();
        public DbSet<DetallePedido> DetallesPedidos => Set<DetallePedido>();

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Seed inicial de productos
            modelBuilder.Entity<Producto>().HasData(
                new Producto { Id = 1, Nombre = "Aceite Vegetal 1L (Caja x12)", Categoria = "Abarrotes", Precio = 28.50m, Stock = 150, Activo = true },
                new Producto { Id = 2, Nombre = "Arroz Extra 50kg (Saco)", Categoria = "Granos", Precio = 45.00m, Stock = 80, Activo = true },
                new Producto { Id = 3, Nombre = "Detergente Industrial 10kg", Categoria = "Limpieza", Precio = 19.99m, Stock = 45, Activo = true },
                new Producto { Id = 4, Nombre = "Bebida Energizante Pack x24", Categoria = "Bebidas", Precio = 32.00m, Stock = 120, Activo = true }
            );
        }
    }
}
