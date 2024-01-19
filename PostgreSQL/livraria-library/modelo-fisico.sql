-- Projeto Físico: Banco de Dados de uma Livraria


CREATE TABLE Pais(
	sigla VARCHAR(3) PRIMARY KEY,
	nome VARCHAR(30) NOT NULL
);

CREATE TABLE Tema(
	codigo INTEGER PRIMARY KEY,
	descricao VARCHAR(30) NOT NULL
);	

CREATE TABLE Livro(
	codigo INTEGER PRIMARY KEY,
	titulo VARCHAR(40) NOT NULL,
	situacaoLeitura VARCHAR(4) DEFAULT 'Não' CHECK(situacaoLeitura = 'Sim' or situacaoLeitura = 'Não'),
	codTema INTEGER,
	FOREIGN KEY	(codTema) REFERENCES Tema(codigo)
);

CREATE TABLE Filme(
	codigo INTEGER PRIMARY KEY,
	titulo VARCHAR(30) NOT NULL,
	anoEstreia INTEGER,
	codLivro INTEGER,
	FOREIGN KEY (codLivro) REFERENCES Livro(codigo)
);

-- Ao utilizar serial, há um auto incremento do codigo
CREATE TABLE Autor(
	codigo SERIAL PRIMARY KEY,
	nome VARCHAR(30) NOT NULL,
	dataNascimento DATE check (dataNascimento <= current_date) NOT NULL,
	dataMorte DATE check (dataMorte <= current_date),
	siglaPais VARCHAR(3),
	FOREIGN KEY (siglaPais) REFERENCES Pais(sigla)
);

CREATE TABLE AutorLivro(
	codAutor INTEGER,
	codLivro INTEGER,
	FOREIGN KEY(codAutor) REFERENCES Autor(codigo),
	FOREIGN KEY (codLivro) REFERENCES Livro(codigo),
	PRIMARY KEY(codAutor, codLivro)
);

------ Inserir 4 linhas (valores) em cada tabela
SELECT * FROM Pais
INSERT INTO Pais(sigla,nome) VALUES('BRA','Brasil');
INSERT INTO Pais(sigla,nome) VALUES('JAP','Japão');
INSERT INTO Pais(sigla,nome) VALUES('EUA','Estados Unidos da America');
INSERT INTO Pais(sigla,nome) VALUES('GUA','Guatemala');
INSERT INTO Pais(sigla,nome) VALUES('ITA','Itália');
INSERT INTO Pais VALUES ('COL', 'Colombia');
INSERT INTO Pais VALUES ('CHI', 'Chile');

SELECT * FROM Tema
INSERT INTO Tema(codigo, descricao) VALUES(1, 'Romance');
INSERT INTO Tema(codigo, descricao) VALUES(2, 'Poesia');
INSERT INTO Tema(codigo, descricao) VALUES(3, 'Regionalismo');

SELECT * FROM Livro
INSERT INTO Livro(codigo, titulo, situacaoLeitura, codtema) VALUES(1, 'Memórias Postumas de Bras','Sim', 1);
INSERT INTO Livro(codigo, titulo, situacaoLeitura, codtema) VALUES(2, 'O Almada', 'Não', 2);
INSERT INTO Livro(codigo, titulo, situacaoLeitura, codtema) VALUES(3, 'O Cortiço', 'Sim', 1);
INSERT INTO Livro(codigo, titulo, situacaoLeitura, codtema) VALUES(4, 'Os Sertões', 'Não', 3);
INSERT INTO Livro(codigo, titulo, situacaoLeitura, codtema) VALUES(5, 'Triste Fim de Policarpo', 'Não', 1);
INSERT INTO Livro(codigo, titulo, situacaoLeitura, codtema) VALUES(6, 'A filha perdida', 'Não', 1);
INSERT INTO Livro(codigo, titulo, situacaoLeitura, codtema) VALUES(7, 'A cachorra', 'Não', 1);
INSERT INTO Livro(codigo, titulo, situacaoLeitura, codtema) VALUES(8, 'A cachorra que assoviava', 'Não', 1);
INSERT INTO Livro(codigo, titulo, situacaoLeitura, codtema) VALUES(9, 'O Carteiro e o Poeta', 'Sim', 1);

