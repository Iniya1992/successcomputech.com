-- =========================================================================
-- SUCCESS COMPUTECH: COMPLETE DATABASE SCHEMA (ORDERS, PRODUCTS, SETTINGS)
-- Run this in your Supabase Project -> SQL Editor
-- =========================================================================

-- 1. Create Products Table
CREATE TABLE IF NOT EXISTS public.products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ DEFAULT now(),
    title TEXT NOT NULL,
    category TEXT NOT NULL,
    occasion TEXT DEFAULT 'All',
    price NUMERIC NOT NULL,
    mrp NUMERIC NOT NULL,
    image TEXT NOT NULL,
    images JSONB DEFAULT '[]'::jsonb,
    badge TEXT DEFAULT '',
    description TEXT,
    in_stock BOOLEAN DEFAULT true
);

-- Ensure images column exists
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS images JSONB DEFAULT '[]'::jsonb;

-- 2. Create Orders Table
CREATE TABLE IF NOT EXISTS public.orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ DEFAULT now(),
    order_code TEXT NOT NULL,
    customer_name TEXT NOT NULL,
    customer_phone TEXT NOT NULL,
    delivery_address TEXT,
    items JSONB NOT NULL,
    total_amount NUMERIC NOT NULL,
    status TEXT DEFAULT 'Order Placed',
    payment_id TEXT DEFAULT '',
    payment_status TEXT DEFAULT 'Pending'
);

-- Ensure payment columns exist on orders
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS payment_id TEXT DEFAULT '';
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS payment_status TEXT DEFAULT 'Pending';

-- 3. Create Store Settings Table
CREATE TABLE IF NOT EXISTS public.store_settings (
    id INT PRIMARY KEY DEFAULT 1,
    brand_name TEXT DEFAULT 'Success Computech',
    brand_tagline TEXT DEFAULT 'Personalized Gifts • Photo Restoration • Tiruppur',
    whatsapp TEXT DEFAULT '919944444834',
    upi_id TEXT DEFAULT 'successcomputech@upi',
    address TEXT DEFAULT 'Success Computech, Tiruppur, Tamil Nadu - 641604',
    announcement TEXT DEFAULT '🎁 Order via WhatsApp for instant photo preview! 100% Quality Guaranteed.'
);

-- Seed Initial Store Settings
INSERT INTO public.store_settings (id, brand_name, brand_tagline, whatsapp, upi_id, address, announcement)
VALUES (1, 'Success Computech', 'Personalized Gifts • Photo Restoration • Tiruppur', '919944444834', 'successcomputech@upi', 'Success Computech, Tiruppur, Tamil Nadu - 641604', '🎁 Order via WhatsApp for instant photo preview!')
ON CONFLICT (id) DO UPDATE SET whatsapp = '919944444834';

-- =========================================================================
-- CRITICAL: DISABLE ROW LEVEL SECURITY (RLS)
-- Disabling RLS ensures that:
-- 1. Orders placed by customers immediately appear in your Admin Panel!
-- 2. Admin can view, update, and manage orders without login restrictions!
-- 3. Products can be added with 4 photos without any security policy blocking!
-- =========================================================================
ALTER TABLE public.orders DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.products DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.store_settings DISABLE ROW LEVEL SECURITY;

-- Reload schema cache
NOTIFY pgrst, 'reload schema';
