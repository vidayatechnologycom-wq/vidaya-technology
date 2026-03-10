// ============================================================
// SUPABASE CONFIGURATION
// Replace these values with your actual Supabase project credentials
// ============================================================
const SUPABASE_URL = 'https://gttqoxirbwjletwoaxoq.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd0dHFveGlyYndqbGV0d29heG9xIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzMxMTcyMDAsImV4cCI6MjA4ODY5MzIwMH0.awNyZLvJ1qSJCQzZ0IoPLIXMUcNeaV6rYozY2JpPWGU';

// Initialize Supabase client
const { createClient } = supabase;
const sb = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

// ============================================================
// AUTH HELPERS
// ============================================================
async function getCurrentUser() {
  const { data: { user } } = await sb.auth.getUser();
  return user;
}

async function getCurrentUserRole() {
  const user = await getCurrentUser();
  if (!user) return null;
  const { data } = await sb.from('users').select('role').eq('id', user.id).single();
  return data?.role || 'user';
}

async function requireAuth(redirectTo = '/pages/login.html') {
  const user = await getCurrentUser();
  if (!user) { window.location.href = redirectTo; return null; }
  return user;
}

async function requireAdmin() {
  const user = await requireAuth();
  if (!user) return;
  const role = await getCurrentUserRole();
  if (role !== 'admin') {
    showNotification('Access denied. Admins only.', 'error');
    setTimeout(() => window.location.href = '/pages/dashboard.html', 1500);
  }
  return role === 'admin' ? user : null;
}

// ============================================================
// NOTIFICATION SYSTEM
// ============================================================
function showNotification(message, type = 'success') {
  const existing = document.querySelector('.notif-toast');
  if (existing) existing.remove();
  const toast = document.createElement('div');
  toast.className = `notif-toast notif-${type}`;
  toast.innerHTML = `<span>${type === 'success' ? '✓' : '✕'}</span> ${message}`;
  document.body.appendChild(toast);
  setTimeout(() => toast.classList.add('show'), 10);
  setTimeout(() => { toast.classList.remove('show'); setTimeout(() => toast.remove(), 300); }, 3500);
}

// ============================================================
// NAV ACTIVE LINK
// ============================================================
function setActiveNav() {
  const path = window.location.pathname.split('/').pop();
  document.querySelectorAll('.nav-link').forEach(link => {
    const href = link.getAttribute('href')?.split('/').pop();
    if (href === path) link.classList.add('active');
  });
}

// ============================================================
// UPDATE NAV FOR AUTH STATE
// ============================================================
async function updateNavAuth() {
  const user = await getCurrentUser();
  const role = user ? await getCurrentUserRole() : null;
  const authArea = document.getElementById('nav-auth');
  if (!authArea) return;

  if (user) {
    authArea.innerHTML = `
      <a href="${role === 'admin' ? '/pages/admin.html' : '/pages/dashboard.html'}" class="btn-nav-outline">
        ${role === 'admin' ? '⚙ Admin' : '👤 Dashboard'}
      </a>
      <button onclick="signOut()" class="btn-nav-solid">Logout</button>
    `;
  } else {
    authArea.innerHTML = `
      <a href="/pages/login.html" class="btn-nav-outline">Login</a>
      <a href="/pages/register.html" class="btn-nav-solid">Register</a>
    `;
  }
}

async function signOut() {
  await sb.auth.signOut();
  showNotification('Logged out successfully');
  setTimeout(() => window.location.href = '/index.html', 1000);
}
