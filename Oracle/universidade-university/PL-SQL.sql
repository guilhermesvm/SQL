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
    
    
--------------------------------------------------------------- PL/SQL ---------------------------------------------------------------
 -- Bloco Anonimo
  DECLARE
    a NUMBER;
    b VARCHAR2(20);
    c VARCHAR2(30);
  BEGIN
    SELECT codigo, nome, titulacao INTO a, b, c
    FROM Professor WHERE codigo = 53;
    
    INSERT INTO Colaborador VALUES(a+10, b||'da UPF' , c|| ' + Dr.');
  END;
  
-------------- PROCEDURE --------------
  CREATE or replace PROCEDURE p_msg (varName VARCHAR) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Seja bem vindo: ' || varName);
  END p_msg;
  
  -- Habilitar o DSBM
  SET SERVEROUTPUT ON;
  
  -- Execucaoo
  EXEC p_msg('Ana');
  
-------------- PROCEDURE 2: Faca um procedimento que recebe o codigo de um % de aumento de um salario. O procedimento deve executar esse aumento --------------
  ALTER TABLE Colaborador ADD salario NUMBER(10,2) DEFAULT 1000;
  
  CREATE or replace PROCEDURE p_mudaSal (varCod NUMBER, varPer NUMBER) IS
  BEGIN
    UPDATE Colaborador
    SET salario = salario + (salario * varPer/100)
    WHERE codigo = varCod;
  END p_mudaSal;
  
    EXEC p_mudaSal(52, 10);
    
-------------- FUNCTIONS --------------
  CREATE or replace FUNCTION f_achaSal(varCod NUMBER)
  RETURN VARCHAR IS varSal VARCHAR(22); c VARCHAR2(30); -- declaro var
  BEGIN
    SELECT nome, salario INTO varSal, c
    FROM Colaborador 
    WHERE codigo = varCod;
  RETURN varSal || c;
  END f_achaSal;

