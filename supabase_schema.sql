-- =========================================================================
-- SUCCESS COMPUTECH: SUPABASE DATABASE SCHEMA & ROW LEVEL SECURITY (RLS)
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
    badge TEXT DEFAULT '',
    description TEXT,
    in_stock BOOLEAN DEFAULT true
);

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
    status TEXT DEFAULT 'Order Placed'
);

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
ON CONFLICT (id) DO NOTHING;

-- Seed Sample Initial Products
INSERT INTO public.products (title, category, occasion, price, mrp, image, badge, description, in_stock)
VALUES 
('Spotify Acrylic LED Frame with Custom Scannable Song', 'Acrylic', 'Love', 599, 899, 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&w=600&q=80', 'Bestseller', 'Premium crystal-clear 4mm acrylic with wooden LED base. Customized with your favourite picture, song name, and scannable Spotify code.', true),
('Customized Wooden Moon Lamp Frame', 'Lighting', 'Anniversary', 490, 799, 'https://images.unsplash.com/photo-1534447677768-be436bb09401?auto=format&fit=crop&w=600&q=80', 'Trending', 'Romantic lunar lamp texture with customized high-resolution photo engraving. Warm ambient light.', true),
('Personalized A4 Couple Photo Puzzle Frame', 'Puzzles', 'Anniversary', 299, 650, 'https://images.unsplash.com/photo-1588072432836-e10032774350?auto=format&fit=crop&w=600&q=80', 'Fun Gift', 'Interactive 120-piece puzzle printed with your high-definition photo. Assembled and framed.', true),
('Calendar Mug with Birthday Photo & Tamil / English Date', 'Mugs', 'Birthday', 349, 425, 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?auto=format&fit=crop&w=600&q=80', 'Popular', 'High-grade ceramic glossy mug marked with recipient birth date circled on a calendar with a personal wish.', true),
('Secret Voice Metal Keychain with QR Code', 'Keychains', 'Love', 199, 399, 'https://images.unsplash.com/photo-1622434641406-a158123450f9?auto=format&fit=crop&w=600&q=80', 'Budget Pick', 'Durable laser-engraved metal keychain with photo on one side and a QR code linking to custom audio/video.', true),
('Luxury Birthday Surprise Hamper with Name Magnet', 'Hampers', 'Birthday', 999, 1899, 'https://images.unsplash.com/photo-1549465220-1a8b9238cd48?auto=format&fit=crop&w=600&q=80', 'Mega Deal', 'Includes personalized chocolate box, name magnet keepsake, mini photo album, and greeting card.', true),
('King & Queen Dual Couple Photo Frames (Set of 2)', 'Frames', 'Anniversary', 799, 1200, 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&w=600&q=80', 'Top Choice', 'A pair of matching royal crown themed black synthetic wood frames crafted for wedding and anniversary milestones.', true),
('Custom Photo Polaroid Transparent Keychain', 'Keychains', 'Friends', 149, 299, 'https://images.unsplash.com/photo-1582845512747-e42001c95638?auto=format&fit=crop&w=600&q=80', 'Under ₹199', 'Double-sided transparent acrylic mini polaroid keychain. Pocket-sized keepsake for friends and couples.', true);

-- =========================================================================
-- ROW LEVEL SECURITY (RLS) POLICIES - SECURE ACCESS CONTROL
-- =========================================================================

-- Enable RLS on all tables
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.store_settings ENABLE ROW LEVEL SECURITY;

-- 1. Products Policies:
-- Public can READ in-stock products
CREATE POLICY "Public can view in-stock products" 
ON public.products FOR SELECT 
TO anon, authenticated 
USING (true);

-- Only logged-in Admins can INSERT, UPDATE, DELETE products
CREATE POLICY "Admins can insert products" 
ON public.products FOR INSERT 
TO authenticated 
WITH CHECK (true);

CREATE POLICY "Admins can update products" 
ON public.products FOR UPDATE 
TO authenticated 
USING (true);

CREATE POLICY "Admins can delete products" 
ON public.products FOR DELETE 
TO authenticated 
USING (true);

-- 2. Orders Policies:
-- Customers (Public/Anon) can create an order when placing a purchase
CREATE POLICY "Public can insert orders" 
ON public.orders FOR INSERT 
TO anon, authenticated 
WITH CHECK (true);

-- ONLY logged-in Admins can VIEW all orders
CREATE POLICY "Admins can view orders" 
ON public.orders FOR SELECT 
TO authenticated 
USING (true);

-- ONLY logged-in Admins can UPDATE order status
CREATE POLICY "Admins can update orders" 
ON public.orders FOR UPDATE 
TO authenticated 
USING (true);

-- 3. Store Settings Policies:
-- Anyone can view store settings (phone, name, address)
CREATE POLICY "Public can read store settings" 
ON public.store_settings FOR SELECT 
TO anon, authenticated 
USING (true);

-- ONLY logged-in Admins can update store settings
CREATE POLICY "Admins can update store settings" 
ON public.store_settings FOR UPDATE 
TO authenticated 
USING (true);

-- =========================================================================
-- SUPPORT FOR UP TO 4 PRODUCT IMAGES
-- =========================================================================
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS images JSONB DEFAULT '[]'::jsonb;

-- =========================================================================
-- SUPPORT FOR RAZORPAY ONLINE PAYMENTS IN ORDERS
-- =========================================================================
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS payment_id TEXT DEFAULT '';
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS payment_status TEXT DEFAULT 'Pending';