SELECT * FROM Livro
INSERT INTO Filme(codigo, titulo, anoEstreia, codLivro) VALUES(1, 'Memórias Póstumas', 2001, 1);
INSERT INTO Filme(codigo, titulo, anoEstreia, codLivro) VALUES(2, 'O Cortiço', 1977, 3);
INSERT INTO Filme(codigo, titulo, anoEstreia, codLivro) VALUES(3, 'A Filha perdida', 2021, 6);
INSERT INTO Filme(codigo, titulo, anoEstreia, codLivro) VALUES(4, 'O Carteiro e o Poeta', 1994, 8);

SELECT * FROM Autor
INSERT INTO Autor(nome, dataNascimento, dataMorte, siglaPais) VALUES('Aluísio Azevedo', '14/04/1857', '21/01/1913', 'BRA');
INSERT INTO Autor(nome, dataNascimento, dataMorte, siglaPais) VALUES('Machado de Assis', '21/06/1839', '29/09/1908', 'BRA');
INSERT INTO Autor(nome, dataNascimento, dataMorte, siglaPais) VALUES('Euclides da Cunha', '20/01/1866', '15/08/1909', 'BRA');
INSERT INTO Autor(nome, dataNascimento, dataMorte, siglaPais) VALUES('Lima Barreto', '20/01/1866', '15/08/1909', 'BRA');
INSERT INTO Autor(nome, dataNascimento, dataMorte, siglaPais) VALUES('Elena Ferrante', '5/4/1943', NULL, 'ITA');
INSERT INTO Autor(nome, dataNascimento, siglaPais) VALUES('Pilar Quintana','07/12/1972','COL');
INSERT INTO Autor(nome, dataNascimento, dataMorte, siglaPais) VALUES('Pablo Neruda', '12/07/1904', '23/09/1973', 'COL');
INSERT INTO Autor(nome, dataNascimento, dataMorte, siglaPais) VALUES('Guilherme Machado', '03/05/2002', NULL, 'BRA');

INSERT INTO AutorLivro(codAutor, codLivro) VALUES(1, 1);
INSERT INTO AutorLivro(codAutor, codLivro) VALUES(1, 2);
INSERT INTO AutorLivro(codAutor, codLivro) VALUES(2, 3);
INSERT INTO AutorLivro(codAutor, codLivro) VALUES(3, 4);
INSERT INTO AutorLivro(codAutor, codLivro) VALUES(4, 5);
INSERT INTO AutorLivro(codAutor, codLivro) VALUES(5, 6);
INSERT INTO AutorLivro(codAutor, codLivro) VALUES(6, 7);
INSERT INTO AutorLivro(codAutor, codLivro) VALUES(7, 8);

----------------------EXERCICIOS-----------------
--1- Listar o nome de todos os autores em ordem 
SELECT nome
FROM Autor
ORDER BY nome

--2- Listar o título dos livros que posuem situação de leitura SIM e tema com código entre 50 e 100
SELECT titulo, situacaoLeitura, codTema
FROM Livro
WHERE UPPER(situacaoLeitura) = 'SIM' and codTema BETWEEN 1 AND 5
	
--3- Listar o títulos dos filmes e ano de estréia. Listar ordenado pelo lançamento mais recente.
SELECT titulo, anoEstreia
FROM Filme
ORDER BY anoEstreia DESC

--4- Listar o nome e Datas de Nasc. dos autores com nascimento em na década de 90
SELECT nome, dataNascimento
FROM Autor
WHERE EXTRACT(YEAR from DataNascimento) >= 1990 and EXTRACT(YEAR FROM dataNascimento) <= 1999
	
--5- Listar o nome e o dia de nascimentos de todos autores
SELECT nome, EXTRACT(day FROM dataNascimento)
FROM Autor

--6- Listar o nome dos autores que já faleceram
SELECT nome 
FROM Autor
WHERE DataMorte is not null

--7- Listar o nome dos autores que nasceram no Brasil e nos Estados Unidos
SELECT nome
FROM autor
WHERE siglaPais = 'BRA' OR siglapais = 'EUA'

--8- Listar o títulos dos livros que possuem o termo cachorra
SELECT * FROM Livro
SELECT titulo
FROM livro
WHERE titulo LIKE '%cachorra%'

--9- Listar NOME e a DATA DE NASCIMENTO dos AUTORES que estão vivos. Liste em ordem
SELECT nome, dataNascimento
FROM Autor
WHERE dataMorte is null
ORDER BY nome

------------------------JOINS-------------------------
--10- Listar os livros cadastrados do tema Romance
SELECT * FROM Livro
SELECT * FROM Tema

