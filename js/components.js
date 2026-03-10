// ============================================================
// SHARED COMPONENTS — Navbar & Footer
// ============================================================
function renderNavbar() {
  return `
  <nav class="navbar">
    <div class="nav-inner">
      <a href="/index.html" class="nav-logo">
        <img src="/logo.jpeg" alt="Vidaya Technology" style="height:44px;width:auto;object-fit:contain;">
      </a>
      <ul class="nav-links">
        <li><a href="/index.html" class="nav-link">Home</a></li>
        <li><a href="/pages/courses.html" class="nav-link">Courses</a></li>
        <li><a href="/pages/services.html" class="nav-link">Services</a></li>
        <li><a href="/pages/research.html" class="nav-link">Research</a></li>
        <li><a href="/pages/shop.html" class="nav-link">Shop</a></li>
        <li><a href="/pages/contact.html" class="nav-link">Contact</a></li>
      </ul>
      <div class="nav-auth" id="nav-auth">
        <a href="/pages/login.html" class="btn-nav-outline">Login</a>
        <a href="/pages/register.html" class="btn-nav-solid">Register</a>
      </div>
      <button class="nav-hamburger" id="hamburger" aria-label="Menu">
        <span></span><span></span><span></span>
      </button>
    </div>
  </nav>`;
}
function renderFooter() {
  return `
  <footer>
    <div class="footer-grid">
      <div class="footer-brand">
        <img src="/logo.jpeg" alt="Vidaya Technology" style="height:84px;width:auto;object-fit:contain;margin-bottom:.75rem;">
        <p>Industry-focused training in Software, AI & IT. Empowering learners with practical, real-world skills since 2020.</p>
      </div>
      <div class="footer-col">
        <h4>Quick Links</h4>
        <a href="/index.html">Home</a>
        <a href="/pages/courses.html">Courses</a>
        <a href="/pages/services.html">Services</a>
        <a href="/pages/research.html">Research</a>
      </div>
      <div class="footer-col">
        <h4>Platform</h4>
        <a href="/pages/shop.html">Shop</a>
        <a href="/pages/contact.html">Contact Us</a>
        <a href="/pages/login.html">Login</a>
        <a href="/pages/register.html">Register</a>
      </div>
      <div class="footer-col">
        <h4>Contact</h4>
        <a href="tel:+919176769943">+91 9176769943</a>
        <a href="mailto:vidayatechnology@gmail.com">vidayatechnology@gmail.com</a>
        <a href="#">Coimbatore, Tamil Nadu</a>
      </div>
    </div>
    <div class="footer-bottom">
      <span>© 2026 Vidaya Technology & Management. All rights reserved.</span>
      <span>Powered by <a href="#">Vidaya Technology</a></span>
    </div>
  </footer>`;
}
function initNavbar() {
  const nav = document.getElementById('navbar-placeholder');
  if (nav) nav.innerHTML = renderNavbar();
  const foot = document.getElementById('footer-placeholder');
  if (foot) foot.innerHTML = renderFooter();
  // Hamburger
  document.addEventListener('click', (e) => {
    if (e.target.closest('#hamburger')) {
      document.querySelector('.navbar').classList.toggle('nav-mobile-open');
    }
  });
  setActiveNav();
  updateNavAuth();
}
// Scroll reveal
function initScrollReveal() {
  const els = document.querySelectorAll('.fade-in');
  const obs = new IntersectionObserver((entries) => {
    entries.forEach(e => { if (e.isIntersecting) { e.target.classList.add('visible'); obs.unobserve(e.target); } });
  }, { threshold: 0.1 });
  els.forEach(el => obs.observe(el));
}
document.addEventListener('DOMContentLoaded', () => { initNavbar(); initScrollReveal(); });
