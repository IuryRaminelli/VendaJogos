<?php
	session_start();
	include_once '../DataBase/conexao.php';
	include_once '../App/Controle/clienteControle.php';

	$user = new clienteControle();

	$result = $user->isLoggedIn();
	if($result){
		header('Location: index.php');
	}

	if (isset($_POST['entrar'])) {
		$email = trim($_POST['email']);
		$senha = trim(md5($_POST['senha']));
		if ($user->login($email, $senha)) {
			header('Location: index.php');
			exit;
		}else{
			echo "<META HTTP-EQUIV=REFRESH CONTENT = '0;URL= login.php'>
					<script type=\"text/javascript\">
						alert(\"Senha ou email incorretos!\");
					</script>
				";
		}
	}
?>

<!DOCTYPE HTML>
<head>
    <?php
		include_once('head.html');
	?>
</head>
<body>
<nav class="navbar navbar-expand-lg bg-light">
		<div class="container">
			<a class="navbar-brand" href="index.php">
				<img src="imagens/logoo-ads.png" alt="Logo" width="67" height="67" class="d-inline-block align-text-top">
			</a>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav">
					<li class="nav-item">
						<a class="nav-link" href="index.php">Inicio</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="shop.php">Jogos</a>
					</li>
					<?php
						if ($result == true) {
							echo '
							<li class="nav-item">
							<a class="nav-link" href="list.php"> Seus Jogos </a>
							</li>';
						}
					?>
				</ul>
				<ul class="navbar-nav">
					<?php
						if ($result == true) {
							echo '
								<li class="nav-item">
								<a class="nav-link" href="cart.php"><i class="icon-shopping-cart"></i> Carrinho </a>
								</li>
								<li class="nav-item">
								<a class="nav-link" href="../App/Controle/logout.php"> Sair </a>
								</li>';
						}else{
							echo '
							<li class="nav-item">
							<a class="nav-link active" aria-current="page" href="login.php"> Login/Cadastre-se </a>
							</li>';
						}
					?>
				</ul>
			</div>
		</div>
	</nav>

	<br>
	<div class="container" style="width: 40%;">
		<form align="center" method="POST" action="login.php">
			<h2>LOGIN</h2>
			<label for="email">Email</label>
			<input 
				type="text" 
				id="email" 
				name="email" 
				class="form-control" 
				placeholder="Digite seu email" 
				pattern="^[\w]{1,}[\w.+-]{0,}@[\w-]{2,}([.][a-zA-Z]{2,}|[.][\w-]{2,}[.][a-zA-Z]{2,})$" required>

			<br>

			<label for="senha">Senha</label>
			<input 
				type="password" 
				id="senha" 
				name="senha" 
				class="form-control" 
				placeholder="Digite sua senha" required> 
									
			<br>

			<label> <a href="cadastro.php"> Não possui cadastro? </a> </label>
			<br><br>
			<button 
				type="submit" 
				name="entrar" 
				class="btn btn-primary"
				>Entrar</button>
		</form>
		<br><br><br><br><br><br><br><br><br><br>
		<br><br><br><br><br>
		<?php
			include_once 'footer.html';
		?>
	</div>
</body>
</html>

