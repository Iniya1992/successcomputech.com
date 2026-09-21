// =========================================================================
// SUCCESS COMPUTECH - CONFIGURATION (SUPABASE & RAZORPAY)
// =========================================================================

const SUPABASE_CONFIG = {
  url: 'https://lucreiiulmgboxhegkea.supabase.co',
  anonKey: 'sb_publishable_TZ8AI-FcanuOTqQ4OS64aQ_4ABwNB4e',
  // Paste your Razorpay Key ID here from: Razorpay Dashboard -> Settings -> API Keys
  razorpayKeyId: 'rzp_test_YOUR_KEY_HERE' 
};

// Initialize Supabase Client
let supabaseClient = null;
if (typeof supabase !== 'undefined' && SUPABASE_CONFIG.url && !SUPABASE_CONFIG.url.includes('YOUR_PROJECT_REF')) {
  supabaseClient = supabase.createClient(SUPABASE_CONFIG.url, SUPABASE_CONFIG.anonKey);
  console.log('Connected to Supabase successfully.');
} else {
  console.warn('Supabase credentials not set or using fallback local demo mode.');
}
