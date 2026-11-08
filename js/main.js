/* ===================================================================
   PORTAFOLIO PROFESIONAL — RUTH IXZAYARA BERMÚDEZ CUBA
   Desarrolladora de Software | Backend .NET
   Estudiante de Ingeniería en Sistemas de Información (UNAN)
   Jinotepe, Nicaragua | Tel: +505 8535 7600
   =================================================================== */

// ESTADO GLOBAL
let currentTheme = localStorage.getItem('theme') || 'dark';

// 1. RELOJ EN VIVO NICARAGUA (GMT-6)
function updateLiveClock() {
  const clockEl = document.getElementById('live-clock');
  if (!clockEl) return;
  const now = new Date();
  const opts = { 
    timeZone: 'America/Managua', 
    hour12: false, 
    hour: '2-digit', 
    minute: '2-digit', 
    second: '2-digit' 
  };
  const timeStr = now.toLocaleTimeString('es-NI', opts);
  clockEl.textContent = `🕒 ${timeStr} GMT-6`;
}

setInterval(updateLiveClock, 1000);
updateLiveClock();

// 2. CAMBIO DE TEMA DÍA / NOCHE
function applyTheme(theme) {
  currentTheme = theme;
  document.documentElement.setAttribute('data-theme', theme);
  localStorage.setItem('theme', theme);

  const themeBtn = document.getElementById('theme-toggle-btn');
  if (themeBtn) {
    if (theme === 'light') {
      themeBtn.innerHTML = '☀️ Día';
    } else {
      themeBtn.innerHTML = '🌙 Noche';
    }
  }
}

// 3. MODAL DE CURRÍCULUM VITAE (CV ATS FRIENDLY)
function openCvModal() {
  const modal = document.getElementById('modal-cv-overlay');
  if (modal) {
    modal.classList.add('active');
    document.body.style.overflow = 'hidden';
  }
}

function closeCvModal() {
  const modal = document.getElementById('modal-cv-overlay');
  if (modal) {
    modal.classList.remove('active');
    document.body.style.overflow = '';
  }
}

function handleCvOverlayClick(e) {
  if (e.target.id === 'modal-cv-overlay') {
    closeCvModal();
  }
}

// Cerrar modal con tecla Escape
window.addEventListener('keydown', (e) => {
  if (e.key === 'Escape') {
    closeCvModal();
  }
});

// 4. COPIAR CORREO CON NOTIFICACIÓN VISUAL
function copyEmail() {
  const email = "Ruth.ixzayara.bermudez.cuba2809@gmail.com";
  navigator.clipboard.writeText(email).then(() => {
    const btn = document.getElementById('btn-copy-email');
    if (btn) {
      const originalText = btn.innerHTML;
      btn.innerHTML = "✓ ¡Copiado!";
      btn.style.background = "#10b981";
      btn.style.color = "#ffffff";
      setTimeout(() => {
        btn.innerHTML = originalText;
        btn.style.background = "";
        btn.style.color = "";
      }, 2400);
    }
  }).catch(() => {
    alert("Correo: " + email);
  });
}

// 5. ENVIAR FORMULARIO DIRECTO A WHATSAPP
function sendViaWhatsApp() {
  const name = document.getElementById('name') ? document.getElementById('name').value.trim() : '';
  const email = document.getElementById('email') ? document.getElementById('email').value.trim() : '';
  const msg = document.getElementById('message') ? document.getElementById('message').value.trim() : '';

  if (!msg) {
    alert('Por favor, escribe un mensaje primero antes de abrir WhatsApp.');
    return;
  }

  const greeting = `Hola Ruth, te contacto desde tu portafolio web.\n\n*Nombre:* ${name || 'Interesado'}\n*Email:* ${email || 'No especificado'}\n*Mensaje:* ${msg}`;
  const url = `https://wa.me/50585357600?text=${encodeURIComponent(greeting)}`;
  window.open(url, '_blank', 'noopener,noreferrer');
}

// 6. CONSTELACIÓN SUTIL DE PARTÍCULAS EN CANVAS DE FONDO
function initConstellation() {
  // Si el usuario prefiere movimiento reducido, no iniciamos el canvas
  if (window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
    return;
  }

  const canvas = document.getElementById('bg-constellation');
  if (!canvas) return;
  const ctx = canvas.getContext('2d');

  let width = canvas.width = window.innerWidth;
  let height = canvas.height = window.innerHeight;

  window.addEventListener('resize', () => {
    width = canvas.width = window.innerWidth;
    height = canvas.height = window.innerHeight;
  });

  const numParticles = Math.min(50, Math.floor((width * height) / 22000));
  const particles = [];
  const mouse = { x: null, y: null, maxDist: 130 };

  window.addEventListener('mousemove', (e) => {
    mouse.x = e.clientX;
    mouse.y = e.clientY;
  });

  window.addEventListener('mouseleave', () => {
    mouse.x = null;
    mouse.y = null;
  });

  for (let i = 0; i < numParticles; i++) {
    particles.push({
      x: Math.random() * width,
      y: Math.random() * height,
      vx: (Math.random() - 0.5) * 0.55,
      vy: (Math.random() - 0.5) * 0.55,
      radius: 1.4 + Math.random() * 1.6
    });
  }

  function animate() {
    ctx.clearRect(0, 0, width, height);

    for (let i = 0; i < particles.length; i++) {
      const p = particles[i];
      p.x += p.vx;
      p.y += p.vy;

      if (p.x < 0 || p.x > width) p.vx *= -1;
      if (p.y < 0 || p.y > height) p.vy *= -1;

      // Dibujar partícula
      ctx.beginPath();
      ctx.arc(p.x, p.y, p.radius, 0, Math.PI * 2);
      ctx.fillStyle = currentTheme === 'dark' ? 'rgba(168, 85, 247, 0.45)' : 'rgba(124, 58, 237, 0.35)';
      ctx.fill();

      // Interacción suave con mouse
      if (mouse.x !== null) {
        const dx = mouse.x - p.x;
        const dy = mouse.y - p.y;
        const dist = Math.hypot(dx, dy);
        if (dist < mouse.maxDist) {
          ctx.beginPath();
          ctx.moveTo(p.x, p.y);
          ctx.lineTo(mouse.x, mouse.y);
          ctx.strokeStyle = `rgba(192, 132, 252, ${0.3 * (1 - dist / mouse.maxDist)})`;
          ctx.lineWidth = 0.9;
          ctx.stroke();
        }
      }

      // Conexiones entre partículas cercanas
      for (let j = i + 1; j < particles.length; j++) {
        const p2 = particles[j];
        const dx = p.x - p2.x;
        const dy = p.y - p2.y;
        const dist = Math.hypot(dx, dy);

        if (dist < 100) {
          ctx.beginPath();
          ctx.moveTo(p.x, p.y);
          ctx.lineTo(p2.x, p2.y);
          ctx.strokeStyle = currentTheme === 'dark' 
            ? `rgba(139, 92, 246, ${0.18 * (1 - dist / 100)})` 
            : `rgba(124, 58, 237, ${0.12 * (1 - dist / 100)})`;
          ctx.lineWidth = 0.7;
          ctx.stroke();
        }
      }
    }

    requestAnimationFrame(animate);
  }

  animate();
}

