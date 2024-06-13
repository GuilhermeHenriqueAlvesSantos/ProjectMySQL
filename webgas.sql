#Trabalho de BD 

#Guilherme Henrique Alves Santos RA: 24015942
#Thiago Mauri Gonzalez RA:24015357
#Victor Ramalho Borges de Souza RA: 24007532


show databases;
create database BD080324172;
use BD080324172;



-- Tabela Cidade deve ser criada primeiro porque Bairro depende dela
CREATE TABLE Cidade (
    nome_cidade varchar(50) not null primary key,
    estado varchar(2) not null,
    latitude varchar(20),
    longitude varchar(20)
);

-- Tabela Bairro depende de Cidade
create table Bairro(
    nome varchar(30) not null primary key,
    cidade varchar(50) not null,
    CONSTRAINT nome_cidade FOREIGN KEY (cidade) REFERENCES Cidade(nome_cidade)
);

-- Tabela Tipo_Usuario é independente e pode ser criada antes de Usuario
CREATE TABLE Tipo_Usuario (
    nome varchar(50) not null primary key
);

-- Tabela Usuario depende de Tipo_Usuario
CREATE TABLE Usuario (
    login varchar(25) not null primary key,
    senha varchar(20) not null,
    nome_cargo varchar(50),
    CONSTRAINT nome_cargo FOREIGN KEY (nome_cargo) REFERENCES Tipo_Usuario(nome)
);

-- Tabela Veiculo é independente
CREATE TABLE Veiculo (
    placa varchar(10) primary key,
    marca varchar(50) NOT NULL,
    modelo varchar(50) NOT NULL
);

-- Tabela Combustivel é independente
CREATE TABLE Combustivel (
    nome VARCHAR(50) PRIMARY KEY
);

-- Tabela Bandeira é independente
create table Bandeira(
    nome  varchar(30) primary key,
    url varchar(30)
);

-- Tabela Posto depende de Bairro e Bandeira
create table Posto(
    cnpj  varchar(14) primary key,
    razao_social varchar(30),
    nome_fantasia varchar(30),
    latitude varchar(20),
    longitude varchar(20),
    endereco varchar(50),
    telefone varchar(15),
    bairro varchar(25),
    CONSTRAINT bandeira_posto FOREIGN KEY (nome_fantasia) REFERENCES Bandeira(nome),
    CONSTRAINT bairro_nome FOREIGN KEY (bairro) REFERENCES Bairro(nome)
);

-- Tabela Posto_Combustivel depende de Posto e Combustivel
create table Posto_Combustivel(
    id int not null primary key auto_increment,
    cnpj_posto varchar(14) not null,
    nome_combustivel varchar(50),
    CONSTRAINT cnpj_posto FOREIGN KEY (cnpj_posto) REFERENCES Posto(cnpj),
    CONSTRAINT nome_combustivel FOREIGN KEY (nome_combustivel) REFERENCES Combustivel(nome)
);

-- Tabela Precos depende de Posto_Combustivel
CREATE TABLE Precos (
    momento date primary key,
    valor float(11,2),
    id_posto int not null,
    CONSTRAINT posto_preco FOREIGN KEY (id_posto) REFERENCES Posto_Combustivel(id)
);

-- Tabela Pessoa depende de Bairro, Usuario e Veiculo
CREATE TABLE Pessoa (
    login varchar(25) not null primary key,
    nome varchar(50),
    endereco varchar(55),
    bairro varchar(30),
    usuario varchar(25),
    placa_carro varchar(10),
    CONSTRAINT bairro_pessoa FOREIGN KEY (bairro) REFERENCES Bairro(nome),
    CONSTRAINT usuario_pessoa FOREIGN KEY (usuario) REFERENCES Usuario(login),
    CONSTRAINT veiculo_pessoa FOREIGN KEY (placa_carro) REFERENCES Veiculo(placa)
);

-- Tabela comentario depende de Posto e Pessoa
create table comentario(
    id int auto_increment primary key,
    momento date,
    cnpjposto varchar(14),
    loginpessoa varchar(25),
    CONSTRAINT posto_comentario FOREIGN KEY (cnpjposto) REFERENCES Posto(cnpj),
    CONSTRAINT pessoa_comentario FOREIGN KEY (loginpessoa) REFERENCES Pessoa(login)
);