-- Chamar funcao
  SELECT f_achaSal(52) FROM DUAL;
  
  -------------- EXERCICIOS --------------
  -- 1. Faca uma funcao que recebe o nº de matricula e retorna o nome do aluno
  CREATE or replace FUNCTION f_achaNome(varMat NUMBER)
  RETURN VARCHAR IS varNome VARCHAR(30);
  BEGIN
    SELECT nome INTO varNome
    FROM aluno 
    WHERE matricula = varMat;
    RETURN varNome;
  END f_achaNome;
  
  SELECT f_achaNome(13) FROM DUAL;
  
  -- 2. Faca uma funcao que recebe o nº de matricula e retorna o nome do aluno e o codigo de sua turma
  CREATE or replace FUNCTION f_achaNomeTurma(varMat NUMBER)
  RETURN VARCHAR IS varAluno VARCHAR(30); varTurma NUMBER(22);
  BEGIN
    SELECT aluno.nome, turma.codigo INTO varAluno,varTurma
    FROM aluno
    INNER JOIN turma ON aluno.codigo = turma.codigo
    WHERE aluno.matricula = varMat;
    RETURN varAluno || ' '|| varTurma;
  END f_achaNomeTurma;
    
    SELECT f_achaNomeTurma(13) FROM DUAL;
  
  -- 3. Faca uma funcao que passado o semestre(exemplo: 2024/01), retorna o numero de alunos (quantos) matriculados
  CREATE or replace FUNCTION f_achaQtdMatriculado(varSem VARCHAR)
  RETURN NUMBER IS varQtd NUMBER(30,0);
  BEGIN
    SELECT COUNT(aluno.nome) INTO varQtd
    FROM aluno
    INNER JOIN turma ON turma.codigo = aluno.codigo
    INNER JOIN disciplina ON turma.id = disciplina.id
    INNER JOIN ministra ON ministra.id =  disciplina.id
    WHERE ministra.semestre = varSem
    GROUP BY ministra.semestre;
    RETURN varQtd;
  END f_achaQtdMatriculado;
  
  SELECT f_achaQtdMatriculado('2022/1') FROM DUAL;
  
  -- 4. Faca um prodecimento que recebe o id da disciplina e o novo valor da carga horaria (nHoras).
  -- Baseado nesse novo valor, atualize o numero de horas da disciplina 
    CREATE or replace PROCEDURE p_mudaCargaH (varID NUMBER, varHora NUMBER) IS
    BEGIN
      UPDATE disciplina
      SET nHoras = varHora
      WHERE id = varID;
    END p_mudaCargaH;
  
    EXEC p_mudaCargaH(1, 10);
    
 -- 5. Faca um procedimento que apresente uma mensagem com a carga horaria/CH (soma das horas das disciplinas de um professor de um determinado semestre.
 -- Se nao houver CH, emita uma mensagem informando.
 INSERT INTO ministra(numero, codigo, id, semestre) VALUES(1007, 52, 4, '2023/1');

  SET SERVEROUTPUT ON;
  
  CREATE or replace PROCEDURE p_MsgCargaH(varProf NUMBER, varSem VARCHAR2) IS
  varHora NUMBER; 
  BEGIN
    varHora:= 0;
    SELECT SUM(disciplina.nhoras) INTO varHora
    FROM disciplina
      INNER JOIN ministra ON ministra.id = disciplina.id
      INNER JOIN professor ON professor.codigo = ministra.codigo
    WHERE professor.codigo = varProf AND ministra.semestre = varSem;

  IF (varHora <> 0) THEN
    DBMS_OUTPUT.PUT_LINE('A soma das cargas horarias do professor eh ' || varHora || '.');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('Nao ha cargas horarias disponiveis para esse semestre.');
  END IF;
  END p_MsgCargaH;
  
  EXEC p_MsgCargaH(52, '2023/1');
  
--6. Faca um procedimento para inserir os dados de uma nova disciplina no BD (passe todos os campos como parametro).
--Lembre de verificar se o codigo(id - PK) da disciplina que esta tentando inserir ja nao existe na tabela(faca verificacao em uma funcao externa).
--Se ja existir, nao faca a insercao e emita uma mensagem para o usuario

  CREATE OR REPLACE FUNCTION f_comparaIds(varCod NUMBER) 
    RETURN NUMBER IS
    varSaida NUMBER;
    BEGIN
      SELECT COUNT(id)
      INTO varSaida
      FROM disciplina
      WHERE id = varCod;
    RETURN varSaida;
    END f_comparaIds;
    
    SELECT f_comparaIds(4) FROM DUAL;

  CREATE OR REPLACE PROCEDURE p_insereDados(vId NUMBER, vNome VARCHAR, vNhoras NUMBER) IS 
  varRes NUMBER;
    BEGIN
    varRes:= f_comparaIds(vId); --chama funcao p verificar se os id's sao iguais
    IF (varRes <> 0) then
      DBMS_OUTPUT.PUT_LINE('O ID ja existe!');
    ELSE
      insert into disciplina (id,nome,nhoras) values(vId, vNome, vNhoras);
    END IF;
    END p_insereDados;
    
    EXEC p_insereDados(6, 'POO', 50);
    select * from disciplina;
    
--7. Faca um procedure em pl/sql para lista e apresentar quantos anos bissextos existem entre um intervalo de 2 anos (ano1 e ano 2); 
-- Teste se ano1 Ã© menor que ano2, para fazer a verificacao um ano Ã© bissexto quando for possivel dividilo por 4 com resto 0

  CREATE OR REPLACE PROCEDURE p_Q7(ano1 INTEGER, ano2 INTEGER)IS
    varCont INTEGER;
    BEGIN
    varCont := 0;
      IF(ano1 <= ano2) THEN
        FOR ano IN ano1..ano2 LOOP
          IF (MOD(ano,4)=0) THEN
            DBMS_OUTPUT.PUT_LINE('Ano Bissexto=> '|| ano);
            varCont := varCont +1;
          END IF;
        END LOOP;
          DBMS_OUTPUT.PUT_LINE('Qtd de Anos Bissextos => '|| varCont);
      ELSE
        DBMS_OUTPUT.PUT_LINE('PROBLEMA NA INFORMACAO DOS ANOS ANO1 > ANO2');
      END IF;
    END p_Q7;
    
    
    EXEC p_Q7(2000, 2024);
    
  
----------------------------- CURSORES ----------------------------------

------- CURSOR IMPLICITO --------
  CREATE OR REPLACE PROCEDURE p_cImp(varC NUMBER)IS
  varRes professor.nome%TYPE; --atribui a varRes o mesmo tipo de dado da coluna nome da tabela professor
  BEGIN
    SELECT nome
    INTO varRes
    FROM professor
    WHERE codigo = varC;
    IF(SQL%FOUND)THEN
      DBMS_OUTPUT.PUT_LINE('Encontrou quantos registros? '|| to_char(SQL%ROWCOUNT));
    ELSE
      DBMS_OUTPUT.PUT_LINE('Nao encontrou o seguinte registro: ' || varRes);
    END IF;
  END p_cImp;
  
  EXEC p_cImp(55);

------- CURSOR EXPLICITO --------
  CREATE OR REPLACE PROCEDURE p_testaCursorEx01 IS
    Cursor c1 IS 
    SELECT disciplina.id, disciplina.nome, disciplina.nhoras
    FROM disciplina 
    INNER JOIN ministra ON disciplina.id = ministra.id
    WHERE ministra.semestre = '2023/1';
    reg_disc c1%rowtype;
  BEGIN
    OPEN c1;
    FETCH c1 INTO reg_disc;
      DBMS_OUTPUT.PUT_LINE('Dados: '|| reg_disc.nome || ' - '||reg_disc.nHoras);
    FETCH c1 INTO reg_disc;
      DBMS_OUTPUT.PUT_LINE('Encontrou quantos registros: '|| to_char(c1%ROWCOUNT));
      CLOSE c1;
  END p_testaCursorEx01;
  
  EXEC p_testaCursorEx01;
  
 ----COM LOOP---- 
 
   CREATE OR REPLACE PROCEDURE p_testaCursorEx02 IS
    Cursor c1 IS
    SELECT disciplina.id, disciplina.nome, disciplina.nhoras
    FROM disciplina 
    INNER JOIN ministra ON disciplina.id = ministra.id
    WHERE ministra.semestre = '2023/1';
    reg_disc c1%rowtype;
  BEGIN
    OPEN c1;
    LOOP
      FETCH c1 INTO reg_disc;
      EXIT WHEN c1%NOTFOUND;
        IF(reg_disc.nHoras>42) THEN
          DBMS_OUTPUT.PUT_LINE('Dados: '|| reg_disc.nome || ' - '||reg_disc.nHoras);
        END IF;
    END LOOP;
      DBMS_OUTPUT.PUT_LINE('Encontrou quantos registros: '|| to_char(c1%ROWCOUNT));
      CLOSE c1;
  END p_testaCursorEx02;
  
  EXEC p_testaCursorEx02;
  
------------ TRATAMENTO DE EXCECOES ----------

  SELECT * FROM Colaborador;
  
  CREATE or REPLACE PROCEDURE p_exc01(varID NUMBER) IS
  --varSal NUMBER;
  varNome CHAR(3);
  BEGIN
    --SELECT salario 
    --INTO varSal 
    --FROM Colaborador 
    --WHERE codigo = vardID;
      --DBMS_OUTPUT.PUT_LINE('Salario e: ' || varSal);
      SELECT nome INTO varNome FROM Colaborador WHERE codigo = varID;
      DBMS_OUTPUT.PUT_LINE('Nome e: ' || varNome);
      -- iniciando o tratamento de erros
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          raise_application_error(-20001, 'Nada encontrado!');
        WHEN VALUE_ERROR THEN
          raise_application_error(-20002, 'Algo de errado com os dados!');
  END p_exc01;
  --SET SERVEROUTPUT ON;
  
  EXEC p_exc01(52);
  EXEC p_exc01(522);
  
  ----- Modelo de tratamento aprimorado OTHERS
  
  CREATE or REPLACE PROCEDURE p_exc02(varID NUMBER) IS
    varNome CHAR(3);
  BEGIN
      SELECT nome INTO varNome FROM Colaborador WHERE codigo = varID;
      DBMS_OUTPUT.PUT_LINE('Nome e: ' || varNome);
      -- iniciando o tratamento de erros
      EXCEPTION
        WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE(SQLCODE);
          DBMS_OUTPUT.PUT_LINE(SQLERRM);
          RAISE;
  END p_exc02;
  
  EXEC p_exc02(51); -- error VALUE_ERROR
  EXEC p_exc02(511); -- error NO_DATA_FOUND
  
  
  -- Modelo de EXECAO PROGRAMADA
  
  CREATE or REPLACE PROCEDURE p_exc03(varID NUMBER) IS
    varSal NUMBER;
    erro1 EXCEPTION;
    BEGIN
      IF (varID > 1) THEN
        SELECT salario INTO varSal FROM Colaborador WHERE codigo = varID;
        DBMS_OUTPUT.PUT_LINE('Salario e: '|| varSal);
      ELSE
        raise erro1;
      END IF;
      -- secao de tratamento de excecao
      EXCEPTION 
        WHEN erro1 THEN
          raise_application_error(-20888, 'Codigo deve ser > 1!');
    END p_exc03;
    
    EXEC p_exc03(2);
    
  -- Modelo de EXECAO PROGRAMADA -> NAO ORGANIZDA
  
   CREATE or REPLACE PROCEDURE p_exc04(varID NUMBER) IS
    varSal NUMBER;
    BEGIN
      IF (varID > 1) THEN
        SELECT salario INTO varSal FROM Colaborador WHERE codigo = varID;
        DBMS_OUTPUT.PUT_LINE('Salario e: '|| varSal);
      ELSE
          raise_application_error(-20888, 'Codigo deve ser > 1!');
      END IF;
      INSERT INTO Colaborador VALUES(58, 'Ana', 'Mestre', 5000);
      -- secao de tratamento de excecao ???
      EXCEPTION 
        WHEN erro1 THEN
          raise_application_error(-20888, 'Codigo deve ser > 1!');
    END p_exc04;
    
  ------- TRIGGER -------
  CREATE TABLE Colaborador_log(
    id NUMBER PRIMARY KEY,
    codigo NUMBER NOT NULL,
    salario_old NUMBER(10,2),
    salario_new NUMBER(10,2),
    dataAlteracao TIMESTAMP,
    usuario VARCHAR2(20)
  );
  
  CREATE SEQUENCE logColab
    START WITH 1
    INCREMENT BY 1;
  
  -- Faca um trigger que apos a atualizacao de salario de um colaboradaor seja disparado, e registre os dados desta infracao em uma tabela de log
  
  CREATE or REPLACE TRIGGER tg_auditaColab
    AFTER UPDATE ON Colaborador
    FOR EACH ROW
    WHEN (NEW.salario > OLD.salario)
    BEGIN
      INSERT INTO Colaborador_log(id, codigo, salario_old, salario_new, dataAlteracao, usuario)
      VALUES(logColab.nextval, :OLD.codigo, :OLD.salario, :NEW.salario, sysdate, user);
    END tg_auditaColab;
    
    SELECT * FROM Colaborador;
    SELECT * FROM Colaborador_log;
    
    UPDATE Colaborador SET salario = 1050 WHERE codigo = 53; -- fez a insercao
    UPDATE Colaborador SET salario = 1050 WHERE codigo = 53; -- nao fez a insercao pois nao aumentou o salario
    UPDATE Colaborador SET salario = 1100 WHERE codigo = 53; -- fez a insercao
    
    CREATE or REPLACE TRIGGER tg_auditaColab
    AFTER UPDATE ON Colaborador
    FOR EACH ROW
    WHEN (NEW.salario <> OLD.salario)
    BEGIN
      INSERT INTO Colaborador_log(id, codigo, salario_old, salario_new, dataAlteracao, usuario)
      VALUES(logColab.nextval, :OLD.codigo, :OLD.salario, :NEW.salario, sysdate, user);
    END tg_auditaColab;
    
    -- mudando o trigger para inserir qualquer alteracao
    UPDATE Colaborador SET salario = 1010 WHERE codigo = 53; -- fez a insercao
    
    -- comando para desabilitar um trigger:
    ALTER TRIGGER tg_auditaColab DISABLE;
    -- para habilitar
    ALTER TRIGGER tg_auditaColab ENABLE;