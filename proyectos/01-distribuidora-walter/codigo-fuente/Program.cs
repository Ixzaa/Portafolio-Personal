using Microsoft.EntityFrameworkCore;
using DistribuidoraWalter.Data;

var builder = WebApplication.CreateBuilder(args);

// Configuración de servicios
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new() { 
        Title = "Distribuidora Walter API", 
        Version = "v1",
        Description = "API RESTful para la gestión mayorista de catálogo, stock y pedidos."
    });
});

// DbContext en memoria o SQL Server
builder.Services.AddDbContext<DistribuidoraDbContext>(options =>
    options.UseInMemoryDatabase("DistribuidoraDb"));
    // Para producción con SQL Server:
    // options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

// CORS para permitir consumo desde el portafolio frontend
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll",
        p => p.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());
});

var app = builder.Build();

// Inicializar base de datos y seed data
using (var scope = app.Services.CreateScope())
{
    var context = scope.ServiceProvider.GetRequiredService<DistribuidoraDbContext>();
    context.Database.EnsureCreated();
}

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseCors("AllowAll");
app.UseAuthorization();
app.MapControllers();

app.Run();
