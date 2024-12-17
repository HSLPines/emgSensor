
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

CREATE TABLE ACCOUNT (
	id_account VARCHAR(255) PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    data_inicio DATE NOT NULL,
	secao_account INT NOT NULL,
    musculo_pref VARCHAR(255)
);

CREATE TABLE USUARIO (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    login VARCHAR(255) NOT NULL UNIQUE,
    senha_hash VARCHAR(255),
	data_inicio DATE,    
    musculo_pref varchar(255) NOT NULL,
    id_sessao int,
	foreign key (id_sessao)
		references sessao_emg (id_sessao)
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

INSERT INTO USUARIO (nome, login, data_inicio, musculo_pref)
VALUES
('Henrique Lecce','hslecce', '2024-05-05', 'Biceps'),
('João Helbel','jphelbel','2024-07-19','Coxa'),
('Márcio Alexandroni','marcioA','2024-05-27','Costas'),
('Paulo do Carmo','iampauloc','2024-10-13','Peitoral') ;

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

INSERT INTO sessao_emg (id_sessao) VALUES (1), (2), (3), (4), (5);


INSERT INTO leitura (id_sessao, tempo, tensao, amplitude)
VALUES 
(1, 0, 3.3, 49.5),
(1, 0.2, 2.2, 33),
(1, 0.4, 3.5, 52.5),
(1, 0.6, 1.3, 19.5),
(1, 0.8, 0.2, 3),
(1, 1, 4.7, 70.5),
(1, 1.2, 0.8, 12),
(1, 1.4, 4, 60),
(1, 1.6, 0.6, 9),
(1, 1.8, 2.2, 33),
(1, 2, 3.1, 46.5),
(1, 2.2, 1.2, 18),
(1, 2.4, 0.7, 10.5),
(1, 2.6, 1.8, 27),
(1, 2.8, 2, 30),
(1, 3, 3.1, 46.5),
(1, 3.2, 4.3, 64.5),
(1, 3.4, 4.2, 63),
(1, 3.6, 4.1, 61.5),
(1, 3.8, 2.9, 43.5),
(1, 4, 3.7, 55.5),
(1, 4.2, 1.1, 16.5),
(1, 4.4, 2.8, 42),
(1, 4.6, 1, 15),
(1, 4.8, 3.8, 57),
(1, 5, 3.5, 52.5),
(1, 5.2, 2.5, 37.5),
(1, 5.4, 1.3, 19.5),
(1, 5.6, 2.8, 42),
(1, 5.8, 4.4, 66),
(1, 6, 1.1, 16.5),
(1, 6.2, 4.1, 61.5),
(1, 6.4, 4.1, 61.5),
(1, 6.6, 3.2, 48),
(1, 6.8, 2.4, 36),
(1, 7, 2.2, 33),
(1, 7.2, 3.5, 52.5),
(1, 7.4, 1.2, 18),
(1, 7.6, 4.2, 63),
(1, 7.8, 1.7, 25.5),
(1, 8, 5, 75),
(1, 8.2, 3.6, 54),
(1, 8.4, 1.3, 19.5),
(1, 8.6, 1, 15),
(1, 8.8, 1.8, 27),
(1, 9, 0.9, 13.5),
(1, 9.2, 1.5, 22.5),
(1, 9.4, 0.5, 7.5),
(1, 9.6, 1.4, 21),
(1, 9.8, 2.9, 43.5),
(1, 10, 3.5, 52.5),
(1, 10.2, 2.7, 40.5),
(1, 10.4, 0.6, 9),
(1, 10.6, 0.8, 12),
(1, 10.8, 1.2, 18),
(1, 11, 1.5, 22.5),
(1, 11.2, 2.6, 39),
(1, 11.4, 4.9, 73.5),
(1, 11.6, 4.2, 63),
(1, 11.8, 4.8, 72),
(1, 12, 2.2, 33),
(1, 12.2, 5, 75),
(1, 12.4, 2.8, 42),
(1, 12.6, 2.7, 40.5),
(1, 12.8, 1.4, 21),
(1, 13, 3.6, 54),
(1, 13.2, 4.6, 69),
(1, 13.4, 2.8, 42),
(1, 13.6, 3.5, 52.5),
(1, 13.8, 2.1, 31.5),
(1, 14, 1.9, 28.5),
(1, 14.2, 1.2, 18),
(1, 14.4, 2.3, 34.5),
(1, 14.6, 0.5, 7.5),
(1, 14.8, 1.5, 22.5),
(1, 15, 1, 15),
(1, 15.2, 3.8, 57),
(1, 15.4, 2.4, 36),
(1, 15.6, 3, 45),
(1, 15.8, 2.7, 40.5),
(1, 16, 4.9, 73.5),
(1, 16.2, 3.9, 58.5),
(1, 16.4, 0.5, 7.5),
(1, 16.6, 4.2, 63),
(1, 16.8, 3.3, 49.5),
(1, 17, 2.6, 39),
(1, 17.2, 0.8, 12),
(1, 17.4, 1.9, 28.5),
(1, 17.6, 4.9, 73.5),
(1, 17.8, 4.7, 70.5),
(1, 18, 4.6, 69),
(1, 18.2, 3.9, 58.5),
(1, 18.4, 3.8, 57),
(1, 18.6, 4, 60),
(1, 18.8, 3.5, 52.5),
(1, 19, 4.4, 66),
(1, 19.2, 4.6, 69),
(1, 19.4, 0.2, 3),
(1, 19.6, 0.5, 7.5),
(1, 19.8, 1.3, 19.5),
(2, 0, 4.2, 63),
(2, 0.2, 4, 60),
(2, 0.4, 4.5, 67.5),
(2, 0.6, 4.2, 63),
(2, 0.8, 0.7, 10.5),
(2, 1, 4.4, 66),
(2, 1.2, 3.1, 46.5),
(2, 1.4, 2.6, 39),
(2, 1.6, 4.6, 69),
(2, 1.8, 0.9, 13.5),
(2, 2, 3.6, 54),
(2, 2.2, 4.9, 73.5),
(2, 2.4, 1.3, 19.5),
(2, 2.6, 3.7, 55.5),
(2, 2.8, 2.7, 40.5),
(2, 3, 0.8, 12),
(2, 3.2, 4.9, 73.5),
(2, 3.4, 0.1, 1.5),
(2, 3.6, 2.1, 31.5),
(2, 3.8, 2.7, 40.5),
(2, 4, 4.6, 69),
(2, 4.2, 1.2, 18),
(2, 4.4, 0.3, 4.5),
(2, 4.6, 2.7, 40.5),
(2, 4.8, 1.1, 16.5),
(2, 5, 2.1, 31.5),
(2, 5.2, 2, 30),
(2, 5.4, 3.8, 57),
(2, 5.6, 4.4, 66),
(2, 5.8, 2.1, 31.5),
(2, 6, 0.4, 6),
(2, 6.2, 0.5, 7.5),
(2, 6.4, 1.8, 27),
(2, 6.6, 2.9, 43.5),
(2, 6.8, 3.5, 52.5),
(2, 7, 5, 75),
(2, 7.2, 0.8, 12),
(2, 7.4, 4.4, 66),
(2, 7.6, 4.7, 70.5),
(2, 7.8, 2.1, 31.5),
(2, 8, 0.2, 3),
(2, 8.2, 0.7, 10.5),
(2, 8.4, 2, 30),
(2, 8.6, 0.4, 6),
(2, 8.8, 1.7, 25.5),
(2, 9, 3, 45),
(2, 9.2, 1.3, 19.5),
(2, 9.4, 1.7, 25.5),
(2, 9.6, 3.7, 55.5),
(2, 9.8, 3.8, 57),
(2, 10, 2.8, 42),
(2, 10.2, 1.9, 28.5),
(2, 10.4, 3.6, 54),
(2, 10.6, 4.5, 67.5),
(2, 10.8, 1, 15),
(2, 11, 1.6, 24),
(2, 11.2, 4.4, 66),
(2, 11.4, 0.2, 3),
(2, 11.6, 4.2, 63),
(2, 11.8, 4.6, 69),
(2, 12, 0.5, 7.5),
(2, 12.2, 2.7, 40.5),
(2, 12.4, 1.7, 25.5),
(2, 12.6, 5, 75),
(2, 12.8, 0.8, 12),
(2, 13, 4.5, 67.5),
(2, 13.2, 4.5, 67.5),
(2, 13.4, 2.2, 33),
(2, 13.6, 1, 15),
(2, 13.8, 0.4, 6),
(2, 14, 5, 75),
(2, 14.2, 4.9, 73.5),
(2, 14.4, 1.1, 16.5),
(2, 14.6, 0.5, 7.5),
(2, 14.8, 3.3, 49.5),
(2, 15, 3.2, 48),
(2, 15.2, 0, 0),
(2, 15.4, 1.9, 28.5),
(2, 15.6, 3.9, 58.5),
(2, 15.8, 0.3, 4.5),
(2, 16, 5, 75),
(2, 16.2, 4, 60),
(2, 16.4, 1.3, 19.5),
(2, 16.6, 1.5, 22.5),
(2, 16.8, 4, 60),
(2, 17, 2.6, 39),
(2, 17.2, 0.7, 10.5),
(2, 17.4, 0.6, 9),
(2, 17.6, 4.3, 64.5),
(2, 17.8, 0.8, 12),
(2, 18, 4, 60),
(2, 18.2, 2.5, 37.5),
(2, 18.4, 2.8, 42),
(2, 18.6, 4.7, 70.5),
(2, 18.8, 3.4, 51),
(2, 19, 0, 0),
(2, 19.2, 2.5, 37.5),
(2, 19.4, 3.5, 52.5),
(2, 19.6, 1.9, 28.5),
(2, 19.8, 0.8, 12),
(3, 0, 2.1, 31.5),
(3, 0, 2.1, 31.5),
(3, 0.2, 4, 60),
(3, 0.4, 3.7, 55.5),
(3, 0.6, 3.6, 54),
(3, 0.8, 3.7, 55.5),
(3, 1, 1.6, 24),
(3, 1.2, 4.5, 67.5),
(3, 1.4, 1.2, 18),
(3, 1.6, 4.2, 63),
(3, 1.8, 0.2, 3),
(3, 2, 2.7, 40.5),
(3, 2.2, 1.7, 25.5),
(3, 2.4, 2.6, 39),
(3, 2.6, 1.9, 28.5),
(3, 2.8, 1.1, 16.5),
(3, 3, 0.7, 10.5),
(3, 3.2, 0, 0),
(3, 3.4, 1.6, 24),
(3, 3.6, 4.7, 70.5);







