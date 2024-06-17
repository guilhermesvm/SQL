 SELECT pg_size_pretty(pg_database_size(current_database())) -- tamanho do banco de dados

 CREATE TABLE dados(
   id_numerico  INT,
   id_literal   VARCHAR(32),
   texto1 VARCHAR(32),
   texto2 VARCHAR(32),texto3 VARCHAR(32),texto4 VARCHAR(32),
   texto5 VARCHAR(32),texto6 VARCHAR(32),texto7 VARCHAR(32),
   texto8 VARCHAR(32),texto9 VARCHAR(32),texto10 VARCHAR(32)  
 );
  
 CREATE or replace FUNCTION f_povoaTabela()
 RETURNS VOID AS 
 $$
 DECLARE
 	i INT;
	texto VARCHAR(40);
 BEGIN
 	i := 1;
	texto := 'Banco de Dados Computacao/UPF';
	LOOP
		INSERT INTO dados(id_numerico, id_literal, texto1, texto2, texto3, texto4, texto5, texto6, texto7, texto8, texto9,
		texto10) VALUES(i, MD5(i::text), texto, texto, texto, texto, texto, texto, texto, texto, texto, texto);
		EXIT WHEN i >= 10000000;
		i := i+1;
	END LOOP;
 END;
 $$
 language plpgsql;
 
 -- p executar a funcao: SELECT f_povoaTabela();
 
 
  SELECT * FROM DADOS WHERE id_numerico = 500;
  SELECT COUNT(*) FROM Dados;
  
  1- SELECT id_literal FROM dados WHERE id_numerico = 500;
  		CREATE INDEX idx_um ON dados(id_numerico); --DROP INDEX idx_um;
  		EXPLAIN ANALYSE SELECT * FROM DADOS WHERE id_literal = MD5 ('500');
  
  2- SELECT * FROM dados WHERE id_numerico BETWEEN 400 AND 900; 
  		CREATE INDEX id_dois ON dados (texto1); --DROP INDEX idx_dois;
		CREATE INDEX idx_tres ON dados USING Hash(id_numerico);
		
 ---------------- Base de Dados: Estoque ----------------
	 SELECT COUNT(*) FROM estoque -- 1.221.151 registros
	 SELECT COUNT(*) FROM nota -- 429.628 registros

 -- Consulta 1 (399ms)
	 SELECT dt_movimento , vl_unitario
	 FROM estoque
	 WHERE id_empresa = 1000;
 
 --  Consulta 2 (175ms)
	 SELECT nota.*, estoque.*
	 FROM nota 
	 INNER JOIN estoque ON nota.id_empresa = estoque.id_empresa 
	 AND nota.id_planilha = estoque.id_planilha
	 WHERE estoque.dt_movimento = '12/03/2007' 
	 AND nota.id_empresa = 1 AND estoque.id_item = 2821

 
 --  Consulta 3 (202ms)
	 SELECT *
	 FROM estoque
	 WHERE dt_movimento >= '01/01/2007' AND id_cfop = 5102
	 AND id_item = 2821 AND vl_unitario > 38

	 CREATE INDEX idx_123 ON estoque(dt_movimento, id_cfop, id_item); -- DROP INDEX idx_123

	 SELECT distinct dt_movimento FROM estoque --1619
	 SELECT distinct id_cfop FROM estoque --23
	 SELECT distinct id_item FROM estoque --26412
	 
	 CREATE INDEX idx_312 ON estoque (id_item, dt_movimento, id_cfop); -- DROP INDEX idx_312