<?php
	session_start();
	include_once '../App/Controle/plataformaControle.php';
	include_once '../App/Controle/jogoControle.php';
	include_once '../App/Controle/carrinhoControle.php';
	include_once '../App/Controle/clienteControle.php';
	
	$user = new clienteControle();
	$result = $user->isLoggedIn();	
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
						<a class="nav-link active" aria-current="page" href="shop.php">Jogos</a>
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
	<ul class="nav justify-content-center">
		<li class="nav-item">
			<a class="nav-link active" aria-current="page" href="shop.php">Todos</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="shopps5.php">PS5</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="shopps4.php">PS4</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="shopps3.php">PS3</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="shopxbox360.php">XBOX 360</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="shopxboxone.php">XBOX ONE</a>
		</li>
	</ul>

	<br>

	<?php
		$plataformas = plataformaControle::allPlataformas();
		$produtos = jogoControle::allProdutos();
		foreach ($produtos as $produto) {
			$plataforma = plataformaControle::getPlataformaById($produto[2]);
			if (strcasecmp($plataforma['nome'], "PS4") === 0) {
				echo '
				<div class="card-group">
					<div class="card mb-3 text-center"">
						<div class="row g-0">
							<div class="col-md-1">
								<h2></h2>
							</div>
							<div class="col-md-2">
								<img src="imagens/'.$produto[5].'.png" class="img-fluid rounded-start">
							</div>
							<div class="col-md-8">
								<div class="card-body">
									<br>
									<h2 class="card-title">'.$produto[1].'</h2>
									<br>
									<h5 class="card-subtitle mb-2 text-muted">'.$plataforma['nome'].'</h5>
									<br>
									<h5 class="price"><span>R$ '.number_format($produto[4],2,",",".").'</span></h5>
									<br>
									<a href="../App/Controle/addCarrinho.php?jogo='.$produto[0].'" class="btn btn-primary">Adicionar ao carrinho</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				';
			}
		}
	?>
	<br>
	<?php
		include_once("footer.html");
	?>
</div>
</body>
</html>

