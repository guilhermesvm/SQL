-- drop table professor cascade constraint;
CREATE TABLE Professor(
codigo int PRIMARY KEY,
nome varchar2(50),
titulacao varchar2(80)
);

-- drop table disciplina cascade constraint;
CREATE TABLE Disciplina (
id int PRIMARY KEY,
nome varchar2(50),
nhoras number(6,2)
);

-- drop table turma cascade constraint;
CREATE TABLE Turma (
codigo int PRIMARY KEY,
nivel varchar2(3),
id int,
FOREIGN KEY(id) REFERENCES Disciplina (id)
);

-- drop table aluno cascade constraint;
CREATE TABLE Aluno (
matricula int PRIMARY KEY,
nome varchar2(50),
sexo varchar2(1),
codigo int,
FOREIGN KEY(codigo) REFERENCES Turma (codigo)
);

-- drop table ministra cascade constraint;
CREATE TABLE Ministra (
numero int PRIMARY KEY,
codigo int,
id int,
semestre varchar2(8)
);

--------------------- ADICAO DE CHAVES ESTRANGEIRAS ---------------------
ALTER TABLE Ministra
ADD CONSTRAINT fk_Prof 
FOREIGN KEY (codigo) REFERENCES Professor(codigo);

ALTER TABLE Ministra
ADD CONSTRAINT fk_Disc
FOREIGN KEY (id) REFERENCES Disciplina(id);




--------------------- DADOS ---------------------
insert into professor(codigo, nome, titulacao)values(50,'Doroteia','Especialista');
insert into professor(codigo, nome, titulacao)values(51,'Maysa','Mestre');
insert into professor(codigo, nome, titulacao)values(52,'Procopio','Doutor');
insert into professor(codigo, nome, titulacao)values(53,'Wilma','Mestre');

insert into disciplina(id, nome, nhoras)values(1, 'Laboratorio de Banco de Dados', 80);
insert into disciplina(id, nome, nhoras)values(2, 'Programacao OO', 120);
insert into disciplina(id, nome, nhoras)values(3, 'Banco de Dados I', 80);
insert into disciplina(id, nome, nhoras)values(4, 'Ciencia de dados', 40);

insert into turma(codigo, nivel,id)values(20, 'I',2);
insert into turma(codigo, nivel,id)values(21, 'II',1);
insert into turma(codigo, nivel,id)values(22, 'III',1);
insert into turma(codigo, nivel,id)values(23, 'IV',3);
insert into turma(codigo, nivel,id)values(24, 'I',1);

insert into aluno(matricula, nome, sexo,codigo)values(10, 'Bety', 'F', 20);
insert into aluno(matricula, nome, sexo,codigo)values(11, 'Getulio', 'M',22);
insert into aluno(matricula, nome, sexo,codigo)values(12, 'Ana', 'F',22);
insert into aluno(matricula, nome, sexo,codigo)values(13, 'Terezinha', 'F',21);
insert into aluno(matricula, nome, sexo,codigo)values(14, 'Teodoro', 'M',23);

insert into ministra(numero, codigo, id, semestre)values(1000, 53, 3, '2021/2');
insert into ministra(numero, codigo, id, semestre)values(1001, 51, 1, '2021/2');
insert into ministra(numero, codigo, id, semestre)values(1002, 52, 1, '2022/1');
insert into ministra(numero, codigo, id, semestre)values(1003, 53, 2, '2022/1');
insert into ministra(numero, codigo, id, semestre)values(1004, 51, 3, '2023/1');
insert into ministra(numero, codigo, id, semestre)values(1005, 52, 2, '2023/1');
insert into ministra(numero, codigo, id, semestre)values(1006, 51, 4, '2023/1');



--------------------- EXERCICIOS ---------------------
--1- Quantos alunos estaoo matriculados na turma do nivel "III"?
SELECT turma.nivel, COUNT(aluno.matricula)
FROM aluno
INNER JOIN turma ON turma.codigo = aluno.codigo
WHERE turma.nivel = 'III'
GROUP BY turma.nivel;

--2- Nome e a matricula dos alunos que estaoo fazendo a disciplina de Laboratorio de Banco de Dados. Em ordem alfabetica por nome de aluno
SELECT aluno.nome, aluno.matricula
FROM aluno
INNER JOIN turma ON turma.codigo = aluno.codigo
INNER JOIN disciplina ON disciplina.id = turma.id
WHERE disciplina.nome = 'Laboratorio de Banco de Dados'
ORDER BY aluno.nome ASC;
  
