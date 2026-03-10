# 🎓 Vidaya Technology & Management — Website

A modern, responsive e-learning platform built with HTML/CSS/JS + Supabase.

---

## 📁 Project Structure

```
vidaya/
├── index.html              ← Homepage
├── css/
│   └── style.css           ← Global styles
├── js/
│   ├── supabase.js         ← Supabase config + auth helpers
│   └── components.js       ← Shared navbar, footer, scroll
├── pages/
│   ├── courses.html        ← All courses
│   ├── services.html       ← Services
│   ├── research.html       ← Research posts
│   ├── shop.html           ← Shop
│   ├── contact.html        ← Contact form
│   ├── login.html          ← Login
│   ├── register.html       ← Registration
│   ├── dashboard.html      ← User dashboard
│   └── admin.html          ← Admin dashboard
└── supabase_setup.sql      ← Database schema + RLS policies
```

---

## 🚀 Setup Instructions

### Step 1 — Create a Supabase Project

1. Go to [https://supabase.com](https://supabase.com) and create a free account
2. Click **New Project** and fill in details
3. Wait for the project to initialise

### Step 2 — Run the Database Schema

1. In your Supabase dashboard, go to **SQL Editor**
2. Paste and run the contents of `supabase_setup.sql`
3. This creates all tables with Row Level Security (RLS)

### Step 3 — Get Your API Keys

1. Go to **Settings → API** in your Supabase dashboard
2. Copy:
   - **Project URL** (e.g. `https://abcdef.supabase.co`)
   - **anon/public key**

### Step 4 — Update `js/supabase.js`

Replace the placeholder values at the top of `js/supabase.js`:

```javascript
const SUPABASE_URL = 'https://YOUR_PROJECT_ID.supabase.co';
const SUPABASE_ANON_KEY = 'YOUR_ANON_PUBLIC_KEY';
```

### Step 5 — Deploy / Serve

Host the files on any static hosting:
- **Netlify** (drag & drop the folder)
- **Vercel** (`vercel deploy`)
- **GitHub Pages**
- Or run locally with VS Code Live Server

### Step 6 — Create Admin User

1. Register a user via the website (`/pages/register.html`)
2. In Supabase SQL Editor, run:
   ```sql
   UPDATE public.users SET role = 'admin' WHERE email = 'your@email.com';
   ```
3. That user can now access the Admin Dashboard at `/pages/admin.html`

---

## 👤 User Roles

| Role  | Access |
|-------|--------|
| user  | Browse courses, services, research, shop. Send contact messages. User dashboard. |
| admin | All user features + Admin dashboard: add/edit/delete all content, view messages & users. |

---

## 🔒 Security Features

- Supabase Auth for login/register
- Row Level Security (RLS) on all tables
- Admin routes protected in JavaScript
- Only admin-role users can modify content

---

## 📊 Database Tables

| Table | Fields |
|-------|--------|
| users | id, name, email, role |
| courses | id, title, description, image |
| services | id, title, description |
| research | id, title, description |
| shop | id, product_name, price, image |
| contact_messages | id, name, email, subject, message |

---

## 🎨 Tech Stack

- **Frontend**: HTML5, CSS3 (Custom), Vanilla JavaScript
- **Fonts**: Sora + DM Sans (Google Fonts)
- **Backend/DB**: Supabase (PostgreSQL + Auth)
- **Icons**: Unicode emoji (no dependencies)

---

## ⚙️ Admin Dashboard Features

- ✅ Add / Edit / Delete Courses
- ✅ Add / Edit / Delete Services
- ✅ Add / Edit / Delete Research Posts
- ✅ Add / Edit / Delete Shop Items
- ✅ View all Contact Messages
- ✅ View all Registered Users
- ✅ Overview stats dashboard
