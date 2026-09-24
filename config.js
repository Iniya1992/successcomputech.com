// =========================================================================
// SUCCESS COMPUTECH - CONFIGURATION
// =========================================================================

const SUPABASE_CONFIG = {
  url: 'https://lucreiiulmgboxhegkea.supabase.co',
  anonKey: 'sb_publishable_TZ8AI-FcanuOTqQ4OS64aQ_4ABwNB4e',
  razorpayKeyId: 'rzp_live_TfW6dNkxxxgFBK' // Replace with your Razorpay Key ID
};

// Initialize Supabase Client safely
let supabaseClient = null;
try {
  if (typeof supabase !== 'undefined' && SUPABASE_CONFIG.url && !SUPABASE_CONFIG.url.includes('YOUR_PROJECT_REF')) {
    supabaseClient = supabase.createClient(SUPABASE_CONFIG.url, SUPABASE_CONFIG.anonKey);
    console.log('Supabase client initialized.');
  }
} catch (e) {
  console.warn('Supabase initialization failed, running in resilient fallback mode.', e);
}
