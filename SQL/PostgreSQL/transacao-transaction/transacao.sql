 CREATE TABLE Banco(
	conta INTEGER PRIMARY KEY,
	agencia VARCHAR(10),
	saldo NUMERIC(10,2)
 );

 INSERT INTO Banco VALUES(2311, '6559-98', 900);
 INSERT INTO Banco VALUES(2229, '5479-98', 1100);
 INSERT INTO Banco VALUES(1211, '1004-11', 750);
 
 SELECT * FROM Banco
 
 -- Transacao 1
 BEGIN;
  UPDATE Banco SET saldo = 999 WHERE conta = 2311;
  COMMIT;
  ROLLBACK; -- Rollback não funciona pois foi executado depois do COMMIT
  
 -- Transacao 2 
 BEGIN;
  UPDATE banco SET saldo = 1001 WHERE conta = 2311;
  DELETE FROM Banco WHERE conta = 2311;
 ROLLBACK;
 
 -- Transacao 3
 BEGIN;
  UPDATE banco SET saldo = 1001 WHERE conta = 2311;
  SAVEPOINT s1;
  INSERT INTO Banco VALUES(1250, '15699-x', 50);
  ROLLBACK to SAVEPOINT s1;
  
   SELECT * FROM Banco