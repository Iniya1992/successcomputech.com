const SUPABASE_CONFIG = {
  url: 'https://lucreiumgboxhegkea.supabase.co',
  anonKey: 'sb_publishable_TZ8AI-FcanuOTqQ4OS64aQ_4ABwNB4e'
};

const SUPABASE_FUNCTION_URL =
  'https://lucreiumgboxhegkea.supabase.co/functions/v1';

const SUPABASE_PUBLISHABLE_KEY =
  SUPABASE_CONFIG.anonKey;

const RAZORPAY_KEY_ID =
  'rzp_live_TfW6dNkxxxgFBK
';

let supabaseClient = null;

if (
  typeof supabase !== 'undefined' &&
  SUPABASE_CONFIG.url &&
  SUPABASE_CONFIG.anonKey &&
  !SUPABASE_CONFIG.anonKey.includes('YOUR_')
) {
  supabaseClient = supabase.createClient(
    SUPABASE_CONFIG.url,
    SUPABASE_CONFIG.anonKey
  );

  console.log('Connected to Supabase successfully.');
}
