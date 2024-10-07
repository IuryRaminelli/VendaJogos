<?php
	session_start();
	include_once 'head.html';
	include_once '../DataBase/conexao.php';
	include_once '../App/Controle/clienteControle.php';

	$user = new clienteControle();
	$result = $user->isLoggedIn();
	$conn = new Conexao();
	$conn = $conn->conexao();
	$stmt = $conn->prepare('SELECT * FROM estado');
	
	$stmt->execute();
	
	$resultado_estados = $stmt->fetchAll();
	$cpf = $_SESSION["user_cpf"];
	$stmt2 = $conn->prepare('
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
	$stmt2->execute();
	$resultado_carrinho = $stmt2->fetchAll();

	if($result == false){
		header('Location: login.php');
	}else if(!isset($_GET['proximo'])){
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
			<div class="progress-bar" role="progressbar" aria-label="Segment three" style="width: 33%" aria-valuenow="33" aria-valuemin="0" aria-valuemax="100">Pagamento</div>
		</div>

		<br>
		
			<form method="post" action="../App/Controle/insertFinalizado.php" class="colorlib-form">
				<div class="row">
					<div class="col-md-6">
						<h2>Endereço para entrega</h2>
						<br>
			              	<div class="row">
				               <div class="col-md-12">
				                  <div class="form-group">
				                  	<label for="country">Estado</label>
				                    <div class="form-field">
				                     	<select class="form-control" name="id_estado" id="id_estado" required>
											<option value=""> Selecione...</option>
												<?php 
												foreach( $resultado_estados as $row ) { 
													echo '<option value="'.$row['Uf'].'">'.$row['Nome'].'</option>';
												} 
												?>

										</select>			                 
				                    </div>
				                </div>
								<br>
				                <div class="form-group">
				                  	<label for="id_cidade">Municipio</label>
				                     <div class="form-field">
				                     	<select class="form-control" name="id_cidade" id="id_cidade" required>
											<option value="#id_cidade">Selecione...</option>
										</select>			                 
				                    </div>
				                    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
									<script type="text/javascript">
										$('#id_estado').change(function (){
											var valor = document.getElementById("id_estado").value;
											$.get("exibe_cidade.php?search=" + valor, function (data) {
												$("#id_cidade").find("option").remove();
												$('#id_cidade').append(data);
											});
										});
									</script>
				                </div>
				            </div>
				        </div>
					</div>
					<div class="col-md-6">
						<div class="cart-detail">
							<h2>Resumo</h2>
							<br>
							<table class="table">
								<thead>
								<tr>
									<th scope="col">Quantidade</th>
									<th scope="col">Nome</th>
									<th scope="col">Total</th>
								</tr>
								</thead>
								<tbody>
									<?php 
										$count = 0;
										$total = 0;
										foreach( $resultado_carrinho as $row ) { 
											$count = $row[1]*$row[4];
											$total = $count + $total;
											echo '
												<tr>
													<td>
													<span>'.$row[4].'x </span>
													</td>
													<td>
													<span>'.$row[0].'</span>
													</td> 
													<td>
													<span>R$ '.number_format($row[1]*$row[4],2,",",".").'</span>
													</td></tr>';
										}
										echo '<td><br>TOTAL:  R$ '.number_format($total,2,",",".").'</td>';
									?>
								</tbody>
							</table>
							<div class="row">
								<div class="col-md-12">
									<p><input type="submit" class="btn btn-primary" value="Finalizar" name="enviar"></input></p>
									<p><a href="cart.php" class="btn btn-primary">Voltar para o carrinho </a></p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>		
			<br>
			<?php
				require_once("footer.html")
			?>
		</div>
	
	</body>
</html>
