// =========================================================================
// SUCCESS COMPUTECH - SUPABASE CONFIGURATION
// Paste your Supabase Project URL and Public Anon Key here from:
// Supabase Dashboard -> Settings -> API
// =========================================================================

const SUPABASE_CONFIG = {
  // Replace with your project details:
 url: 'https://lucreiiulmgboxhegkea.supabase.co',
  anonKey:'sb_publishable_TZ8AI-FcanuOTqQ4OS64aQ_4ABwNB4e'
};

// Initialize Supabase Client
let supabaseClient = null;
if (typeof supabase !== 'undefined' && SUPABASE_CONFIG.url && !SUPABASE_CONFIG.url.includes('YOUR_PROJECT_REF')) {
  supabaseClient = supabase.createClient(SUPABASE_CONFIG.url, SUPABASE_CONFIG.anonKey);
  console.log('Connected to Supabase successfully.');
} else {
  console.warn('Supabase credentials not set or using fallback local demo mode.');
}
