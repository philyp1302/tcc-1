function irPara(pagina) {
  window.location.href = pagina;
}

function login(event) {
  event.preventDefault();
  alert("Login realizado com sucesso!");
  irPara('dashboard.html');
}
