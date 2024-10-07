<?php
	session_start();
	include_once '../DataBase/conexao.php';
	include_once '../App/Controle/clienteControle.php';

	$conn = new Conexao();
	$conn = $conn->conexao();

	$user = new clienteControle();
	$result = $user->isLoggedIn();
	
	$stmt4 = $conn->prepare('
		SELECT * FROM carrinho_has_jogo;');
	$stmt4->execute();
	$count = 0;
	$count = $stmt4->rowCount();

	if($result == false){
		header('Location: login.php');
	}

	$cpf = $_SESSION["user_cpf"];
	$stmt = $conn->prepare('
		SELECT jogo.nome, jogo.valor, jogo.imagem, jogo.idjogo, gerou.quantidade FROM jogo 

		INNER JOIN
			(SELECT carrinho_has_jogo.jogo_idjogo, carrinho_has_jogo.quantidade FROM carrinho_has_jogo
				INNER JOIN jogo ON carrinho_has_jogo.jogo_idjogo = jogo.idjogo
				INNER JOIN carrinho ON carrinho_has_jogo.carrinho_idcarrinho = carrinho.idcarrinho 
		        WHERE carrinho.cliente_cpf = "'.$cpf.'"
			GROUP BY carrinho_has_jogo.jogo_idjogo) as gerou 

		ON jogo.idjogo = gerou.jogo_idjogo
    	GROUP BY jogo.nome;');

	$total = 0;
	$stmt->execute();
		
	$resultado_carrinho = $stmt->fetchAll();
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
			<div class="progress-bar" role="progressbar" aria-label="Segment two" style="width: 34%" aria-valuenow="34" aria-valuemin="0" aria-valuemax="100">Endereço</div>
			<div class="progress-bar" role="progressbar" aria-label="Segment three" style="width: 33%" aria-valuenow="33" aria-valuemin="0" aria-valuemax="100">Pagamento</div>
		</div>

		<br>

		<table class="table">
			<thead>
			<tr>
				<th scope="col">Detalhe dos jogos</th>
				<th scope="col">Preço</th>
				<th scope="col">Quantidade</th>
				<th scope="col">Total</th>
				<th scope="col">Remover</th>
			</tr>
			</thead>
			<tbody>

			<?php
				$count = 0;
				$total = 0;
				foreach($resultado_carrinho as $row ) {
					$totalPrice = $row[4] * $row[1];
					echo "<tr>";
					echo '<td class="product-details">';
					echo '<div class="product-image">';
					echo '<img src="imagens/' . $row[2] . '.png" width="100" height="100">';
					echo '<br><span>' . $row[0] . '</span>';
					echo '</div>';
					echo '</td>';

					echo "<td><br><br> R$ " . number_format($row[1], 2, ",", ".") . "</td>";
					echo '
					<td><br>
						<form method="post" action="../App/Controle/updateQtd.php">
							<input style="width: 25%;" type="number" for="id_quantidade" name="id_quantidade" id="id_quantidade" class="form-control text-center" value="'.$row[4].'" min="1" max="100"> 
							<input style="visibility: hidden; width:2%;height:2%;" type="number" name="idjogo" value="'.$row[3].'">
							<button class="btn btn-primary"> alterar </button>
						</form>
					
					</td>';
					echo "<td><br><br>R$ " . number_format($totalPrice, 2, ",", ".") . "</td>";
					echo '<td><br><br><a href="../App/Controle/delete.php?jogo='.$row[3].'" class="btn-close" aria-label="Close"></a></td>';
					echo "</tr>";
					$count = $row[1]*$row[4];
					$total = $count + $total;
				}
			?>
			</tbody>
		</table>
		</div>

				<div class="row">
					<div class="col-md-10 col-md-offset-1">
						<div class="total-wrap">
							<div class="row">
								<div class="col-md-8">
									<form action="#">
										<div class="row form-group">
										</div>
									</form>
								</div>
								<div class="col-md-3 col-md-push-1 text-center">
									<div class="total">
										<div class="grand-total">
											<p><span><strong>Total:</strong></span> <span>R$ <?php echo number_format($total,2,",",".");?>
											</span></p>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<?php
												if ($count == 0) {
													echo '<p><a class="btn btn-primary"   style="opacity: 0.5;
														filter: alpha(opacity=50)"> Proximo </a disabled></p>';
												}else{
													echo '<p><a href="checkout.php?proximo=true&carrinho=true" class="btn btn-primary"> Proximo </a></p>';
												}
											?>
											<p><a href="shop.php" class="btn btn-primary"> Comprar mais jogos </a></p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<br>
		<?php
			require_once("footer.html")
		?>

	</div>

	<div class="gototop js-top">
		<a href="#" class="js-gotop"><i class="icon-arrow-up2"></i></a>
	</div>

	</body>
</html>