SELECT Livro.titulo, Tema.descricao
FROM Livro 
INNER JOIN Tema ON Livro.codTema = Tema.codigo
WHERE Tema.descricao = 'Romance'
	
--11- Listar o nome do autor MAIS VELHO cadastrado na base de dados
SELECT nome, age(dataNascimento) as idade
FROM Autor
WHERE dataMorte is null
ORDER BY dataNascimento
LIMIT 1
		
--12- Listar o nome dos livros que tem filme
SELECT Livro.titulo, Filme.titulo
FROM Livro
INNER JOIN Filme ON Livro.codigo = Filme.codLivro

--13- Listar o nome do Livro em maiúsculoa e o nome do Filme em minúsculo
SELECT UPPER(Livro.titulo) as Livro, LOWER(Filme.titulo) as Filme
FROM Livro
INNER JOIN Filme ON Livro.codigo = Filme.codLivro

--14- Faça o comando SQL para listar o nome dos livros que já foram lidos.
SELECT titulo
FROM Livro
WHERE UPPER(situacaoLeitura) = 'SIM'
	
-- 15- Faça o comando SQL para listar os autores estrangeiros e seus respectivos livros. Liste em ordem decrescente de País
SELECT Autor.nome as nomeAutor, Autor.siglaPais as paisAutor, Livro.titulo as tituloLivro
FROM Autor
JOIN Pais ON Pais.sigla = Autor.siglaPais
JOIN AutorLivro ON AutorLivro.codAutor = Autor.codigo
JOIN Livro ON AutorLivro.codLivro = Livro.codigo
WHERE Pais.sigla <> 'BRA'
ORDER BY Pais.nome DESC

-- 16- Listar livros que tenham em seu título a palavra “Cachorra” e seu respectivo tema
SELECT * FROM Livro
SELECT Livro.titulo, Tema.descricao
FROM Livro
INNER JOIN Tema ON Livro.codTema = Tema.codigo
WHERE Livro.titulo LIKE '%cachorra%'

-- 17- Listar todos os autores (nome, data de nascimento) que nasceram no mês de janeiro (independente do ano) e que já faleceram
SELECT * FROM Autor
SELECT nome, dataNascimento
FROM Autor
WHERE EXTRACT(month from dataNascimento) = 1 and dataMorte is not null

-- 18- Listar os livros, o nome dos autores e seus respectivos livros. Liste todos os autores, independente se possuem livros publicados.
SELECT * FROM AutorLivro
SELECT Livro.titulo, Autor.nome
FROM Livro
INNER JOIN AutorLivro ON AutorLivro.codLivro = Livro.codigo
RIGHT JOIN Autor ON Autor.codigo = AutorLivro. codAutor

-- 19- Listar os países que não possuem autores cadastrados
SELECT Pais.nome, Pais.sigla
FROM Pais
LEFT JOIN Autor ON Autor.siglaPais = Pais.sigla
WHERE Autor.siglaPais is null

	
-- 20- Listar o número de autores de cada país
SELECT * FROM Autor
SELECT siglaPais, COUNT(siglaPais)
FROM Autor
GROUP BY siglaPais

-- 21- Listar o número de livros que cada autor publicou. Liste todos os autores.
SELECT Autor.nome, COUNT(AutorLivro.codLivro)
FROM Autor
LEFT JOIN AutorLivro ON AutorLivro.codAutor = Autor.codigo
LEFT JOIN Livro ON AutorLivro.codLivro = Livro.codigo
GROUP BY Autor.nome

-- 22- Listar o número de estreia de filmes por ano.
SELECT * FROM Filme
SELECT anoEstreia, COUNT(titulo) as numeroEstreia
FROM Filme
GROUP BY anoEstreia

-- 23- Listar o tema e o número de livros publicados. Liste apenas os temas com mais de dois livros.
SELECT * FROM Livro
SELECT * FROM Tema 

SELECT Tema.descricao, COUNT(Livro.codTema)
FROM Tema
INNER JOIN LIVRO ON Livro.codTema = Tema.codigo
GROUP BY Tema.descricao
HAVING COUNT(Livro.codTema) >= 2

-- 24- Listar o nome dos autores que publicaram mais de um livro
SELECT Autor.nome
FROM Autor
INNER JOIN AutorLivro ON AutorLivro.codAutor = Autor.codigo
GROUP BY Autor.nome
HAVING COUNT(AutorLivro.codAutor) > 1