--3- Listar os professores (nome e titulacaoo) da disciplina de Laboratorio de Banco de Dados
SELECT professor.nome, professor.titulacao
FROM professor
INNER JOIN ministra ON professor.codigo = ministra.codigo
INNER JOIN disciplina ON disciplina.id = ministra.id
WHERE disciplina.nome = 'Laboratorio de Banco de Dados';

--4- Listar os professores e suas disciplinas ordenadas por semestre em ordem crescente
SELECT professor.nome, disciplina.nome
FROM professor
INNER JOIN ministra ON professor.codigo = ministra.codigo
INNER JOIN disciplina ON disciplina.id = ministra.id
ORDER BY ministra.semestre ASC

-- 5. Somar o numero de horas, que saoo ministradas pelo professor Procopio, a cada semestre
SELECT professor.nome,SUM(nhoras), ministra.semestre
FROM disciplina
INNER JOIN ministra ON disciplina.id = ministra.id
INNER JOIN professor ON professor.codigo = ministra.codigo
WHERE professor.nome = 'Procopio'
GROUP BY professor.nome, ministra.semestre


-- 6. Listar o nome de alunos matriculados em cada disciplina, do semestre 2023/1
SELECT aluno.nome, ministra.semestre, disciplina.nome
FROM aluno
INNER JOIN turma ON turma.codigo = aluno.codigo
INNER JOIN disciplina ON disciplina.id = turma.id
INNER JOIN ministra ON ministra.id = disciplina.id
WHERE ministra.semestre = '2023/1'


-- 7. Listar o nome dos professores que ministram disciplinas, com o nhoras maior que a carga horaria da disciplina de Ciencia de Dados
SELECT professor.nome, disciplina.nome, disciplina.nhoras
FROM professor
INNER JOIN ministra ON ministra.codigo = professor.codigo
INNER JOIN disciplina ON disciplina.id = ministra.id
WHERE disciplina.nhoras > (SELECT disciplina.nhoras
  FROM disciplina
  WHERE disciplina.nome = 'Ciencia de dados')
  
  -- 8. Faca uma consulta para listar o nome das disciplinas com 2 ou mais alunos matriculados
SELECT disciplina.nome, COUNT(aluno.matricula) as "nº de alunos"
FROM disciplina
INNER JOIN turma ON turma.id = disciplina.id
INNER JOIN aluno ON aluno.codigo = turma.codigo
GROUP BY  disciplina.nome
HAVING COUNT(aluno.matricula) > 2

  -- 9. Faca uma consulta para listar o codigo das turmas que nao possuem alunos matriculados
SELECT turma.codigo
FROM turma
FULL JOIN aluno ON aluno.codigo = turma.codigo
WHERE aluno.codigo is NULL
 
 --10. Faca uma consulta para listar o nomero de alunos matriculados por semestre em ordem decrescente de alunos
SELECT COUNT(aluno.nome), ministra.semestre
FROM aluno
INNER JOIN turma ON turma.codigo = aluno.codigo
INNER JOIN disciplina ON disciplina.id = turma.id
INNER JOIN ministra ON ministra.id = disciplina.id
GROUP BY ministra.semestre 
ORDER BY COUNT(aluno.nome) DESC
 
--------------------- COMANDOS DIVERSOS ---------------------
CREATE TABLE Eventos(
    id INT PRIMARY KEY,
    nome VARCHAR2(30) NOT NULL
);

CREATE SEQUENCE criaIDs       --DROP SEQUENCE nomeDaSequencia
  start with 500
  increment by 1
  maxvalue 503
  nocycle;
  
  SELECT * FROM Eventos
    INSERT INTO Eventos(id, nome) VALUES(criaIDS.nextval, 'Taca Computacao');
    INSERT INTO Eventos(id, nome) VALUES(criaIDS.nextval, 'OBI');
    INSERT INTO Eventos(id, nome) VALUES(criaIDS.nextval, 'GameSHOW');
    INSERT INTO Eventos(id, nome) VALUES(criaIDS.nextval, 'Tiro ao Alvo');
    INSERT INTO Eventos(id, nome) VALUES(criaIDS.nextval, 'CS2'); -- quantidade invalida

 -- Cria uma tabela baseada em outra, Estrutura e Dados
CREATE TABLE Colaborador AS SELECT * FROM Professor WHERE codigo > 50;
    describe Colaborador