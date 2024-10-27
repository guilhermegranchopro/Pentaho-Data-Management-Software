-- Criação do esquema do Data Warehouse para consumo de energia

DROP DATABASE IF EXISTS Project_Task_4;
CREATE DATABASE Project_Task_4;
USE Project_Task_4;

-- Dimensão Tempo
CREATE TABLE Dim_Tempo (
    id_tempo INT AUTO_INCREMENT PRIMARY KEY,
    ano INT NOT NULL,
    estacao ENUM('Primavera', 'Verão', 'Outono', 'Inverno') NOT NULL,
    mes VARCHAR(15) NOT NULL
);

-- Dimensão Localização
CREATE TABLE Dim_Localizacao (
    id_localizacao INT AUTO_INCREMENT PRIMARY KEY,
    regiao VARCHAR(50) NOT NULL,
    municipio VARCHAR(50) NOT NULL,
    freguesia VARCHAR(50) NOT NULL
);

-- Tabela de Fatos para Consumo de Energia e Medidores Inteligentes
CREATE TABLE Fato_Consumo_Energia (
    id_fato INT AUTO_INCREMENT PRIMARY KEY,
    id_tempo INT,
    id_localizacao INT,
    consumo_energia_kwh DECIMAL(18, 4) NOT NULL,
    num_contratos_smart INT NOT NULL, -- Número de contratos com smart meters
    num_contratos_nao_smart INT NOT NULL, -- Número de contratos sem smart meters
    FOREIGN KEY (id_tempo) REFERENCES Dim_Tempo(id_tempo),
    FOREIGN KEY (id_localizacao) REFERENCES Dim_Localizacao(id_localizacao)
);


-- Índices opcionais para melhorar o desempenho das consultas
CREATE INDEX idx_tempo ON Fato_Consumo_Energia (id_tempo);
CREATE INDEX idx_localizacao ON Fato_Consumo_Energia (id_localizacao);

