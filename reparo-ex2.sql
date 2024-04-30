CREATE DATABASE mecanica

USE mecanica

CREATE TABLE cliente(
id				INT				NOT NULL	IDENTITY(3401,15),	
nome			VARCHAR(100)	NOT NULL,
logradouro		VARCHAR(200),
numero			INT				NOT NULL	CHECK(numero>=0),
cep				CHAR(8)			NOT NULL	CHECK(LEN(cep)=8),
complemento		VARCHAR(255),
PRIMARY KEY(id)
)

CREATE TABLE veiculo(
placa			CHAR(7)			NOT NULL	CHECK(LEN(placa) = 7),	
marca			VARCHAR(30)		NOT NULL,
modelo			VARCHAR(30)		NOT NULL,
cor				VARCHAR(15)		NOT NULL,
ano_fabricacao	INT				NOT NULL,
ano_modelo		INT				NOT NULL,
data_aquisicao	DATE,
clienteID		INT,
CONSTRAINT chk_ano_modelo CHECK(
(ano_modelo >= ano_fabricacao) AND (ano_modelo <= (ano_fabricacao +1))
),
PRIMARY KEY (placa),
FOREIGN KEY (clienteID) REFERENCES cliente(id)
)

CREATE TABLE telefone_cliente(
clienteID	INT				NOT NULL,
telefone	VARCHAR(11)		NOT NULL	CHECK(LEN(telefone) >=10),
FOREIGN KEY (clienteID) REFERENCES cliente(id),
PRIMARY KEY (telefone, clienteID)
)

CREATE TABLE peca(
id			INT				NOT NULL	IDENTITY(3411, 7),
nome		VARCHAR(30)		NOT NULL	UNIQUE,		
preco		DECIMAL(4,2)	NOT NULL	CHECK(preco >= 0),
estoque		INT				NOT NULL	CHECK(estoque >= 10),
PRIMARY KEY(id)
)

CREATE TABLE categoria(
id				INT				NOT NULL	IDENTITY,
categoria		VARCHAR(10)		NOT NULL,
valor_hora		DECIMAL(4,2)	NOT NULL,
PRIMARY KEY(id),
CONSTRAINT check_categoria_valorhora
		CHECK	((UPPER(categoria) = 'ESTAGIÁRIO' AND valor_hora > 15) OR
				(UPPER(categoria) = 'NÍVEL 1' AND valor_hora > 25) OR
				(UPPER(categoria) = 'NÍVEL 2' AND valor_hora > 35) OR
				(UPPER(categoria) = 'NÍVEL 3' AND valor_hora > 50))
)

CREATE TABLE funcionario (
id					INT				NOT NULL	IDENTITY(101, 1),
nome				VARCHAR(100)	NOT NULL,
end_logradouro		VARCHAR(200)	NOT NULL,
end_numero			INT				NOT NULL	CHECK(end_numero > 0),
end_cep				CHAR(8)			NOT NULL	CHECK(LEN(end_cep) = 8),
end_complemento		VARCHAR(255)	NOT NULL,
telefone			CHAR(11)		NOT NULL	CHECK(LEN(telefone) = 10 OR LEN(telefone) = 11),
catego_habilitacao	VARCHAR(2)		NOT NULL	CHECK((UPPER(catego_habilitacao) = 'A') OR
													(UPPER(catego_habilitacao) = 'B') OR
													(UPPER(catego_habilitacao) = 'C') OR
													(UPPER(catego_habilitacao) = 'D') OR
													(UPPER(catego_habilitacao) = 'E')),
id_categoria		INT				NOT NULL
	PRIMARY KEY (id)
	FOREIGN KEY (id_categoria) REFERENCES categoria(id)
)

CREATE TABLE reparo (
	placa_veiculo		CHAR(7)			NOT NULL,
	id_funcionario		INT				NOT NULL,
	id_peca				INT				NOT NULL,
	data_reparo			DATE			NOT NULL	DEFAULT GETDATE(),
	custo_total			DECIMAL(4, 2)	NOT NULL	CHECK(custo_total > 0),
	tempo				INT				NOT NULL	CHECK(tempo > 0),
	PRIMARY KEY (placa_veiculo, id_funcionario, id_peca, data_reparo),
	FOREIGN KEY (placa_veiculo) REFERENCES veiculo(placa),
	FOREIGN KEY (id_funcionario) REFERENCES funcionario(id),
	FOREIGN KEY (id_peca) REFERENCES peca(id),
)