-- Tabela abastecido depende de Combustivel e Veiculo
create table abastecido(
    id int auto_increment primary key,
    nome_combustivel varchar(50),
    placa_veiculo varchar(10),
    CONSTRAINT combustivel_abastecido FOREIGN KEY (nome_combustivel) REFERENCES Combustivel(nome),
    CONSTRAINT veiculo_abastecido FOREIGN KEY (placa_veiculo) REFERENCES Veiculo(placa)
);

#########################################################################################################

use BD080324172;

-- Insere dados na tabela Cidade
INSERT INTO Cidade (nome_cidade, estado, latitude, longitude) VALUES
('São Paulo', 'SP', '-23.550520', '-46.633308'),
('Rio de Janeiro', 'RJ', '-22.906847', '-43.172896'),
('Belo Horizonte', 'MG', '-19.916681', '-43.934493'),
('Curitiba', 'PR', '-25.428356', '-49.273251'),
('Porto Alegre', 'RS', '-30.034647', '-51.217658');

-- Insere dados na tabela Bairro
INSERT INTO Bairro (nome, cidade) VALUES
('Bairro 1', 'São Paulo'),
('Bairro 2', 'Rio de Janeiro'),
('Bairro 3', 'Belo Horizonte'),
('Bairro 4', 'Curitiba'),
('Bairro 5', 'Porto Alegre');

-- Insere dados na tabela Tipo_Usuario
INSERT INTO Tipo_Usuario (nome) VALUES
('Admin'),
('User'),
('Manager'),
('Guest'),
('SuperUser');

-- Insere dados na tabela Usuario
INSERT INTO Usuario (login, senha, nome_cargo) VALUES
('user1', 'senha1', 'Admin'),
('user2', 'senha2', 'User'),
('user3', 'senha3', 'Manager'),
('user4', 'senha4', 'Guest'),
('user5', 'senha5', 'SuperUser');

-- Insere dados na tabela Veiculo
INSERT INTO Veiculo (placa, marca, modelo) VALUES
('AAA1111', 'Toyota', 'Corolla'),
('BBB2222', 'Honda', 'Civic'),
('CCC3333', 'Ford', 'Focus'),
('DDD4444', 'Chevrolet', 'Cruze'),
('EEE5555', 'Volkswagen', 'Golf');

-- Insere dados na tabela Combustivel
INSERT INTO Combustivel (nome) VALUES
('Gasolina'),
('Etanol'),
('Diesel'),
('GNV'),
('Biodiesel');

-- Insere dados na tabela Bandeira
INSERT INTO Bandeira (nome, url) VALUES
('Shell', 'www.shell.com'),
('Petrobras', 'www.petrobras.com'),
('Ipiranga', 'www.ipiranga.com'),
('Texaco', 'www.texaco.com'),
('BR', 'www.br.com');

-- Insere dados na tabela Posto
INSERT INTO Posto (cnpj, razao_social, nome_fantasia, latitude, longitude, endereco, telefone, bairro) VALUES
('00000000000191', 'Posto 1 Ltda', 'Shell', '-23.555771', '-46.639557', 'Rua A, 123', '(11) 1111-1111', 'Bairro 1'),
('00000000000272', 'Posto 2 Ltda', 'Petrobras', '-22.907887', '-43.173054', 'Rua B, 456', '(21) 2222-2222', 'Bairro 2'),
('00000000000353', 'Posto 3 Ltda', 'Ipiranga', '-19.917331', '-43.934579', 'Rua C, 789', '(31) 3333-3333', 'Bairro 3'),
('00000000000434', 'Posto 4 Ltda', 'Texaco', '-25.428597', '-49.273491', 'Rua D, 101', '(41) 4444-4444', 'Bairro 4'),
('00000000000515', 'Posto 5 Ltda', 'BR', '-30.034768', '-51.217769', 'Rua E, 202', '(51) 5555-5555', 'Bairro 5');

-- Insere dados na tabela Posto_Combustivel
INSERT INTO Posto_Combustivel (cnpj_posto, nome_combustivel) VALUES
('00000000000191', 'Gasolina'),
('00000000000272', 'Etanol'),
('00000000000353', 'Diesel'),
('00000000000434', 'GNV'),
('00000000000515', 'Biodiesel');

