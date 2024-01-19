CREATE TABLE Estabelecimento (
    codigo SERIAL PRIMARY KEY,
    nome VARCHAR(200) NOT NULL,
    rua VARCHAR(200) NOT NULL,
n   umero INTEGER NOT NULL
);

CREATE TABLE Barbeiro (
    codigo SERIAL PRIMARY KEY,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    nome VARCHAR(200) NOT NULL,
    codEstab INTEGER REFERENCES Estabelecimento(codigo) ON DELETE CASCADE
);

CREATE TABLE Cliente (
    codigo SERIAL PRIMARY KEY,
    telefone VARCHAR(12) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    nome VARCHAR(200) NOT NULL
);

CREATE TABLE Servicos (
    codigo SERIAL PRIMARY KEY,
    tipo VARCHAR(120) NOT NULL,
    horario VARCHAR(6) NOT NULL,
    dia DATE NOT NULL,
    preco NUMERIC NOT NULL,
    tempo VARCHAR(10) NOT NULL,
    codBarb INTEGER REFERENCES Barbeiro(codigo) ON DELETE CASCADE,
    codCliente INTEGER REFERENCES Cliente(codigo) ON DELETE CASCADE
);



INSERT INTO Cliente(telefone, cpf, nome) VALUES('(99)93425233','32145434788', 'Roberto Freitas');
INSERT INTO Cliente(telefone, cpf, nome) VALUES('(97)96931233','76254347588', 'Jeferson Almeida');
INSERT INTO Cliente(telefone, cpf, nome) VALUES('(67)99765233','04114343478', 'José Augusto');
INSERT INTO Cliente(telefone, cpf, nome) VALUES('(89)93476233','65476434788', 'Paulo Souza');
INSERT INTO Cliente(telefone, cpf, nome) VALUES('(79)98672523','21455347938', 'Marcio Andrade');
INSERT INTO Estabelecimento(nome, rua, numero) VALUES('Social Barber','Rua Independencia', 463);
INSERT INTO Estabelecimento(nome, rua, numero) VALUES('Marechal', 'Rua Teodoro Fonseca', 127);
INSERT INTO Estabelecimento(nome, rua, numero) VALUES('Macho Alfa','Av. Rebouças', 342);
INSERT INTO Estabelecimento(nome, rua, numero) VALUES('Hair Club', 'Rua Faria Lima', 256);
INSERT INTO Estabelecimento(nome, rua, numero) VALUES('The Boys Barber', 'Av. José Freitas', 987);
INSERT INTO Barbeiro(cpf, nome, codEstab) VALUES('06123578600','Jeferson Souza', 1);
INSERT INTO Barbeiro(cpf, nome, codEstab) VALUES('96761654780','Ernesto Reimann', 3);
INSERT INTO Barbeiro(cpf, nome, codEstab) VALUES('02782677600','Carlos Alberto Freitas', 2);
INSERT INTO Barbeiro(cpf, nome, codEstab) VALUES('06675487860', 'Taylor José', 4);
INSERT INTO Barbeiro(cpf, nome, codEstab) VALUES('16378424636', 'Paulo Augusto Meira', 5);
INSERT INTO Servicos(tipo, horario, dia, preco, tempo, codBarb, codCliente) VALUES('Cabelo', '14:30', '12/09/2023', 30.00, '35 min', 2, 2);
INSERT INTO Servicos(tipo, horario, dia, preco, tempo, codBarb, codCliente) VALUES('Cabelo e barba', '17:00', '10/09/2023', 50.00, '1 hora', 1, 3);
INSERT INTO Servicos(tipo, horario, dia, preco, tempo, codBarb, codCliente) VALUES('Cabelo', '19:30', '11/09/2023', 30.00, '35 min', 4, 4);
INSERT INTO Servicos(tipo, horario, dia, preco, tempo, codBarb, codCliente) VALUES('Cabelo e barba', '10:15', '12/09/2023', 50.00, '1 hora', 3, 5);
INSERT INTO Servicos(tipo, horario, dia, preco, tempo, codBarb, codCliente) VALUES('Cabelo e barba', '20:30', '22/09/2023', 50.00, '1 hora', 5, 1);


--------------------EXERCICIOS--------------------
--1 Um comando de atualização de dados (Where com operador lógico);
UPDATE Servicos
SET horario = '18:00'
WHERE codigo = 4 AND codcliente = 5

-- Alterando o horário do serviço do cliente para as 18:00.

-- 2- Uma Consulta que envolva três tabelas, com uso de Inner Join;
SELECT cliente.nome, servicos.horario, barbeiro.nome, servicos.codbarb
FROM cliente INNER JOIN servicos ON
servicos.codcliente = cliente.codigo
INNER JOIN barbeiro ON
barbeiro.codigo = servicos.codbarb

--Consultando por qual barbeiro cada cliente será atendido.

-- 3- Uma consulta que envolva duas tabelas, com uso Left, Right ou Full Join;
SELECT barbeiro.nome, estabelecimento.nome
FROM barbeiro RIGHT JOIN estabelecimento ON
estabelecimento.codigo = barbeiro.codestab

--Consultando o barbeiro de cada barbearia.

-- 4- Uma consulta que envolva pelo menos duas tabelas com uso de função de agregação com Group by e Having;
SELECT tipo, COUNT(tipo) FROM servicos
GROUP BY tipo
HAVING tipo = 'Cabelo e barba'

--Consultando quantos serviços de corte de cabelo e barba serão realizados.