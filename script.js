function login(event) {
  event.preventDefault();

  // Pega os dados do formulário
  const usuario = document.getElementById("usuario").value;
  const email = document.getElementById("email").value;
  const senha = document.getElementById("senha").value;

  // Aqui poderia ser uma validação real com backend.
  if (usuario && email && senha) {
    // Redireciona para dashboard
    window.location.href = "dashboard.html";
  } else {
    alert("Preencha todos os campos!");
  }
}

function togglePassword() {
  const senhaInput = document.getElementById("senha");
  senhaInput.type = senhaInput.type === "password" ? "text" : "password";
}