-- Insere dados na tabela Precos
INSERT INTO Precos (momento, valor, id_posto) VALUES
('2024-01-01', 4.59, 1),
('2024-01-02', 3.89, 2),
('2024-01-03', 3.69, 3),
('2024-01-04', 2.99, 4),
('2024-01-05', 4.19, 5);

-- Insere dados na tabela Pessoa
INSERT INTO Pessoa (login, nome, endereco, bairro, usuario, placa_carro) VALUES
('user1', 'João Silva', 'Av. Principal, 123', 'Bairro 1', 'user1', 'AAA1111'),
('user2', 'Maria Santos', 'Rua Secundária, 456', 'Bairro 2', 'user2', 'BBB2222'),
('user3', 'Pedro Almeida', 'Travessa X, 789', 'Bairro 3', 'user3', 'CCC3333'),
('user4', 'Ana Costa', 'Estrada Y, 101', 'Bairro 4', 'user4', 'DDD4444'),
('user5', 'Lucas Souza', 'Alameda Z, 202', 'Bairro 5', 'user5', 'EEE5555');

-- Insere dados na tabela comentario
INSERT INTO comentario (momento, cnpjposto, loginpessoa) VALUES
('2024-01-01', '00000000000191', 'user1'),
('2024-01-02', '00000000000272', 'user2'),
('2024-01-03', '00000000000353', 'user3'),
('2024-01-04', '00000000000434', 'user4'),
('2024-01-05', '00000000000515', 'user5');

-- Insere dados na tabela abastecido
INSERT INTO abastecido (nome_combustivel, placa_veiculo) VALUES
('Gasolina', 'AAA1111'),
('Etanol', 'BBB2222'),
('Diesel', 'CCC3333'),
('GNV', 'DDD4444'),
('Biodiesel', 'EEE5555');
##################################################################################################
 
 #percebemos que ia ser poucos dados, ent colocamos mais alguns
 
 -- Insere mais dados na tabela Cidade
INSERT INTO Cidade (nome_cidade, estado, latitude, longitude) VALUES
('Fortaleza', 'CE', '-3.71722', '-38.54337'),
('Salvador', 'BA', '-12.9714', '-38.5014'),
('Brasília', 'DF', '-15.8267', '-47.9218'),
('Recife', 'PE', '-8.0476', '-34.8770'),
('Manaus', 'AM', '-3.1190', '-60.0217'),
('Belém', 'PA', '-1.4550', '-48.5048'),
('Goiânia', 'GO', '-16.6869', '-49.2648'),
('Campinas', 'SP', '-22.9099', '-47.0626'),
('São Luís', 'MA', '-2.5307', '-44.3068'),
('Natal', 'RN', '-5.7945', '-35.2110');

-- Insere mais dados na tabela Bairro
INSERT INTO Bairro (nome, cidade) VALUES
('Bairro 6', 'Fortaleza'),
('Bairro 7', 'Salvador'),
('Bairro 8', 'Brasília'),
('Bairro 9', 'Recife'),
('Bairro 10', 'Manaus'),
('Bairro 11', 'Belém'),
('Bairro 12', 'Goiânia'),
('Bairro 13', 'Campinas'),
('Bairro 14', 'São Luís'),
('Bairro 15', 'Natal');

-- Insere mais dados na tabela Tipo_Usuario
INSERT INTO Tipo_Usuario (nome) VALUES
('Basic'),
('Premium'),
('Silver'),
('Gold'),
('Platinum'),
('Bronze'),
('Diamond'),
('VIP'),
('Regular'),
('Trial');

-- Insere mais dados na tabela Usuario
INSERT INTO Usuario (login, senha, nome_cargo) VALUES
('user6', 'senha6', 'Basic'),
('user7', 'senha7', 'Premium'),
('user8', 'senha8', 'Silver'),
('user9', 'senha9', 'Gold'),
('user10', 'senha10', 'Platinum'),
('user11', 'senha11', 'Bronze'),
('user12', 'senha12', 'Diamond'),
('user13', 'senha13', 'VIP'),
('user14', 'senha14', 'Regular'),
('user15', 'senha15', 'Trial');

