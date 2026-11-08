using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DistribuidoraWalter.Data;
using DistribuidoraWalter.Models;

namespace DistribuidoraWalter.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Produces("application/json")]
    public class ProductosController : ControllerBase
    {
        private readonly DistribuidoraDbContext _context;

        public ProductosController(DistribuidoraDbContext context)
        {
            _context = context;
        }

        // GET: api/productos
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Producto>>> GetProductos()
        {
            return await _context.Productos.Where(p => p.Activo).ToListAsync();
        }

        // GET: api/productos/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Producto>> GetProducto(int id)
        {
            var producto = await _context.Productos.FindAsync(id);

            if (producto == null)
            {
                return NotFound(new { mensaje = $"Producto con ID {id} no encontrado" });
            }

            return producto;
        }

        // GET: api/productos/stock-bajo
        [HttpGet("stock-bajo")]
        public async Task<ActionResult<IEnumerable<Producto>>> GetStockBajo([FromQuery] int umbral = 50)
        {
            var criticos = await _context.Productos
                .Where(p => p.Activo && p.Stock <= umbral)
                .OrderBy(p => p.Stock)
                .ToListAsync();

            return Ok(criticos);
        }

        // POST: api/productos
        [HttpPost]
        public async Task<ActionResult<Producto>> PostProducto(Producto producto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.Productos.Add(producto);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetProducto), new { id = producto.Id }, producto);
        }

        // PUT: api/productos/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutProducto(int id, Producto producto)
        {
            if (id != producto.Id)
            {
                return BadRequest(new { mensaje = "El ID de la ruta no coincide con el cuerpo" });
            }

            _context.Entry(producto).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!_context.Productos.Any(e => e.Id == id))
                {
                    return NotFound();
                }
                throw;
            }

            return NoContent();
        }

        // DELETE: api/productos/5 (Baja lógica)
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProducto(int id)
        {
            var producto = await _context.Productos.FindAsync(id);
            if (producto == null)
            {
                return NotFound();
            }

            producto.Activo = false;
            await _context.SaveChangesAsync();

            return Ok(new { mensaje = "Producto dado de baja lógica correctamente" });
        }
    }
}
