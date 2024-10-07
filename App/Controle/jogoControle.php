<?php
/**
 * Arquivo que retorna todos os produtos disponiveis do db
 */
include_once '../DataBase/conexao.php';

class jogoControle {

    public static function allProdutos(){
        $conexao = new Conexao();
        $conexao = $conexao->conexao();
        $stmt = $conexao->prepare("SELECT * FROM jogo;");
        $stmt->execute();
        $produtos = $stmt->fetchAll();
        $stmt = null;
        return $produtos;
    }
}

?>