<?php
include_once '../DataBase/conexao.php';

class carrinhoControle {

    public function addCarrinho($dados) {
        $conexao = new Conexao();
        $conexao = $conexao->conexao();
        $stmt = $conexao->prepare("INSERT INTO carrinho(cliente_cpf) VALUES(:cpfCliente);");
        $stmt->bindParam('cpfCliente', $dados['cpf']);
        $stmt->execute();
        $carrinhoId = $conexao->lastInsertId();

        $stmt = $conexao->prepare("INSERT INTO carrinho_has_jogo(carrinho_idcarrinho, jogo_idjogo) VALUES(:carrinho, :jogo);");
        $stmt->bindParam('carrinho', $carrinhoId);
        $stmt->bindParam('jogo', $dados['idjogo']);
        $stmt->execute();
        $stmt = null;

        return true;
    }
}

?>