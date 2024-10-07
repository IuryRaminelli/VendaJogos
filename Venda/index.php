<?php
	session_start();
	include_once('../App/Controle/clienteControle.php');

	$user = new clienteControle();

	$result = $user->isLoggedIn();

?>

<!DOCTYPE html>
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
						<a class="nav-link active" aria-current="page" href="index.php">Inicio</a>
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
	<div id="carouselExampleDark" class="carousel carousel-dark slide" data-bs-ride="carousel">
		<div class="carousel-indicators">
			<button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
			<button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="1" aria-label="Slide 2"></button>
		</div>
		<div class="carousel-inner">
			<div class="carousel-item active" data-bs-interval="5000">
				<img src="imagens/bannerGODofWAR.webp" class="d-block w-100" alt="God of War">
				<div class="carousel-caption d-none d-md-block">
					<a href="jogoGoW.php" class="btn btn-light">Confira os jogos</a>
				</div>
			</div>
			<div class="carousel-item" data-bs-interval="5000">
				<img src="imagens/bannerRE3.jpg" class="d-block w-100" alt="Resident Evil">
				<div class="carousel-caption d-none d-md-block">
					<a href="jogoRE.php" class="btn btn-light">Confira os jogos</a>
				</div>
			</div>
		</div>
		<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span>
			<span class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span>
			<span class="visually-hidden">Next</span>
		</button>
	</div>
	<br><br><br><br>
    <?php
        include_once('footer.html');
    ?>
</div>
	
</div>
</body>
</html>