-- Insere mais dados na tabela Veiculo
INSERT INTO Veiculo (placa, marca, modelo) VALUES
('FFF6666', 'Nissan', 'Sentra'),
('GGG7777', 'Hyundai', 'Elantra'),
('HHH8888', 'Kia', 'Cerato'),
('III9999', 'Mazda', '3'),
('JJJ0000', 'Subaru', 'Impreza'),
('KKK1111', 'Mitsubishi', 'Lancer'),
('LLL2222', 'Suzuki', 'SX4'),
('MMM3333', 'Peugeot', '308'),
('NNN4444', 'Renault', 'Megane'),
('OOO5555', 'Citroen', 'C4');

-- Insere mais dados na tabela Posto
INSERT INTO Posto (cnpj, razao_social, nome_fantasia, latitude, longitude, endereco, telefone, bairro) VALUES
('00000000000696', 'Posto 6 Ltda', 'Shell', '-3.716772', '-38.543478', 'Rua F, 303', '(85) 6666-6666', 'Bairro 6'),
('00000000000777', 'Posto 7 Ltda', 'Petrobras', '-12.971677', '-38.501432', 'Rua G, 404', '(71) 7777-7777', 'Bairro 7'),
('00000000000858', 'Posto 8 Ltda', 'Ipiranga', '-15.826980', '-47.921860', 'Rua H, 505', '(61) 8888-8888', 'Bairro 8'),
('00000000000939', 'Posto 9 Ltda', 'Texaco', '-8.047764', '-34.877030', 'Rua I, 606', '(81) 9999-9999', 'Bairro 9'),
('00000000001010', 'Posto 10 Ltda', 'BR', '-3.119112', '-60.021912', 'Rua J, 707', '(92) 0000-0000', 'Bairro 10'),
('00000000001191', 'Posto 11 Ltda', 'Shell', '-1.455176', '-48.504880', 'Rua K, 808', '(91) 1111-1111', 'Bairro 11'),
('00000000001272', 'Posto 12 Ltda', 'Petrobras', '-16.687068', '-49.264916', 'Rua L, 909', '(62) 2222-2222', 'Bairro 12'),
('00000000001353', 'Posto 13 Ltda', 'Ipiranga', '-22.910055', '-47.062740', 'Rua M, 101', '(19) 3333-3333', 'Bairro 13'),
('00000000001434', 'Posto 14 Ltda', 'Texaco', '-2.530765', '-44.306856', 'Rua N, 202', '(98) 4444-4444', 'Bairro 14'),
('00000000001515', 'Posto 15 Ltda', 'BR', '-5.794612', '-35.211092', 'Rua O, 303', '(84) 5555-5555', 'Bairro 15');

-- Insere mais dados na tabela Posto_Combustivel
INSERT INTO Posto_Combustivel (cnpj_posto, nome_combustivel) VALUES
('00000000000696', 'Gasolina'),
('00000000000777', 'Etanol'),
('00000000000858', 'Diesel'),
('00000000000939', 'GNV'),
('00000000001010', 'Biodiesel'),
('00000000001191', 'Gasolina'),
('00000000001272', 'Etanol'),
('00000000001353', 'Diesel'),
('00000000001434', 'GNV'),
('00000000001515', 'Biodiesel');

-- Insere mais dados na tabela Precos
INSERT INTO Precos (momento, valor, id_posto) VALUES
('2024-01-06', 4.29, 6),
('2024-01-07', 3.79, 7),
('2024-01-08', 3.99, 8),
('2024-01-09', 2.89, 9),
('2024-01-10', 4.09, 10),
('2024-01-11', 4.39, 11),
('2024-01-12', 3.69, 12),
('2024-01-13', 3.89, 13),
('2024-01-14', 2.79, 14),
('2024-01-15', 4.49, 15);

