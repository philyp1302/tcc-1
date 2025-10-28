import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/+esm'

// 🔧 Substitua pelos dados do seu projeto Supabase:
const SUPABASE_URL = 'https://SEU-PROJETO.supabase.co'
const SUPABASE_ANON_KEY = 'SEU-CHAVE-ANON'
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY)

// =============================
// LOGIN COM E-MAIL/SENHA
// =============================
document.getElementById('loginForm').addEventListener('submit', async (e) => {
  e.preventDefault()

  const emailOrUser = document.getElementById('loginUser').value.trim()
  const password = document.getElementById('loginPass').value

  // Suporte a login tanto com e-mail quanto com usuário (se desejar)
  const { data, error } = await supabase.auth.signInWithPassword({
    email: emailOrUser,
    password
  })

  if (error) {
    document.getElementById('authMsg').textContent = 'Erro: ' + error.message
  } else {
    // ✅ Redireciona para a dashboard
    window.location.href = 'https://philyp1302.github.io/tcc-1/dashboard.html'
  }
})

// =============================
// LOGIN COM GOOGLE
// =============================
document.getElementById('googleLoginBtn').addEventListener('click', async () => {
  const { data, error } = await supabase.auth.signInWithOAuth({
    provider: 'google',
    options: {
      redirectTo: 'https://philyp1302.github.io/tcc-1/dashboard.html'
    }
  })

  if (error) {
    document.getElementById('authMsg').textContent = 'Erro no login com Google: ' + error.message
  }
})
