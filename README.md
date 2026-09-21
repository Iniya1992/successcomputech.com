# Success Computech: Secure E-Commerce & Admin Architecture

A secure, high-performance web platform tailored for **Success Computech** (Personalized Gifts, Tiruppur) with separated public customer storefront and protected admin control.

---

## 1. Directory Structure

```text
├── index.html            # Public Customer Storefront (Products, Cart, WhatsApp order)
├── admin.html            # Protected Admin Portal (Direct URL access)
├── admin/
│   ├── index.html        # Protected Admin Portal (Access via /admin/)
│   └── config.js         # Admin config link
├── config.js             # Supabase Project URL & Anon Key
├── supabase_schema.sql   # Database tables & Row Level Security (RLS) policies
└── README.md             # Setup guide
```

---

## 2. Security Highlights

* **100% Clean Customer Storefront (`index.html`):**
  No admin buttons, no management controls, no business settings, and no passwords exist in the customer view.
* **Separated Admin Route (`/admin` or `admin.html`):**
  Protected by **Supabase Authentication** (Email & Password).
* **Row Level Security (RLS) Database Protection:**
  - **Public (Customers):** Can only `SELECT` active in-stock products, view store settings, and `INSERT` orders upon checkout.
  - **Admin (Authenticated):** Exclusively permitted to `INSERT`, `UPDATE`, `DELETE` products, view all customer orders, update order fulfillment status, and modify store settings.

---

## 3. Quick Setup Steps

### Step 1: Create a Free Supabase Project
1. Go to **https://supabase.com** and sign up for a free account.
2. Click **New Project** and name it (e.g. `success-computech-gifts`). Choose the nearest region (e.g., *Singapore* or *Mumbai*).

### Step 2: Run Database Schema & Security Policies
1. In your Supabase Dashboard, click on **SQL Editor** on the left menu.
2. Click **New Query**, copy the entire contents of `supabase_schema.sql`, paste it, and click **Run**.
3. This creates the `products`, `orders`, and `store_settings` tables, seeds sample gifts, and enables RLS policies.

### Step 3: Create Your Admin Account
1. In Supabase Dashboard, go to **Authentication** > **Users**.
2. Click **Add User** > **Create User**.
3. Enter your admin email (e.g., `admin@successcomputech.com`) and a strong password.

### Step 4: Configure `config.js`
1. In Supabase Dashboard, go to **Project Settings** > **API**.
2. Copy your **Project URL** and **anon public key**.
3. Open `config.js` in a text editor and paste them:
   ```javascript
   const SUPABASE_CONFIG = {
     url: 'https://your-project-id.supabase.co',
     anonKey: 'your-anon-public-key'
   };
   ```

### Step 5: Publish to GitHub Pages
1. Upload these files to your GitHub repository.
2. Go to **Settings** > **Pages** > Select `main` branch > Save.
3. Your live URLs:
   - **Customer Storefront:** `https://<your-username>.github.io/<repo-name>/` (or your custom domain `https://successcomputech.in/`)
   - **Admin Portal:** `https://<your-username>.github.io/<repo-name>/admin/` (or `https://successcomputech.in/admin/`)