// 7. EFECTO 3D TILT EN TARJETAS DE PROYECTOS
function initCardTilt() {
  if (window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
    return;
  }

  const cards = document.querySelectorAll('.project-card, .featured-project-card');
  cards.forEach(card => {
    card.addEventListener('mousemove', (e) => {
      const rect = card.getBoundingClientRect();
      const x = e.clientX - rect.left;
      const y = e.clientY - rect.top;
      const centerX = rect.width / 2;
      const centerY = rect.height / 2;

      const rotateX = ((y - centerY) / centerY) * -5;
      const rotateY = ((x - centerX) / centerX) * 5;

      card.style.transform = `perspective(1000px) rotateX(${rotateX.toFixed(2)}deg) rotateY(${rotateY.toFixed(2)}deg) translateY(-3px)`;
    });

    card.addEventListener('mouseleave', () => {
      card.style.transform = 'perspective(1000px) rotateX(0deg) rotateY(0deg) translateY(0)';
    });
  });
}

// 8. INICIALIZACIÓN GLOBAL
document.addEventListener('DOMContentLoaded', () => {
  applyTheme(currentTheme);
  initConstellation();
  initCardTilt();

  // Selector de tema (Día / Noche)
  const themeBtn = document.getElementById('theme-toggle-btn');
  if (themeBtn) {
    themeBtn.addEventListener('click', () => {
      const nextTheme = currentTheme === 'dark' ? 'light' : 'dark';
      applyTheme(nextTheme);
    });
  }

  // Filtrado de proyectos por categoría
  const filterBtns = document.querySelectorAll('.filter-btn');
  const projectCards = document.querySelectorAll('.project-card');

  filterBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      filterBtns.forEach(b => b.classList.remove('active'));
      btn.classList.add('active');

      const filter = btn.getAttribute('data-filter');

      projectCards.forEach(card => {
        const category = card.getAttribute('data-category');
        if (filter === 'all' || category === filter) {
          card.style.display = 'flex';
          setTimeout(() => {
            card.style.opacity = '1';
            card.style.transform = 'translateY(0)';
          }, 40);
        } else {
          card.style.opacity = '0';
          card.style.transform = 'translateY(12px)';
          setTimeout(() => {
            card.style.display = 'none';
          }, 200);
        }
      });
    });
  });

  // Envío del formulario de contacto
  const contactForm = document.getElementById('contact-form');
  if (contactForm) {
    contactForm.addEventListener('submit', (e) => {
      e.preventDefault();
      const btn = contactForm.querySelector('button[type="submit"]');
      const originalText = btn.innerHTML;

      btn.innerHTML = "Enviando mensaje...";
      btn.disabled = true;

      const name = document.getElementById('name').value;
      const email = document.getElementById('email').value;
      const msg = document.getElementById('message').value;

      setTimeout(() => {
        const mailto = `mailto:Ruth.ixzayara.bermudez.cuba2809@gmail.com?subject=Contacto desde Portafolio - ${encodeURIComponent(name)}&body=${encodeURIComponent(msg + "\n\nDe: " + name + " (" + email + ")")}`;
        window.location.href = mailto;

        btn.innerHTML = "✓ ¡Mensaje Preparado con Éxito!";
        btn.style.background = '#10b981';
        contactForm.reset();

        setTimeout(() => {
          btn.innerHTML = originalText;
          btn.disabled = false;
          btn.style.background = '';
        }, 4000);
      }, 600);
    });
  }

  // Rastreo de sección activa en la barra de navegación al hacer scroll
  const navLinks = document.querySelectorAll('.nav-link');
  const sections = document.querySelectorAll('section[id]');

  window.addEventListener('scroll', () => {
    let current = '';
    sections.forEach(section => {
      const sectionTop = section.offsetTop - 140;
      if (window.scrollY >= sectionTop) {
        current = section.getAttribute('id');
      }
    });

    navLinks.forEach(link => {
      link.classList.remove('active');
      if (link.getAttribute('href') === `#${current}`) {
        link.classList.add('active');
      }
    });
  });
});
