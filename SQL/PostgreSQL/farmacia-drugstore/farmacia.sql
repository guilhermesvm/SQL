SELECT * FROM Farmacia
CREATE TABLE Farmacia(
	CNPJ_farmacia	NUMERIC(14) PRIMARY KEY,
	nome_farmacia	VARCHAR(30),
	tel_farmacia	NUMERIC(13),
	end_farmacia	VARCHAR(50)
);

SELECT * FROM Produto
CREATE TABLE Produto(
	codigo 			INTEGER PRIMARY KEY,
	valor_produto	DECIMAL(3, 2),
	qtd_produto		INTEGER,
	CNPJ_farmacia 	NUMERIC(14),
	FOREIGN KEY (CNPJ_farmacia) REFERENCES Farmacia(CNPJ_farmacia)
);

SELECT * FROM Farmaceutico
CREATE TABLE Farmaceutico(
	RG_farmaceutico		NUMERIC(7) PRIMARY KEY,
	nome_farmaceutico	VARCHAR(30),
	CNPJ_farmacia		NUMERIC(14),
	FOREIGN KEY (CNPJ_farmacia) REFERENCES Farmacia(CNPJ_farmacia)
);


-- 1- Faça o comando SQL para listar o nome, telefone e o nome dos farmacêuticos de cada Farmácia.
	SELECT f.nome_farmacia, f.tel_farmacia, fc.nome_farmaceutico
	FROM farmacia f INNER JOIN farmaceutico fc ON
 	f.cnpj_farmacia = fc.cnpj_farmacia

-- 2- Faça o comando SQL para atualizar o valor dos produtos que custam mais de R$200,00. Diminua o valor em 20%.
	UPDATE Produto
	SET valor_produto = valor_produto - (valor_produto*20/100)
	WHERE valor_produto > 200;

-- 3- Faça o comando SQL para listar o número de farmacêutico de cada farmácia.
	SELECT f.nome_farmacia, COUNT(fc.rg_farmaceutico)
	FROM farmacia f LEFT JOIN farmaceutico fc ON
 	f.cnpj_farmacia = fc.cnpj_farmacia

-- 4- Faça o comando SQL para listar a soma da qtd de produtos de cada Farmácia. Liste asfarmácias ordenada pelo número decrescente de produtos.
	SELECT f.nome_farmacia, SUM(p.qtd_produto)
	FROM farmacia f INNER JOIN produto p ON
 		f.cnpj_farmacia = p.cnpj_farmacia

