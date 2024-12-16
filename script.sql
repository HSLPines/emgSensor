
-- modelo final base
 
create schema modelo_emg;

use modelo_emg;

CREATE TABLE ENDERECO (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    logradouro VARCHAR(255) NOT NULL,
    numero VARCHAR(10),
    complemento VARCHAR(255),
    cidade VARCHAR(100),
    estado VARCHAR(100),
    cep VARCHAR(15)
);

create table PACIENTE (
	id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    data_nascimento DATE,
    tipo_sanguineo VARCHAR(5),
    historico_medico TEXT,
    id_endereco INT,
    FOREIGN KEY (id_endereco) REFERENCES ENDERECO(id_endereco)
);

create table CLINICA(
	id_clinica INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    tipo_clinica VARCHAR(255),
    id_endereco INT,
    FOREIGN KEY (id_endereco) REFERENCES ENDERECO(id_endereco)
);

CREATE TABLE USUARIO (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    login VARCHAR(255) NOT NULL UNIQUE,
    senha_hash VARCHAR(255)
);

CREATE TABLE PROF_SAUDE (
    id_prof_saude INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    registro_local VARCHAR(100),
    registro_profissional VARCHAR(100)
);

CREATE TABLE CLINICA_PROF_SAUDE (
    id_clinica INT,
    id_prof_saude INT,
    PRIMARY KEY (id_clinica, id_prof_saude),
    FOREIGN KEY (id_clinica) REFERENCES CLINICA(id_clinica),
    FOREIGN KEY (id_prof_saude) REFERENCES PROF_SAUDE(id_prof_saude)
);

CREATE TABLE MOVIMENTO (
    id_movimento INT AUTO_INCREMENT PRIMARY KEY,
    nome_movimento VARCHAR(255),
    descricao TEXT
);

CREATE TABLE PROTOCOLO (
    id_protocolo INT AUTO_INCREMENT PRIMARY KEY,
    nome_protocolo VARCHAR(255),
    objetivo TEXT,
    versao VARCHAR(10)
);

CREATE TABLE GRUPO_MUSCULAR (
    id_grupo_muscular INT AUTO_INCREMENT PRIMARY KEY,
    nome_grupo VARCHAR(255)
);

CREATE TABLE MUSCULO (
    id_musculo INT AUTO_INCREMENT PRIMARY KEY,
    id_grupo_muscular INT,
    nome_musculo VARCHAR(255),
    FOREIGN KEY (id_grupo_muscular) REFERENCES GRUPO_MUSCULAR(id_grupo_muscular)
);

CREATE TABLE ELETRODO (
    id_eletrodo INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(255),
    posicao_anatomica TEXT
);

CREATE TABLE EXAME (
    id_exame INT AUTO_INCREMENT PRIMARY KEY,
    data DATE,
    tipo_exame VARCHAR(255),
    id_paciente INT,
    id_clinica INT,
    id_prof_saude INT,
    id_endereco INT,
    condicoes_ambientais TEXT,
    observacoes TEXT,
    FOREIGN KEY (id_paciente) REFERENCES PACIENTE(id_paciente),
    FOREIGN KEY (id_clinica) REFERENCES CLINICA(id_clinica),
    FOREIGN KEY (id_prof_saude) REFERENCES PROF_SAUDE(id_prof_saude),
    FOREIGN KEY (id_endereco) REFERENCES ENDERECO(id_endereco)
);

CREATE TABLE SESSAO_EMG (
    id_sessao INT AUTO_INCREMENT PRIMARY KEY,
    id_exame INT,
    id_movimento INT,
    data_inicio DATETIME,
    data_fim DATETIME,
    duracao FLOAT,
    fsr FLOAT,
    FOREIGN KEY (id_exame)
        REFERENCES EXAME (id_exame),
    FOREIGN KEY (id_movimento)
        REFERENCES MOVIMENTO (id_movimento)
);

