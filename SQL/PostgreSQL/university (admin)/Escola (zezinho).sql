-- AMBIENTE DO ZEZINHO

SELECT * FROM Aluno -- Sem permissao

SELECT * FROM professor -- Com permissao
UPDATE professor SET nome = 'Wilma da UPF' WHERE nome = 'Wilma da UPF'; -- error