<?php
	session_start();
	include_once '../App/Controle/ListControle.php';
	include_once '../App/Controle/clienteControle.php';

	$user = new clienteControle();
	$result = $user->isLoggedIn();

	if($result == false){
		header('Location: login.php');
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
							<a class="nav-link active" aria-current="page" href="list.php"> Seus Jogos </a>
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
  <table class="table">
    <thead>
      <tr>
        <th scope="col">Detalhe dos jogos</th>
        <th scope="col">Preço</th>
        <th scope="col">Quantidade</th>
        <th scope="col">Total</th>
      </tr>
    </thead>
    <tbody>
      <?php
      $pCarrinho = ListControle::selectList();
      foreach ($pCarrinho as $jogo) {
        $totalPrice = $jogo[3] * $jogo[1];
        echo "<tr>";
        echo '<td class="product-details">';
        echo '<div class="product-image">';
        echo '<img src="imagens/' . $jogo[2] . '.png" width="100" height="100">';
		echo '<br><span class="product-name">' . $jogo[0] . '</span>';
        echo '</div>';
        echo '</td>';
        echo "<td><br><br>R$ " . number_format($jogo[1], 2, ",", ".") . "</td>";
        echo "<td><br><br>" . $jogo[3] . "</td>";
        echo "<td><br><br>R$ " . number_format($totalPrice, 2, ",", ".") . "</td>";
        echo "</tr>";
      }
      ?>
    </tbody>
  </table>
</div>
	<?php
		require_once("footer.html")
	?>

	<div class="gototop js-top">
		<a href="#" class="js-gotop"><i class="icon-arrow-up2"></i></a>
	</div>

	</body>
</html>