-- Insere mais dados na tabela Pessoa
INSERT INTO Pessoa (login, nome, endereco, bairro, usuario, placa_carro) VALUES
('user6', 'Carlos Nunes', 'Rua P, 404', 'Bairro 6', 'user6', 'FFF6666'),
('user7', 'Renata Souza', 'Rua Q, 505', 'Bairro 7', 'user7', 'GGG7777'),
('user8', 'Cláudia Lopes', 'Rua R, 606', 'Bairro 8', 'user8', 'HHH8888'),
('user9', 'Roberto Lima', 'Rua S, 707', 'Bairro 9', 'user9', 'III9999'),
('user10', 'Fernanda Silva', 'Rua T, 808', 'Bairro 10', 'user10', 'JJJ0000'),
('user11', 'Patrícia Ribeiro', 'Rua U, 909', 'Bairro 11', 'user11', 'KKK1111'),
('user12', 'Alexandre Moura', 'Rua V, 101', 'Bairro 12', 'user12', 'LLL2222'),
('user13', 'Juliana Castro', 'Rua W, 202', 'Bairro 13', 'user13', 'MMM3333'),
('user14', 'Marcelo Gomes', 'Rua X, 303', 'Bairro 14', 'user14', 'NNN4444'),
('user15', 'Sofia Almeida', 'Rua Y, 404', 'Bairro 15', 'user15', 'OOO5555');

-- Insere mais dados na tabela comentario
INSERT INTO comentario (momento, cnpjposto, loginpessoa) VALUES
('2024-01-06', '00000000000696', 'user6'),
('2024-01-07', '00000000000777', 'user7'),
('2024-01-08', '00000000000858', 'user8'),
('2024-01-09', '00000000000939', 'user9'),
('2024-01-10', '00000000001010', 'user10'),
('2024-01-11', '00000000001191', 'user11'),
('2024-01-12', '00000000001272', 'user12'),
('2024-01-13', '00000000001353', 'user13'),
('2024-01-14', '00000000001434', 'user14'),
('2024-01-15', '00000000001515', 'user15');

-- Insere mais dados na tabela abastecido
INSERT INTO abastecido (nome_combustivel, placa_veiculo) VALUES
('Gasolina', 'FFF6666'),
('Etanol', 'GGG7777'),
('Diesel', 'HHH8888'),
('GNV', 'III9999'),
('Biodiesel', 'JJJ0000'),
('Gasolina', 'KKK1111'),
('Etanol', 'LLL2222'),
('Diesel', 'MMM3333'),
('GNV', 'NNN4444'),
('Biodiesel', 'OOO5555');

 

##################################################################################################


# 1 - Classificação de postos de acordo com o melhor custo-benefício dos combustíveis
SELECT 
    p.cnpj,
    p.nome_fantasia,
    p.endereco,
    pr.valor AS preco_combustivel,
    p.bairro
FROM 
    Posto p
JOIN 
    Posto_Combustivel pc ON p.cnpj = pc.cnpj_posto
JOIN 
    Precos pr ON pc.id = pr.id_posto
ORDER BY 
    pr.valor ASC;

#######################################################################

#Pesquisa pegando o nome do posto, qual combustível tem, qual o nome fantasia, o preço do combustível e a localização:

SELECT 
    p.razao_social AS nome_posto,
    pc.nome_combustivel AS combustivel,
    p.nome_fantasia AS nome_fantasia,
    pr.valor AS preco_combustivel,
    p.latitude,
    p.longitude
FROM 
    Posto p
JOIN 
    Posto_Combustivel pc ON p.cnpj = pc.cnpj_posto
JOIN 
    Precos pr ON pc.id = pr.id_posto;

#######################################################################

# 2 - Quais os postos com bandeiras e url que tem na cidade, puxando o bairro também, agrupando por tipo de gasolina:

SELECT 
    p.razao_social AS nome_posto,
    b.nome AS bandeira,
    b.url,
    c.nome_cidade,
    bairro.nome AS bairro,
    pc.nome_combustivel
FROM 
    Posto p
JOIN 
    Bandeira b ON p.nome_fantasia = b.nome
JOIN 
    Bairro bairro ON p.bairro = bairro.nome
JOIN 
    Cidade c ON bairro.cidade = c.nome_cidade
JOIN 
    Posto_Combustivel pc ON p.cnpj = pc.cnpj_posto
GROUP BY 
    pc.nome_combustivel, p.razao_social, b.nome, b.url, c.nome_cidade, bairro.nome;
    
    #######################################################################

# 3 - Do maior pro menor os preços de gasolina:
    
SELECT 
    p.razao_social AS nome_posto,
    pc.nome_combustivel AS combustivel,
    pr.valor AS preco_combustivel
