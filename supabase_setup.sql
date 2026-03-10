-- ============================================================
-- VIDAYA TECHNOLOGY — SUPABASE DATABASE SETUP
-- Run this in Supabase SQL Editor
-- ============================================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ── USERS TABLE ──────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.users (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  name TEXT,
  email TEXT UNIQUE NOT NULL,
  role TEXT NOT NULL DEFAULT 'user' CHECK (role IN ('admin', 'user')),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ── COURSES TABLE ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.courses (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title TEXT NOT NULL,
  description TEXT,
  image TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ── SERVICES TABLE ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.services (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title TEXT NOT NULL,
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ── RESEARCH TABLE ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.research (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title TEXT NOT NULL,
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ── SHOP TABLE ────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.shop (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  product_name TEXT NOT NULL,
  price NUMERIC(10,2) NOT NULL DEFAULT 0,
  image TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ── CONTACT MESSAGES TABLE ───────────────────────────────────
CREATE TABLE IF NOT EXISTS public.contact_messages (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  subject TEXT,
  message TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================================

ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.courses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.services ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.research ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.shop ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.contact_messages ENABLE ROW LEVEL SECURITY;

-- ── USERS policies ───────────────────────────────────────────
-- Users can read their own profile
CREATE POLICY "Users can read own profile" ON public.users
  FOR SELECT USING (auth.uid() = id);

-- Users can insert their own profile (on signup)
CREATE POLICY "Users can insert own profile" ON public.users
  FOR INSERT WITH CHECK (auth.uid() = id);

-- Admins can read all users
CREATE POLICY "Admins can read all users" ON public.users
  FOR SELECT USING (
    EXISTS (SELECT 1 FROM public.users WHERE id = auth.uid() AND role = 'admin')
  );

-- ── COURSES policies ─────────────────────────────────────────
-- Anyone (including anonymous) can read courses
CREATE POLICY "Public can read courses" ON public.courses
  FOR SELECT USING (true);

-- Only admins can insert/update/delete courses
CREATE POLICY "Admins can manage courses" ON public.courses
  FOR ALL USING (
    EXISTS (SELECT 1 FROM public.users WHERE id = auth.uid() AND role = 'admin')
  );

-- ── SERVICES policies ────────────────────────────────────────
CREATE POLICY "Public can read services" ON public.services
  FOR SELECT USING (true);

CREATE POLICY "Admins can manage services" ON public.services
  FOR ALL USING (
    EXISTS (SELECT 1 FROM public.users WHERE id = auth.uid() AND role = 'admin')
  );

-- ── RESEARCH policies ────────────────────────────────────────
CREATE POLICY "Public can read research" ON public.research
  FOR SELECT USING (true);

CREATE POLICY "Admins can manage research" ON public.research
  FOR ALL USING (
    EXISTS (SELECT 1 FROM public.users WHERE id = auth.uid() AND role = 'admin')
  );

-- ── SHOP policies ────────────────────────────────────────────
CREATE POLICY "Public can read shop" ON public.shop
  FOR SELECT USING (true);

CREATE POLICY "Admins can manage shop" ON public.shop
  FOR ALL USING (
    EXISTS (SELECT 1 FROM public.users WHERE id = auth.uid() AND role = 'admin')
  );

-- ── CONTACT MESSAGES policies ────────────────────────────────
-- Anyone can submit a contact message
CREATE POLICY "Anyone can submit messages" ON public.contact_messages
  FOR INSERT WITH CHECK (true);

-- Only admins can read messages
CREATE POLICY "Admins can read messages" ON public.contact_messages
  FOR SELECT USING (
    EXISTS (SELECT 1 FROM public.users WHERE id = auth.uid() AND role = 'admin')
  );

-- ============================================================
-- SAMPLE DATA (Optional — uncomment to insert demo content)
-- ============================================================

/*
INSERT INTO public.courses (title, description) VALUES
  ('Advanced Deep Learning', 'Master neural networks, CNNs, RNNs and transformer models with hands-on projects in TensorFlow and PyTorch.'),
  ('Advanced Data Science', 'From data wrangling and EDA to predictive modeling and deployment — a complete data science bootcamp.'),
  ('Advanced Data Mining', 'Techniques for discovering patterns and knowledge from large datasets using modern algorithms.'),
  ('ACCA Certification', 'Association of Chartered Certified Accountants — globally recognised professional accountancy qualification.'),
  ('Machine Learning with Python', 'Build ML models from scratch using Scikit-learn, covering supervised, unsupervised and reinforcement learning.'),
  ('Advanced Python Programming', 'Deep dive into Python internals, decorators, async/await, design patterns, and performance optimisation.');

INSERT INTO public.services (title, description) VALUES
  ('Corporate Training', 'Custom technology training programs tailored to your organisation's needs and goals.'),
  ('Research Support', 'Expert guidance and resources for academic and industry research projects in AI/ML.'),
  ('Placement Assistance', 'Career support including resume reviews, mock interviews, and job placement assistance.'),
  ('Online Mentorship', '1-on-1 mentorship sessions with industry experts to guide your career path.');

INSERT INTO public.research (title, description) VALUES
  ('Deep Learning in Healthcare', 'Exploring the applications of deep neural networks in medical imaging and diagnosis.'),
  ('NLP for Regional Languages', 'Research into natural language processing techniques for Tamil and other regional Indian languages.');

INSERT INTO public.shop (product_name, price) VALUES
  ('Python for Data Science — E-Book', 299),
  ('Machine Learning Workbook', 499),
  ('ACCA Study Pack', 1499),
  ('Deep Learning Video Series', 999);
*/

-- ============================================================
-- TO CREATE YOUR FIRST ADMIN USER:
-- 1. Register via the website normally
-- 2. Run this query (replace the email):
--    UPDATE public.users SET role = 'admin' WHERE email = 'your@email.com';
-- ============================================================