CREATE TABLE LEITURA (
    id_leitura INT AUTO_INCREMENT PRIMARY KEY,
    id_sessao INT,
    tempo FLOAT,
    tensao FLOAT,
    amplitude FLOAT,
    FOREIGN KEY (id_sessao) REFERENCES SESSAO_EMG(id_sessao)
);



INSERT INTO ENDERECO (logradouro, numero, complemento, cidade, estado, cep)
VALUES 
('Rua das Flores', '123', 'Apt 101', 'São Paulo', 'SP', '01001-000'),
('Av. Brasil', '456', 'Bloco B', 'Rio de Janeiro', 'RJ', '21000-200'),
('Rua Amazonas', '789', NULL, 'Belo Horizonte', 'MG', '30130-070');

INSERT INTO GRUPO_MUSCULAR (nome_grupo)
VALUES 
('Bíceps'),
('Tríceps'),
('Deltóide');

INSERT INTO MOVIMENTO (nome_movimento, descricao)
VALUES 
('Flexão do Braço', 'Movimento de flexão do bíceps'),
('Extensão do Braço', 'Movimento de extensão do tríceps'),
('Rotação do Ombro', 'Movimento rotacional do deltóide');


INSERT INTO PROTOCOLO (nome_protocolo, objetivo, versao)
VALUES 
('Protocolo A', 'Avaliação de força muscular', '1.0'),
('Protocolo B', 'Teste de resistência', '2.1');

INSERT INTO ELETRODO (tipo, posicao_anatomica)
VALUES 
('Superficial', 'Bíceps esquerdo'),
('Superficial', 'Tríceps direito'),
('Intramuscular', 'Deltóide');

INSERT INTO PACIENTE (nome, data_nascimento, tipo_sanguineo, historico_medico, id_endereco)
VALUES 
('João da Silva', '1990-05-10', 'O+', 'Nenhum', 1),
('Maria Oliveira', '1985-09-15', 'A-', 'Hipertensão', 2),
('Carlos Souza', '1978-12-20', 'B+', 'Diabetes tipo 2', 3);

INSERT INTO CLINICA (nome, tipo_clinica, id_endereco)
VALUES 
('Clínica Saúde Total', 'Fisioterapia', 1),
('Clínica Reabilita', 'Ortopedia', 2);

INSERT INTO PROF_SAUDE (nome, registro_local, registro_profissional)
VALUES 
('Dr. Ana Costa', 'SP12345', 'CRM123456'),
('Dr. Pedro Almeida', 'RJ67890', 'CRM654321');

INSERT INTO CLINICA_PROF_SAUDE (id_clinica, id_prof_saude)
VALUES 
(1, 1),
(2, 2);

INSERT INTO EXAME (data, tipo_exame, id_paciente, id_clinica, id_prof_saude, id_endereco, condicoes_ambientais, observacoes)
VALUES 
('2024-11-01', 'Eletromiografia', 1, 1, 1, 1, 'Temperatura 22°C, umidade 50%', 'Sem observações'),
('2024-11-02', 'Avaliação postural', 2, 2, 2, 2, 'Temperatura 25°C, umidade 60%', 'Paciente com dores no ombro');

INSERT INTO MUSCULO (id_grupo_muscular, nome_musculo)
VALUES 
(1, 'Bíceps braquial'),
(2, 'Tríceps braquial'),
(3, 'Deltóide anterior');

INSERT INTO SESSAO_EMG (id_exame, id_movimento, data_inicio, data_fim, duracao, fsr)
VALUES 
(1, 1, '2024-11-01 14:00:00', '2024-11-01 14:30:00', 30.0, 0.8),
(2, 2, '2024-11-02 10:00:00', '2024-11-02 10:20:00', 20.0, 0.6);


INSERT INTO LEITURA (id_sessao, tempo, tensao, amplitude)
VALUES 
(1, 0.1, 1.2, 0.8),
(1, 0.2, 1.4, 0.9),
(2, 0.1, 1.1, 0.7);







