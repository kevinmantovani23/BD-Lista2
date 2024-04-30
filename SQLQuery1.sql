CREATE DATABASE Maternidade

USE Maternidade

CREATE TABLE bebe(
id			INT				NOT NULL	IDENTITY,
nome		VARCHAR(60)		NOT NULL,
dataNasc	DATE			DEFAULT(GETDATE()),
altura		DECIMAL(7,2)	NOT NULL	CHECK(altura>=0),
peso		DECIMAL(4,3)	NOT NULL	CHECK(peso>=0),
maeID		INT				NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(maeID) REFERENCES mae(id)
)

CREATE TABLE mae(
id						INT				NOT NULL	IDENTITY(1001,1),
nome					VARCHAR(60)		NOT NULL,
logradouro_endereco		VARCHAR(100)	NOT NULL,
numero_endereco			INT				CHECK(numero_endereco >= 0),
cep_endereco			CHAR(8)			CHECK(LEN(cep_endereco) = 8),
complemento_endereco	VARCHAR(200),
telefone				CHAR(10)		CHECK(LEN(telefone) = 10),
dataNasc				DATE			NOT NULL,
PRIMARY KEY(id)
)

CREATE TABLE medico(
crm_numero			INT				NOT NULL,
crm_uf				CHAR(2)			NOT NULL,
nome				VARCHAR(60)		NOT NULL,
telefone_celular	CHAR(11)		NOT NULL	UNIQUE		CHECK(LEN(telefone_celular)>=0),
especialidade		VARCHAR(30)		NOT NULL,
PRIMARY KEY(crm_numero, crm_uf)
)

CREATE TABLE bebe_medico(
bebeID				INT			NOT NULL,
medicoCRM_numero	INT			NOT NULL,
medicoCRM_uf		CHAR(2)		NOT NULL,
PRIMARY KEY(bebeID, medicoCRM_numero, medicoCRM_uf),
FOREIGN KEY(medicoCRM_numero, medicoCRM_uf) REFERENCES medico(crm_numero, crm_uf),
FOREIGN KEY(bebeID) REFERENCES bebe(id),
)