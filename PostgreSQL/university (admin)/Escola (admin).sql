-- drop table professor cascade constraint;
CREATE TABLE Professor(
codigo int PRIMARY KEY,
nome varchar(50),
titulacao varchar(80)
);

-- drop table disciplina cascade constraint;
CREATE TABLE Disciplina (
id int PRIMARY KEY,
nome varchar(50),
nhoras numeric(6,2)
);

-- drop table turma cascade constraint;
CREATE TABLE Turma (
codigo int PRIMARY KEY,
nivel varchar(3),
id int,
FOREIGN KEY(id) REFERENCES Disciplina (id)
);

-- drop table aluno cascade constraint;
CREATE TABLE Aluno (
matricula int PRIMARY KEY,
nome varchar(50),
sexo varchar(1),
codigo int,
FOREIGN KEY(codigo) REFERENCES Turma (codigo)
);

-- drop table ministra cascade constraint;
CREATE TABLE ministra (
numero int,
codigo int,
id int,
semestre varchar(8),
PRIMARY KEY(numero)
);

 ALTER TABLE ministra add constraint fk_Prof FOREIGN KEY(codigo)REFERENCES
                                                         Professor(codigo);
 ALTER TABLE ministra add constraint fk_Discip FOREIGN KEY(id) REFERENCES 
                                                          Disciplina (id);


----------- DADOS ---------------------

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




-------------------------------------------------------------- ADMIN --------------------------------------------------------------
SELECT * FROM pg_user;
   	  
CREATE USER Huguinho;       
 ALTER USER Huguinho password '123@456';

CREATE USER Zezinho password '123@456' valid UNTIL '13/05/2024 20:30:00';
	ALTER USER Zezinho password '123@456' valid UNTIL '13/05/2024 20:30:00';



-- Lista o nome do Schema, nome da tabela, proprietário, tablespac
   SELECT 	  *
   FROM    	  pg_catalog.pg_tables
   WHERE   	  schemaname ='public'
   order by   schemaname,tablename


 ---------------------------  Permissões  ---------------------------
 	-- Perms Zezinho
	GRANT SELECT ON professor TO Zezinho;
	GRANT UPDATE on professor TO Zezinho;
	REVOKE UPDATE ON professor FROM Zezinho;
	
	-- Perms Huguinho
	GRANT SELECT ON aluno TO Huguinho;
	
	-- Others
	GRANT insert, update, delete ON Tab1,Tab2 TO Zezinho;
	REVOKE delete ON Tab1 FROM Zezinho;
	
	
----- 1- Como DBA, crie os grupos/roles -papeis (Diretor e Socio). Depois crie os usuarios: Diretor (Luizinho); Socio (Huguinho e Zezinho)
	CREATE ROLE Diretor;
	CREATE ROLE Socio;
	
	CREATE USER Luizinho PASSWORD '123@456' IN ROLE Diretor; --Cria o usuário e já coloca no grupo/papel
	ALTER ROLE Socio USER Huguinho 
	ALTER ROLE Socio USER Zezinho
	
	-- DROP ROLE Socio, Diretor; - Re
	

---- 2- Crie uma política de segurança, concedendo autoridade aos seguintes os papéis:
-- a) Conceder permissão para o papel Diretor acessar todas as tabelas e este conceder as mesmas permissões para outros usuários
	GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO Diretor WITH GRANT OPTION;
	
-- b) Conceder permissão para o papel Socio consultar, inserir e atualizar dados das tabelas aluno, professor, ministra e disciplina
	GRANT SELECT, INSERT, UPDATE ON aluno, professor, ministra, disciplina TO Socio;
	
-- c) Conceder permissão para o papel Diretor consultar apenas os nomes das Disciplinas
	GRANT SELECT(nome) on disciplina TO Diretor;
	
-- d) Conceder permissões e depois retira uma delas do usuário Luizinho (a seu critério)
	GRANT SELECT, UPDATE ON disciplina TO Luizinho;
	REVOKE UPDATE ON disciplina from Luizinho;


	
	GRANT SELECT(nome), UPDATE ON aluno, professor TO Socio;


	DROP ROLE Socio,Diretor;


-- indica que aquele que recebe o priv. de objeto pode conceder o priv. recebido
GRANT select, insert, update ON Tab1,Tab2 TO Socio WITH GRANT OPTION;

-- concede todos privilégios em todas as tabelas do esquema público para Huguinho
  GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO Huguinho;

-- retira todos privilegios em todas as tabelas do esquema publico para Huguinho
  REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM Huguinho;
	  
-- retira o usuario Huguinho da Role/Grupo Socio
	  ALTER GROUP Socio DROP USER Huguinho;
	  
-- adiciona o usuario Huguinho na Role/Grupo Socio
	  ALTER GROUP Socio ADD USER Huguinho;
	  
--Comando para listar os grupos/roles e seus respectivos usuarios
	   SELECT  groname,usename 
	   FROM    pg_group,pg_user 
	   WHERE   usesysid = any(grolist);