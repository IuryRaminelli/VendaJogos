
-- -----------------------------------------------------
-- vendinhaADS
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS produto (
  idproduto INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  descricao VARCHAR(100) NULL,
  valor FLOAT NOT NULL,
  imagem INT NULL,
  PRIMARY KEY (idproduto))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS cliente (
  cpf VARCHAR(30) NOT NULL,
  nome VARCHAR(100) NOT NULL,
  dataNascimento VARCHAR(10) NULL,
  email VARCHAR(100) NOT NULL,
  senha VARCHAR(255) NOT NULL,
  PRIMARY KEY (cpf),
  UNIQUE INDEX email_UNIQUE (email ASC))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS estado (
  Uf VARCHAR(5) NOT NULL,
  Nome VARCHAR(100) NOT NULL,
  PRIMARY KEY (Uf))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS municipio (
  Id INT NOT NULL AUTO_INCREMENT,
  Codigo INT NOT NULL,
  Nome VARCHAR(100) NOT NULL,
  estado_Uf VARCHAR(5) NOT NULL,
  PRIMARY KEY (Id, estado_Uf),
  INDEX fk_municipio_estado1_idx (estado_Uf ASC),
  CONSTRAINT fk_municipio_estado1
    FOREIGN KEY (estado_Uf)
    REFERENCES estado (Uf)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS carrinho (
  idcarrinho INT NOT NULL AUTO_INCREMENT,
  cliente_cpf VARCHAR(30) NOT NULL,
  PRIMARY KEY (idcarrinho, cliente_cpf),
  INDEX fk_carrinho_cliente1_idx (cliente_cpf ASC),
  CONSTRAINT fk_carrinho_cliente1
    FOREIGN KEY (cliente_cpf)
    REFERENCES cliente (cpf)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS carrinho_has_produto (
  carrinho_idcarrinho INT NOT NULL,
  produto_idproduto INT NOT NULL,
  quantidade INT NOT NULL,
  PRIMARY KEY (carrinho_idcarrinho, produto_idproduto),
  INDEX fk_carrinho_has_produto_produto1_idx (produto_idproduto ASC),
  INDEX fk_carrinho_has_produto_carrinho1_idx (carrinho_idcarrinho ASC),
  CONSTRAINT fk_carrinho_has_produto_carrinho1
    FOREIGN KEY (carrinho_idcarrinho)
    REFERENCES carrinho (idcarrinho)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_carrinho_has_produto_produto1
    FOREIGN KEY (produto_idproduto)
    REFERENCES produto (idproduto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS finalizaCompra (
  idfinalizaCompra INT NOT NULL AUTO_INCREMENT,
  carrinho_idcarrinho INT NOT NULL,
  status ENUM('AB', 'CL') NOT NULL,
  municipio_Id INT NOT NULL,
  PRIMARY KEY (idfinalizaCompra, carrinho_idcarrinho, municipio_Id),
  INDEX fk_confirmaCompra_carrinho1_idx (carrinho_idcarrinho ASC),
  INDEX fk_finalizaCompra_municipio1_idx (municipio_Id ASC),
  CONSTRAINT fk_confirmaCompra_carrinho1
    FOREIGN KEY (carrinho_idcarrinho)
    REFERENCES carrinho (idcarrinho)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_finalizaCompra_municipio1
    FOREIGN KEY (municipio_Id)
    REFERENCES municipio (Id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS pedidoConcluido (
  idpedidoConcluido INT NOT NULL AUTO_INCREMENT,
  cliente_cpf VARCHAR(30) NOT NULL,
  nomeProduto VARCHAR(45) NOT NULL,
  valorProduto FLOAT NOT NULL,
  imagemProduto INT NOT NULL,
  qtdProduto INT NOT NULL,
  PRIMARY KEY (idpedidoConcluido, cliente_cpf),
  INDEX fk_pedidoConcluido_cliente1_idx (cliente_cpf ASC),
  CONSTRAINT fk_pedidoConcluido_cliente1
    FOREIGN KEY (cliente_cpf)
    REFERENCES cliente (cpf)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

insert into produto (nome, descricao, valor, imagem) values ('Camisa Branca do curso', 'Camisa algodao, branca lisa', 40.00,1);
insert into produto (nome, descricao, valor, imagem) values ('Moleton curso', 'Moletom e calça algodao', 250.90, 2);
insert into produto (nome, descricao, valor, imagem) values ('Caneca curso', 'Caneca de Aluminio', 50.0, 3);


Insert into estado (Uf, Nome) values ('AC', 'Acre');
Insert into estado (Uf, Nome) values ('AL', 'Alagoas');
Insert into estado (Uf, Nome) values ('AP', 'Amapá');
Insert into estado (Uf, Nome) values ('AM', 'Amazonas');
Insert into estado (Uf, Nome) values ('BA', 'Bahia');
Insert into estado (Uf, Nome) values ('CE', 'Ceará');
Insert into estado (Uf, Nome) values ('DF', 'Distrito Federal');
Insert into estado (Uf, Nome) values ('ES', 'Espírito Santo');
Insert into estado (Uf, Nome) values ('GO', 'Goiás');
Insert into estado (Uf, Nome) values ('MA', 'Maranhão');
Insert into estado (Uf, Nome) values ('MT', 'Mato Grosso');
Insert into estado (Uf, Nome) values ('MS', 'Mato Grosso do Sul');
Insert into estado (Uf, Nome) values ('MG', 'Minas Gerais');
Insert into estado (Uf, Nome) values ('PA', 'Pará');
Insert into estado (Uf, Nome) values ('PB', 'Paraíba');
Insert into estado (Uf, Nome) values ('PR', 'Paraná');
Insert into estado (Uf, Nome) values ('PE', 'Pernambuco');
Insert into estado (Uf, Nome) values ('PI', 'Piauí');
Insert into estado (Uf, Nome) values ('RJ', 'Rio de Janeiro');
Insert into estado (Uf, Nome) values ('RN', 'Rio Grande do Norte');
Insert into estado (Uf, Nome) values ('RS', 'Rio Grande do Sul');
Insert into estado (Uf, Nome) values ('RO', 'Rondônia');
Insert into estado (Uf, Nome) values ('RR', 'Roraima');
Insert into estado (Uf, Nome) values ('SC', 'Santa Catarina');
Insert into estado (Uf, Nome) values ('SP', 'São Paulo');
Insert into estado (Uf, Nome) values ('SE', 'Sergipe');
Insert into estado (Uf, Nome) values ('TO', 'Tocantins');





Insert into municipio (Codigo, Nome, estado_Uf) values ('4300034','Aceguá', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4300059','Água Santa', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4300109','Agudo', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4300208','Ajuricaba', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4300307','Alecrim', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4300406','Alegrete', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4300455','Alegria', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4300471','Almirante Tamandaré do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4300505','Alpestre', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4300554','Alto Alegre', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4300570','Alto Feliz', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4300604','Alvorada', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4300638','Amaral Ferrador', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4300646','Ametista do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4300661','André da Rocha', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4300703','Anta Gorda', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4300802','Antônio Prado', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4300851','Arambaré', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4300877','Araricá', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4300901','Aratiba', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4301008','Arroio do Meio', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4301057','Arroio do Sal', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4301073','Arroio do Padre', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4301107','Arroio dos Ratos', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4301206','Arroio do Tigre', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4301305','Arroio Grande', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4301404','Arvorezinha', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4301503','Augusto Pestana', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4301552','Áurea', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4301602','Bagé', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4301636','Balneário Pinhal', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4301651','Barão', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4301701','Barão de Cotegipe', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4301750','Barão do Triunfo', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4301800','Barracão', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4301859','Barra do Guarita', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4301875','Barra do Quaraí', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4301909','Barra do Ribeiro', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4301925','Barra do Rio Azul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4301958','Barra Funda', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4302006','Barros Cassal', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4302055','Benjamin Constant do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4302105','Bento Gonçalves', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4302154','Boa Vista das Missões', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4302204','Boa Vista do Buricá', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4302220','Boa Vista do Cadeado', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4302238','Boa Vista do Incra', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4302253','Boa Vista do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4302303','Bom Jesus', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4302352','Bom Princípio', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4302378','Bom Progresso', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4302402','Bom Retiro do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4302451','Boqueirão do Leão', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4302501','Bossoroca', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4302584','Bozano', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4302600','Braga', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4302659','Brochier', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4302709','Butiá', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4302808','Caçapava do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4302907','Cacequi', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4303004','Cachoeira do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4303103','Cachoeirinha', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4303202','Cacique Doble', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4303301','Caibaté', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4303400','Caiçara', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4303509','Camaquã', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4303558','Camargo', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4303608','Cambará do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4303673','Campestre da Serra', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4303707','Campina das Missões', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4303806','Campinas do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4303905','Campo Bom', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4304002','Campo Novo', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4304101','Campos Borges', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4304200','Candelária', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4304309','Cândido Godói', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4304358','Candiota', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4304408','Canela', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4304507','Canguçu', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4304606','Canoas', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4304614','Canudos do Vale', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4304622','Capão Bonito do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4304630','Capão da Canoa', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4304655','Capão do Cipó', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4304663','Capão do Leão', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4304671','Capivari do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4304689','Capela de Santana', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4304697','Capitão', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4304705','Carazinho', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4304713','Caraá', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4304804','Carlos Barbosa', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4304853','Carlos Gomes', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4304903','Casca', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4304952','Caseiros', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305009','Catuípe', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305108','Caxias do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305116','Centenário', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305124','Cerrito', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305132','Cerro Branco', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305157','Cerro Grande', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305173','Cerro Grande do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305207','Cerro Largo', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305306','Chapada', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305355','Charqueadas', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305371','Charrua', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305405','Chiapetta', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305439','Chuí', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305447','Chuvisca', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305454','Cidreira', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305504','Ciríaco', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305587','Colinas', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305603','Colorado', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305702','Condor', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305801','Constantina', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305835','Coqueiro Baixo', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305850','Coqueiros do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305871','Coronel Barros', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305900','Coronel Bicaco', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305934','Coronel Pilar', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305959','Cotiporã', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4305975','Coxilha', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306007','Crissiumal', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306056','Cristal', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306072','Cristal do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306106','Cruz Alta', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306130','Cruzaltense', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306205','Cruzeiro do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306304','David Canabarro', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306320','Derrubadas', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306353','Dezesseis de Novembro', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306379','Dilermando de Aguiar', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306403','Dois Irmãos', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306429','Dois Irmãos das Missões', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306452','Dois Lajeados', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306502','Dom Feliciano', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306551','Dom Pedro de Alcântara', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306601','Dom Pedrito', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306700','Dona Francisca', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306734','Doutor Maurício Cardoso', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306759','Doutor Ricardo', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306767','Eldorado do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306809','Encantado', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306908','Encruzilhada do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306924','Engenho Velho', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306932','Entre-Ijuís', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306957','Entre Rios do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4306973','Erebango', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4307005','Erechim', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4307054','Ernestina', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4307104','Herval', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4307203','Erval Grande', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4307302','Erval Seco', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4307401','Esmeralda', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4307450','Esperança do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4307500','Espumoso', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4307559','Estação', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4307609','Estância Velha', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4307708','Esteio', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4307807','Estrela', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4307815','Estrela Velha', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4307831','Eugênio de Castro', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4307864','Fagundes Varela', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4307906','Farroupilha', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4308003','Faxinal do Soturno', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4308052','Faxinalzinho', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4308078','Fazenda Vilanova', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4308102','Feliz', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4308201','Flores da Cunha', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4308250','Floriano Peixoto', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4308300','Fontoura Xavier', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4308409','Formigueiro', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4308433','Forquetinha', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4308458','Fortaleza dos Valos', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4308508','Frederico Westphalen', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4308607','Garibaldi', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4308656','Garruchos', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4308706','Gaurama', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4308805','General Câmara', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4308854','Gentil', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4308904','Getúlio Vargas', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4309001','Giruá', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4309050','Glorinha', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4309100','Gramado', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4309126','Gramado dos Loureiros', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4309159','Gramado Xavier', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4309209','Gravataí', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4309258','Guabiju', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4309308','Guaíba', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4309407','Guaporé', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4309506','Guarani das Missões', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4309555','Harmonia', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4309571','Herveiras', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4309605','Horizontina', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4309654','Hulha Negra', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4309704','Humaitá', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4309753','Ibarama', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4309803','Ibiaçá', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4309902','Ibiraiaras', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4309951','Ibirapuitã', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4310009','Ibirubá', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4310108','Igrejinha', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4310207','Ijuí', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4310306','Ilópolis', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4310330','Imbé', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4310363','Imigrante', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4310405','Independência', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4310413','Inhacorá', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4310439','Ipê', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4310462','Ipiranga do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4310504','Iraí', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4310538','Itaara', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4310553','Itacurubi', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4310579','Itapuca', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4310603','Itaqui', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4310652','Itati', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4310702','Itatiba do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4310751','Ivorá', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4310801','Ivoti', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4310850','Jaboticaba', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4310876','Jacuizinho', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4310900','Jacutinga', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311007','Jaguarão', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311106','Jaguari', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311122','Jaquirana', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311130','Jari', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311155','Jóia', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311205','Júlio de Castilhos', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311239','Lagoa Bonita do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311254','Lagoão', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311270','Lagoa dos Três Cantos', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311304','Lagoa Vermelha', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311403','Lajeado', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311429','Lajeado do Bugre', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311502','Lavras do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311601','Liberato Salzano', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311627','Lindolfo Collor', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311643','Linha Nova', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311700','Machadinho', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311718','Maçambará', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311734','Mampituba', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311759','Manoel Viana', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311775','Maquiné', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311791','Maratá', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311809','Marau', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311908','Marcelino Ramos', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4311981','Mariana Pimentel', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312005','Mariano Moro', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312054','Marques de Souza', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312104','Mata', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312138','Mato Castelhano', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312153','Mato Leitão', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312179','Mato Queimado', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312203','Maximiliano de Almeida', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312252','Minas do Leão', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312302','Miraguaí', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312351','Montauri', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312377','Monte Alegre dos Campos', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312385','Monte Belo do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312401','Montenegro', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312427','Mormaço', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312443','Morrinhos do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312450','Morro Redondo', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312476','Morro Reuter', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312500','Mostardas', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312609','Muçum', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312617','Muitos Capões', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312625','Muliterno', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312658','Não-Me-Toque', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312674','Nicolau Vergueiro', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312708','Nonoai', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312757','Nova Alvorada', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312807','Nova Araçá', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312906','Nova Bassano', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4312955','Nova Boa Vista', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313003','Nova Bréscia', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313011','Nova Candelária', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313037','Nova Esperança do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313060','Nova Hartz', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313086','Nova Pádua', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313102','Nova Palma', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313201','Nova Petrópolis', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313300','Nova Prata', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313334','Nova Ramada', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313359','Nova Roma do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313375','Nova Santa Rita', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313391','Novo Cabrais', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313409','Novo Hamburgo', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313425','Novo Machado', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313441','Novo Tiradentes', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313466','Novo Xingu', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313490','Novo Barreiro', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313508','Osório', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313607','Paim Filho', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313656','Palmares do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313706','Palmeira das Missões', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313805','Palmitinho', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313904','Panambi', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4313953','Pantano Grande', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314001','Paraí', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314027','Paraíso do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314035','Pareci Novo', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314050','Parobé', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314068','Passa Sete', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314076','Passo do Sobrado', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314100','Passo Fundo', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314134','Paulo Bento', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314159','Paverama', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314175','Pedras Altas', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314209','Pedro Osório', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314308','Pejuçara', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314407','Pelotas', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314423','Picada Café', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314456','Pinhal', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314464','Pinhal da Serra', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314472','Pinhal Grande', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314498','Pinheirinho do Vale', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314506','Pinheiro Machado', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314548','Pinto Bandeira', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314555','Pirapó', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314605','Piratini', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314704','Planalto', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314753','Poço das Antas', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314779','Pontão', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314787','Ponte Preta', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314803','Portão', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4314902','Porto Alegre', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4315008','Porto Lucena', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4315057','Porto Mauá', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4315073','Porto Vera Cruz', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4315107','Porto Xavier', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4315131','Pouso Novo', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4315149','Presidente Lucena', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4315156','Progresso', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4315172','Protásio Alves', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4315206','Putinga', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4315305','Quaraí', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4315313','Quatro Irmãos', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4315321','Quevedos', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4315354','Quinze de Novembro', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4315404','Redentora', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4315453','Relvado', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4315503','Restinga Seca', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4315552','Rio dos Índios', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4315602','Rio Grande', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4315701','Rio Pardo', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4315750','Riozinho', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4315800','Roca Sales', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4315909','Rodeio Bonito', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4315958','Rolador', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4316006','Rolante', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4316105','Ronda Alta', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4316204','Rondinha', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4316303','Roque Gonzales', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4316402','Rosário do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4316428','Sagrada Família', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4316436','Saldanha Marinho', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4316451','Salto do Jacuí', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4316477','Salvador das Missões', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4316501','Salvador do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4316600','Sananduva', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4316709','Santa Bárbara do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4316733','Santa Cecília do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4316758','Santa Clara do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4316808','Santa Cruz do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4316907','Santa Maria', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4316956','Santa Maria do Herval', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4316972','Santa Margarida do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4317004','Santana da Boa Vista', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4317103','Sant''Ana do Livramento', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4317202','Santa Rosa', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4317251','Santa Tereza', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4317301','Santa Vitória do Palmar', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4317400','Santiago', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4317509','Santo Ângelo', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4317558','Santo Antônio do Palma', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4317608','Santo Antônio da Patrulha', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4317707','Santo Antônio das Missões', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4317756','Santo Antônio do Planalto', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4317806','Santo Augusto', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4317905','Santo Cristo', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4317954','Santo Expedito do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4318002','São Borja', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4318051','São Domingos do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4318101','São Francisco de Assis', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4318200','São Francisco de Paula', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4318309','São Gabriel', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4318408','São Jerônimo', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4318424','São João da Urtiga', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4318432','São João do Polêsine', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4318440','São Jorge', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4318457','São José das Missões', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4318465','São José do Herval', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4318481','São José do Hortêncio', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4318499','São José do Inhacorá', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4318507','São José do Norte', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4318606','São José do Ouro', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4318614','São José do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4318622','São José dos Ausentes', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4318705','São Leopoldo', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4318804','São Lourenço do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4318903','São Luiz Gonzaga', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4319000','São Marcos', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4319109','São Martinho', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4319125','São Martinho da Serra', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4319158','São Miguel das Missões', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4319208','São Nicolau', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4319307','São Paulo das Missões', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4319356','São Pedro da Serra', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4319364','São Pedro das Missões', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4319372','São Pedro do Butiá', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4319406','São Pedro do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4319505','São Sebastião do Caí', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4319604','São Sepé', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4319703','São Valentim', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4319711','São Valentim do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4319737','São Valério do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4319752','São Vendelino', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4319802','São Vicente do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4319901','Sapiranga', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4320008','Sapucaia do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4320107','Sarandi', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4320206','Seberi', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4320230','Sede Nova', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4320263','Segredo', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4320305','Selbach', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4320321','Senador Salgado Filho', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4320354','Sentinela do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4320404','Serafina Corrêa', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4320453','Sério', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4320503','Sertão', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4320552','Sertão Santana', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4320578','Sete de Setembro', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4320602','Severiano de Almeida', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4320651','Silveira Martins', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4320677','Sinimbu', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4320701','Sobradinho', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4320800','Soledade', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4320859','Tabaí', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4320909','Tapejara', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4321006','Tapera', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4321105','Tapes', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4321204','Taquara', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4321303','Taquari', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4321329','Taquaruçu do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4321352','Tavares', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4321402','Tenente Portela', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4321436','Terra de Areia', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4321451','Teutônia', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4321469','Tio Hugo', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4321477','Tiradentes do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4321493','Toropi', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4321501','Torres', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4321600','Tramandaí', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4321626','Travesseiro', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4321634','Três Arroios', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4321667','Três Cachoeiras', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4321709','Três Coroas', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4321808','Três de Maio', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4321832','Três Forquilhas', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4321857','Três Palmeiras', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4321907','Três Passos', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4321956','Trindade do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4322004','Triunfo', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4322103','Tucunduva', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4322152','Tunas', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4322186','Tupanci do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4322202','Tupanciretã', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4322251','Tupandi', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4322301','Tuparendi', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4322327','Turuçu', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4322343','Ubiretama', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4322350','União da Serra', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4322376','Unistalda', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4322400','Uruguaiana', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4322509','Vacaria', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4322525','Vale Verde', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4322533','Vale do Sol', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4322541','Vale Real', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4322558','Vanini', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4322608','Venâncio Aires', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4322707','Vera Cruz', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4322806','Veranópolis', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4322855','Vespasiano Correa', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4322905','Viadutos', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4323002','Viamão', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4323101','Vicente Dutra', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4323200','Victor Graeff', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4323309','Vila Flores', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4323358','Vila Lângaro', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4323408','Vila Maria', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4323457','Vila Nova do Sul', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4323507','Vista Alegre', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4323606','Vista Alegre do Prata', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4323705','Vista Gaúcha', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4323754','Vitória das Missões', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4323770','Westfalia', 'RS');
Insert into municipio (Codigo, Nome, estado_Uf) values ('4323804','Xangri-lá', 'RS');
