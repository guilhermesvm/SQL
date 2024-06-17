db.programas.insert({
        "_id": 1,
        "nome": "Jetsons",
    }
);
    
db.programas.insert({
        "_id": 2,
        "nome": "Tio Patinhas",
        "personagens": ["Huguinho", "Zezinho", "Luizinho", "Pato Donald", "Pateta", "5"]
    }
);

db.programas.insert({
        "_id": 3,
        "nome": "Chaves",
        "personagens": ["Chaves", "Kiko", "Seu Madruga", "Chiquinha", "Dona Florinda", "Seu Barriga", "Nhonho", "Girafales", "Jaiminho", "Popis", "Godinez", "Dona Clotilde", "12"]
    }
);

//Operacoes
db.programas.update(
    {"_id": 3},
    {$set: {"canal": "SBT"}}
);
    
db.programas.update(
    {"_id": 1},
    {$set: {"canal": "Rede Globo", "reprise": "Sim"}}
);
    
//Listagem por um ou mais documentos
db.programas.find({"_id": 3});

//Remover um documento
db.programas.remove({"_id": 2});

//Lista a coleção
db.getCollection("programas").find({}).sort({"_id": 1});
db.getCollection("programas").find({}, {"_id": 1}, {"nome": 1}).sort({"_id": 1});


db.programas.find({"canal": "SBT"});

db.programas.find({$or: [{"_id": 1}, {"_id": 3}]}
);

// Localizar collections exibindo apenas uma
db.getCollection("programas").find({}).limit(2);


// Localizar um canal que possua no nome Globo
db.getCollection("programas").find({"canal":/Globo/});

// Localizar um canal que possua no nome globo independente de letra maiuscula ou minuscula
db.getCollection("programas").find({"canal":/globo/i});