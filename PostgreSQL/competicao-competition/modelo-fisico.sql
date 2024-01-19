-- Projeto Físico: Banco de Dados de uma Competicao

--------------------- DDL ------------------
-- Criação da tabela "Modalidade"
CREATE TABLE Modalidade(
	codigo 	  INTEGER PRIMARY KEY, 
	descricao VARCHAR(30)
);

-- Criação da tabela "Equipe"
CREATE TABLE Equipe(
	codigo 		  INTEGER PRIMARY KEY,
	nome 		  VARCHAR(40) NOT NULL,
	dataFundacao  DATE check (dataFundacao <= current_date),
	codModalidade INTEGER,
	FOREIGN KEY (codModalidade) REFERENCES Modalidade(codigo)
);

-- Criação da tabela "Competicao"
CREATE TABLE Competicao(
	codigo 		   INTEGER,
	nome 		   VARCHAR(40) NOT NULL,
	premiacaoTotal NUMERIC(12,2) check (premiacaoTotal >=0)
);

-- Alterar o "codigo" da tabela "Competicao" para ser chave primaria
ALTER TABLE Competicao add constraint pk_cod PRIMARY KEY(codigo);

-- Adição de mais uma coluna na tabela
ALTER TABLE Competicao ADD COLUMN modelo VARCHAR(40); 

CREATE TABLE EquipeComp(
	id INTEGER PRIMARY KEY,
	ano INTEGER default 2023,
	classificacaoFinal INTEGER,
	codEquipe INTEGER,
	FOREIGN KEY (codEquipe) REFERENCES Equipe(codigo),
	codComp INTEGER
);

-- Alterar "codComp" da tabela "EquipeComp" para ser chave secundaria
ALTER TABLE EquipeComp add constraint fk_cod FOREIGN KEY(codComp) REFERENCES Competicao(codigo);

--------------------- DML ------------------
SELECT * FROM Modalidade
INSERT INTO Modalidade(codigo,descricao)VALUES(1,'Futebol');
INSERT INTO Modalidade(codigo,descricao)VALUES(2,'Basquete');
INSERT INTO Modalidade(codigo,descricao)VALUES(3,'Voleibol');
INSERT INTO Modalidade(codigo)VALUES(4);  -- DELETAR modalidade de codigo  4
DELETE FROM Modalidade WHERE codigo = 4;
  
INSERT INTO Modalidade(codigo,descricao)VALUES(4,'Sinuca');
INSERT INTO Modalidade VALUES(5,'Bocha');

SELECT * FROM Equipe
INSERT INTO Equipe(codigo,nome,dataFundacao,codModalidade) VALUES(100,'Grêmio','15/09/1903', 1);
INSERT INTO Equipe(codigo,nome,dataFundacao,codModalidade) VALUES(101,'Inter','03/04/1909', 1);
INSERT INTO Equipe(codigo,nome,codModalidade) VALUES(102,'23z', 5);
INSERT INTO Equipe(codigo,nome,codModalidade) VALUES(103,'Sada', 3);  
INSERT INTO Equipe(codigo,nome,dataFundacao,codModalidade) VALUES(104,'B&8-UPF','10/10/2016', 3);
INSERT INTO Equipe(codigo,nome,dataFundacao,codModalidade) VALUES(105,'Fluminense',current_date, 1);
  

SELECT * FROM Competicao
INSERT INTO Competicao(codigo,nome,premiacaoTotal,modelo) VALUES(100,'Copa do Brasil',80000,'Mata-mata');
INSERT INTO Competicao(codigo,nome,premiacaoTotal,modelo) VALUES(101,'Liga Nacional',50000,'pontos');
INSERT INTO Competicao(codigo,nome,modelo) VALUES(102,'Campeonato Brasileiro','pontos');	

SELECT * FROM EquipeComp
INSERT INTO EquipeComp(id,ano,classificacaofinal,codEquipe,codComp)VALUES (1,2021,2,102,100);
INSERT INTO EquipeComp(id,ano,classificacaofinal,codEquipe,codComp)VALUES (2,2021,1,101,100);			 
INSERT INTO EquipeComp VALUES (3,2022,10,103,102);			 
INSERT INTO EquipeComp VALUES (4,2019,4,100,100);	


-- Comando para excluir a equipe 'Sada' (primeiro excluir da tabela EquipeComp)
SELECT * FROM Equipe
SELECT * FROM EquipeComp

DELETE FROM EquipeComp WHERE id = 3;
DELETE FROM Equipe WHERE nome = 'Sada';

-- Altera a classificação da Equipe 102 na Competição 100 no ano de 2021 para 3º lugar
SELECT * FROM EQUIPECOMP

UPDATE EquipeComp
SET classificacaoFinal = 3
WHERE codEquipe = 102 and codComp = 100

------------------------EXERCICIOS--------------------------
-- 1) Inserir a data de Fundacao da Equipe '23z' para 01/01/2000
UPDATE Equipe
SET dataFundacao = '01/01/2000'
WHERE nome = '23z'

-- 2) Deletar todas as competições da década de 2000
DELETE FROM EquipeComp
WHERE ano >= 200 and ano < 2010

-- 3) Aumentar em 10% a premiação da Competição Copa do Brasil
SELECT * FROM Competicao
UPDATE Competicao
set premiacaoTotal = premiacaoTotal * 1.1
WHERE nome = 'Copa do Brasil'

-- 4) Adicione a coluna "Categoria" na tabela Modalidade. Por padrão essa coluna deve assumir o dado: "Livre".
SELECT * FROM Modalidade
ALTER TABLE Modalidade ADD COLUMN categoria VARCHAR(20) DEFAULT 'Livre'

-- 5) Listar o nome e  premição de todas Competições
SELECT nome, premiacaoTotal
FROM Competicao

-- 6) Listar o codigo da Equipe, o Ano e a respectiva classificação dos anos de 2019 e 2021
SELECT codEquipe, ano, classificacaofinal
FROM EquipeComp
WHERE ano BETWEEN 2019 and 2021

-- 7) Listar o nome das modalidade cuja categoria seja Livre ou livre. Liste ordenado em ordem alfábetica decrescente
SELECT descricao
FROM Modalidade
WHERE upper(categoria) = 'LIVRE'
ORDER BY descricao DESC

-- 8) Listar o nome e modelo das competições que não possuem premiação
SELECT nome, modelo
FROM Competicao
WHERE premiacaoTotal is null

		
-- 9) Listar o nome e data de Fundação das equipes fundadas no mês de outubro independente do ano
SELECT nome, dataFundacao
FROM Equipe
WHERE EXTRACT(month from dataFundacao) = 10
	
-- 10) Listar o código da equipe, competição e a classificação final. Liste apenas com classificação entre 1 e 5, em ordem crescente de classificação.
SELECT codEquipe, codComp, classificacaoFinal
FROM EquipeComp
WHERE classificacaoFinal BETWEEN 1 and 5
ORDER BY classificacaoFinal

-- 11) Listar o código, nome e modelo de todas competições que possuem no nome o termo "Bra".
SELECT * FROM Competicao
SELECT codigo, nome, modelo
FROM Competicao
WHERE nome like '%Bra%'

-- 12) Listar a equipe mais antiga
SELECT nome
FROM Equipe
WHERE dataFundacao = (SELECT MIN(dataFundacao) FROM Equipe) 

