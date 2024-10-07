<?php
	session_start();
	include_once '../DataBase/conexao.php';
	include_once '../App/Controle/clienteControle.php';

	$user = new clienteControle();

	$result = $user->isLoggedIn();
	if($result){
		header('Location: login.php');
	}

	function addCliente($dados){
		$cliente = new ClienteControle();
		$result = $cliente->cadastrarCliente($_POST);

		if ($result){
			echo "
				<META HTTP-EQUIV=REFRESH CONTENT = '0;URL=login.php'>
				<script type=\"text/javascript\">
					alert(\"Cadastro realizado com sucesso!\");
				</script>
				";
		}else{
			echo "Erro ao cadastrar";
			$result->errorInfo();
		}
	}

	if(isset($_POST['email']) and isset($_POST['cpf'])){ 
		$email = $_POST['email'];
		$cpf = $_POST['cpf'];

		$conexao = new Conexao();
		$conexao = $conexao->conexao();
		$stmt = $conexao->prepare('SELECT * FROM cliente WHERE email = "'.$email.'"');
		$stmt->execute();

		$stmt2 = $conexao->prepare('SELECT * FROM cliente WHERE cpf = "'.$cpf.'"');
		$stmt2->execute();

		$count2 = $stmt2->rowCount();
		$count = $stmt->rowCount();

		if($count > 0){
			echo "
				<META HTTP-EQUIV=REFRESH CONTENT = '0;URL=cadastro.php'>
				<script type=\"text/javascript\">
					alert(\"Email já existente, por favor digite outro!\");
				</script>
				";
		}else if( $count2 > 0){
			echo "
				<META HTTP-EQUIV=REFRESH CONTENT = '0;URL=cadastro.php'>
				<script type=\"text/javascript\">
					alert(\"Cpf já existente, por favor digite outro!\");
				</script>
				";
		}else{
			addCliente($_POST);
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
		<form align="center" method="POST" action="cadastro.php">
			<h2>CADASTRE-SE</h2>
			<label for="Nome"> Nome </label>
			<input 
				type="text" 
				name="Nome" 
				id="Nome" 
				class="form-control" 
				pattern="[A-Za-z-0-9., -]{4,255}$"
				placeholder="Ex: Iury"
				oninvalid="setCustomValidity('Por favor, insira pelo menos 7 letras!')">

			<br>

			<label for="dataNascimento"> Data de Nascimento </label>
			<input 
				type="Date" 
				name="dataNascimento" 
				id="dataNascimento" 
				class="form-control" 
				pattern="[0-9]{2}\/[0-9]{2}\/[0-9]{4}$"
				min="1970-01-01" 
				max="2006-01-01" 
				placeholder="Digite sua data de nascimento">
											
			<br>

			<label for="cpf"> CPF </label>
			<input 
				type="text"
				title="Digite o CPF no formato 000.000.000-00" 
				class="form-control" 
				pattern="\d{3}\.\d{3}\.\d{3}-\d{2}"
				id="cpf" 
				name="cpf" 
				placeholder="Digite seu CPF">

			<br>

			<label for="email"> Email </label>
			<input 
				type="email" 
				id="email" 
				name="email" 
				class="form-control" 
				pattern="^[\w]{1,}[\w.+-]{0,}@[\w-]{2,}([.][a-zA-Z]{2,}|[.][\w-]{2,}[.][a-zA-Z]{2,})$"
				placeholder="Digite seu email">

			<br>

			<label for="senha"> Senha </label>
			<input 
				type="password" 
				id="senha" 
				name="senha" 
				class="form-control" 
				pattern="^.{6,15}$"
				title="Senha com no minímo 6 caracteres de letras e números" 
				placeholder="Senha com no minímo 6 caracteres de letras e números">
											
			<br>

			<label> <a href="login.php"> Já possui cadastro? </a> </label> 
			<br><br>
			<button 
				type="submit" 
				name="cadastrar" 
				class="btn btn-primary"
				>Cadastrar</button>
		</form>
		<br><br><br><br><br>
		<?php
			include_once "footer.html";
		?>
	</div>
</body>
</html>