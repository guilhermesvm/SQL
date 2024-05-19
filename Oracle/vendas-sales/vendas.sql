--drop table produtos cascade constraints;
CREATE TABLE produtos(
    codigo        NUMBER NOT NULL,
    descricao     VARCHAR2(20),
    estoque       NUMBER(7,2),
    precounitario NUMBER(7,2),
    PRIMARY KEY (codigo)
);
  
INSERT INTO produtos VALUES(1,'Computador',5,3700);
INSERT INTO produtos VALUES(2,'SmartPhone',2,1299);
INSERT INTO produtos VALUES(3,'MacBook',2,12000);
INSERT INTO produtos VALUES(4,'Impressora',10,499.89);

--drop table vendas cascade constraints;
CREATE TABLE vendas(
    numero        NUMBER PRIMARY KEY,
    valorProduto  NUMBER NOT NULL,
    quantidade    NUMBER,
    data          DATE,
    parcelas      NUMBER,
    codigoProduto NUMBER,
    FOREIGN KEY (codigoProduto) REFERENCES produtos(codigo)
  );
  
--  drop table parcelas cascade constraints;
CREATE TABLE parcelas(
    numero       NUMBER,
    valorParcela NUMBER NOT NULL,
    dataVenc     DATE NOT NULL,
    dataPagto    DATE,
    nvenda       NUMBER,
    FOREIGN KEY (nvenda) REFERENCES vendas(numero),
    PRIMARY KEY (numero,nvenda)
);
  
  ---------------------------------------------- TRIGGER ----------------------------------------------
CREATE OR REPLACE TRIGGER tg_Parcelas AFTER
  INSERT ON Vendas 
  FOR EACH ROW 
  DECLARE varQTD INT; erro1 EXCEPTION; varValorParcela NUMBER(10,2); varData DATE;
  BEGIN
    -- Verificando o estoque (FAZER FUNCTION)
    varQTD := f_verificaEstoque(:NEW.codigoProduto);
    IF(varQTD < :NEW.quantidade) THEN
      raise erro1;
    ELSE
      -- entao atualiza o Estoque (fazer PROCEDURE)
      p_atualizaEstoque(:NEW.quantidade, :NEW.codigoProduto);
      
      -- gera parcela 
      varValorParcela := :NEW.valorProduto * :NEW.quantidade / :NEW.parcelas;
      varData := :NEW.data;
      FOR i IN  1..:NEW.parcelas LOOP
        SELECT add_months(varData, 1) INTO varData FROM dual;
        INSERT INTO Parcelas(numero, valorParcela, dataVenc, nVenda) VALUES(i, varValorParcela, varData, :NEW.numero);
      END LOOP;
    END IF;
    -- area de tratamento de excecao
    EXCEPTION
      WHEN erro1 THEN
        raise_application_error(-20001, 'Estoque insuficiente.');
END tg_Parcelas;
  
  
  -- Funcao que verifica o estoque
  CREATE or replace FUNCTION f_verificaEstoque(varCod INT)
  RETURN INT IS
  x INT;
  BEGIN
    SELECT estoque INTO x FROM produtos WHERE codigo = varCod;
    RETURN x;
  END f_verificaEstoque;
  SELECT f_verificaEstoque(3) from DUAL; -- testando function
  
  -- Procedure que atualiza o estoque
  CREATE or replace PROCEDURE p_atualizaEstoque(varQtd INT, varCodProd INT) IS
  BEGIN
   UPDATE Produtos 
   SET estoque = estoque - varQtd
   WHERE codigo = varCodProd;
  END p_atualizaEstoque;
   
INSERT INTO Vendas(numero, valorProduto, quantidade, data, parcelas, codigoProduto) VALUES(100, 12000, 3, '15/04/2024', 10, 3); -- error
INSERT INTO Vendas(numero, valorProduto, quantidade, data, parcelas, codigoProduto) VALUES(150, 12000, 1, '15/04/2024', 10, 3);
