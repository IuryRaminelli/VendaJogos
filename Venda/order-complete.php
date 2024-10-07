<?php
	session_start();
	include_once 'head.html';
	include_once '../DataBase/conexao.php';
	include_once '../App/Controle/clienteControle.php';

	$user = new clienteControle();
	$conn = new Conexao();
	$conn = $conn->conexao();

	$result = $user->isLoggedIn();

	$stmt4 = $conn->prepare('
		SELECT * FROM carrinho_has_jogo;');
	$stmt4->execute();
	$count = 0;
	$count = $stmt4->rowCount();

	if($result == false){
		header('Location: login.php');
	}
	else if(!isset($_GET['enviar'])){
		header('Location: cart.php');
	}
?>

<!DOCTYPE HTML>
<head>
    <?php
		include_once('head.html');
	?>
</head>
<html>
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
								<a class="nav-link active" aria-current="page" href="cart.php"><i class="icon-shopping-cart"></i> Carrinho </a>
								</li>
								<li class="nav-item">
								<a class="nav-link" href="../App/Controle/logout.php"> Sair </a>
								</li>';
						}else{
							echo '
							<li class="nav-item">
							<a class="nav-link" href="login.php"> Login/Cadastre-se </a>
							</li>';
						}
					?>
				</ul>
			</div>
		</div>
	</nav>

	<br>


	<div class="container">

		<div class="progress">
			<div class="progress-bar bg-success" role="progressbar" aria-label="Segment one" style="width: 33%" aria-valuenow="33" aria-valuemin="0" aria-valuemax="100">Carrinho de Compras</div>
			<div class="progress-bar bg-success" role="progressbar" aria-label="Segment two" style="width: 34%" aria-valuenow="34" aria-valuemin="0" aria-valuemax="100">Endereço</div>
			<div class="progress-bar bg-success" role="progressbar" aria-label="Segment three" style="width: 33%" aria-valuenow="33" aria-valuemin="0" aria-valuemax="100">Pagamento</div>
		</div>

		<br>
		<div class="row">
			<div class="text-center">
				<span class="icon"><img src="imagens/iconcar.png" alt=""></span>
				<h2>Obrigado por comprar, seu pedido está finalizado</h2>
				<br>
				<p>
					<a href="index.php"class="btn btn-primary">Inicio</a>
					<a href="shop.php"class="btn btn-primary btn-outline">Continue comprando</a>
				</p>
			</div>
		</div>
		<br><br>
		<?php
			require_once("footer.html")
		?>
	</div>
</body>
</html>

