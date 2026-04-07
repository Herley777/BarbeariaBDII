CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100) NOT NULL UNIQUE,
    data_cadastro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE barbeiros (
    id_barbeiro SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    CHECK (cpf ~ '^[0-9]{11}$')
);



CREATE TABLE categorias (
    id_categoria SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
);




CREATE TABLE servicos (
    id_servico SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco NUMERIC(10,2) NOT NULL,
    id_categoria INT NOT NULL,
    
    CONSTRAINT fk_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES categorias(id_categoria),
        
    CONSTRAINT preco_positivo
        CHECK (preco >= 0)
);




CREATE TABLE agendamentos (
    id_agendamento SERIAL PRIMARY KEY,
    data_hora TIMESTAMP NOT NULL,
    
    id_cliente INT NOT NULL,
    id_barbeiro INT NOT NULL,
    id_servico INT NOT NULL,
    
    valor_pago NUMERIC(10,2),

    CONSTRAINT fk_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),

    CONSTRAINT fk_barbeiro
        FOREIGN KEY (id_barbeiro)
        REFERENCES barbeiros(id_barbeiro),

    CONSTRAINT fk_servico
        FOREIGN KEY (id_servico)
        REFERENCES servicos(id_servico)
);






ALTER TABLE agendamentos
ADD CONSTRAINT barbeiro_horario_unico
UNIQUE (id_barbeiro, data_hora);

ALTER TABLE agendamentos
ADD CONSTRAINT cliente_horario_unico
UNIQUE (id_cliente, data_hora);

ALTER TABLE agendamentos
ADD CONSTRAINT valor_pago_positivo
CHECK (valor_pago >= 0);