FROM 
    Posto p
JOIN 
    Posto_Combustivel pc ON p.cnpj = pc.cnpj_posto
JOIN 
    Precos pr ON pc.id = pr.id_posto
WHERE 
    pc.nome_combustivel = 'Gasolina'
ORDER BY 
    pr.valor DESC;
    
#######################################################################

# 4 - Listar Pessoa que é qual usuário e qual tipo de usuário:

SELECT 
    pes.nome AS pessoa,
    u.login AS usuario,
    tu.nome AS tipo_usuario
FROM 
    Pessoa pes
JOIN 
    Usuario u ON pes.usuario = u.login
JOIN 
    Tipo_Usuario tu ON u.nome_cargo = tu.nome;
    
#######################################################################

# 5 -  Quantas e quais pessoas que abasteceram em GNV e quem foram elas:

SELECT 
    pes.nome,
    a.nome_combustivel
FROM 
    Pessoa pes
JOIN 
    abastecido a ON pes.placa_carro = a.placa_veiculo
WHERE 
    a.nome_combustivel = 'GNV'
GROUP BY 
    pes.nome, a.nome_combustivel;
    
#######################################################################

# 6 - Listar todos os veículos e os postos onde foram abastecidos, incluindo a data e o tipo de combustível:

SELECT 
    v.placa,
    v.marca,
    v.modelo,
    p.nome_fantasia AS posto,
    a.nome_combustivel,
    pr.momento AS data_abastecimento
FROM 
    Veiculo v
JOIN 
    abastecido a ON v.placa = a.placa_veiculo
JOIN 
    Precos pr ON a.id = pr.id_posto
JOIN 
    Posto_Combustivel pc ON pr.id_posto = pc.id
JOIN 
    Posto p ON pc.cnpj_posto = p.cnpj;
    
    
#######################################################################

# 7 - mostra o tipo de combustivel, o maior preço e o menor preço dele

SELECT 
    pc.nome_combustivel,
    MAX(pr.valor) AS preco_maximo,
    MIN(pr.valor) AS preco_minimo
FROM 
    Posto_Combustivel pc
JOIN 
    Precos pr ON pc.id = pr.id_posto
GROUP BY 
    pc.nome_combustivel;

#######################################################################

# 8 - Mostra o nome do posto, o combustivel com preços acima da média, e a data de abastecimento

SELECT 
    p.razao_social AS nome_posto,
    pc.nome_combustivel AS combustivel,
    pr.valor AS preco_combustivel,
    pr.momento AS data_preco
FROM 
    Posto p
JOIN 
    Posto_Combustivel pc ON p.cnpj = pc.cnpj_posto
JOIN 
    Precos pr ON pc.id = pr.id_posto
JOIN (
    SELECT 
        nome_combustivel,
        AVG(valor) AS media_preco
    FROM 
        Precos pr
    JOIN 
        Posto_Combustivel pc ON pr.id_posto = pc.id
    GROUP BY 
        nome_combustivel
) AS media_precos ON pc.nome_combustivel = media_precos.nome_combustivel
WHERE 
    pr.valor > media_precos.media_preco
ORDER BY 
    pc.nome_combustivel, pr.valor DESC;

#######################################################################

# 9 - Número de Veículos por Marca:

SELECT 
    v.marca,
    COUNT(v.placa) AS num_veiculos
FROM 
    Veiculo v
GROUP BY 
    v.marca
ORDER BY 
    num_veiculos DESC;

#######################################################################

# 10 - faça uma pesquisa com pessoas que tem o nome terminado em A, qual o carro que eles tem, qual foi o posto que abasteceram, o combustível utilizado, o preço e a data:


SELECT 
    pes.nome AS pessoa,
    v.placa AS placa_veiculo,
    v.marca AS marca_veiculo,
    v.modelo AS modelo_veiculo,
    p.nome_fantasia AS posto,
    c.momento AS data_comentario
FROM 
    Pessoa pes
JOIN 
    Veiculo v ON pes.placa_carro = v.placa
JOIN 
    comentario c ON pes.login = c.loginpessoa
JOIN 
    Posto p ON c.cnpjposto = p.cnpj
WHERE 
    pes.nome LIKE '%a';

#######################################################################
