db.createCollection("Avaliacao");

for(i=1; i <= 1000; i++){
    atividades = ["Trab1", "Trab2", "Prova"];

    for(j=0; j < 3; j++){
        db.Avaliacao.insert({"Aluno": i,
                            "Tipo": atividades[j],
                             Avaliacao:Math.round(Math.random() * 10)});
    }
}



db.Avaliacao.find({"Aluno": 500});

db.Avaliacao.insert({"Aluno": "Felipe",
                     "Tipo": "Prova",
                      Avaliacao: 5.5});                 

db.Avaliacao.find({"Aluno": "Felipe"});

db.Avaliacao.find().limit(5).toArray();

var cursor = db.Avaliacao.find({"Tipo": "Prova"});

// percorrer cursor 
while(cursor.hasNext()){
    printjson(cursor.next());
}


db.Avaliacao.find().count();
db.Avaliacao.find({"Aluno": "Mari"}).count();
db.Avaliacao.find({"Aluno": "Felipe"}).count();
db.Avaliacao.find({Avaliacao: 10}).count();

// a)
db.Avaliacao.find({Avaliacao:{$gte:9.0, $lte: 10}, "Tipo": "Prova"}).count();

// b) Faca um comando para contar o numero de notas da Prova, com nota inferior a 7.0
db.Avaliacao.find({Avaliacao:{$lt:7.0}, "Tipo": "Prova"}).count();

// c) Fa�a um comando para contar o numero de notas de Trab1, entre 0 e 3 (inclui 0 e 3)
db.Avaliacao.find({Avaliacao:{$gte:0.0, $lte: 3.0}, "Tipo": "Trab1"}).count();


// d) Facaa o comando para contar o numero de notas de Prova iguais a 10
db.Avaliacao.find({Avaliacao:{$gte: 9.9, $lte: 10}, "Tipo": "Prova"}).count();

// e) Faca o comando para listar o nome/numero de todos os alunos em ordem decrescente. Listar apenas os alunos com nota maior que 9.0
db.Avaliacao.find({}).sort({"Aluno": -1 });









