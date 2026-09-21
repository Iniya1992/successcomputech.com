// =========================================================================
// SUCCESS COMPUTECH - SUPABASE CONFIGURATION
// =========================================================================

const SUPABASE_CONFIG = {
  url: 'https://lucreiiulmgboxhegkea.supabase.co',
  anonKey: 'sb_publishable_TZ8AI-FcanuOTqQ4OS64aQ_4ABwNB4e'
};

// Initialize Supabase Client
let supabaseClient = null;
if (typeof supabase !== 'undefined' && SUPABASE_CONFIG.url && !SUPABASE_CONFIG.url.includes('YOUR_PROJECT_REF')) {
  supabaseClient = supabase.createClient(SUPABASE_CONFIG.url, SUPABASE_CONFIG.anonKey);
  console.log('Connected to Supabase successfully.');
} else {
  console.warn('Supabase credentials not set or using fallback local demo mode.');
}
