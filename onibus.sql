CREATE TABLE `onibus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `placa` varchar(10) COLLATE utf8_bin NOT NULL,
  `quantidade_assento`INT NOT NULL,
  `ativo` tinyint DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `placa_UNIQUE` (`placa`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;


CREATE TABLE `assento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_onibus` int NOT NULL,
  `numero` int NOT NULL,
  `ativo` tinyint DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE (`id_onibus`, `numero`), 
  FOREIGN KEY (`id_onibus`) REFERENCES `onibus` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

DELIMITER //
CREATE TRIGGER gerar_assentos_automaticamente
AFTER INSERT ON `onibus`
FOR EACH ROW
BEGIN
  DECLARE i INT DEFAULT 1;
  WHILE i <= NEW.quantidade_assento DO
    INSERT INTO assento (id_onibus, numero) VALUES (NEW.id, i);
    SET i = i + 1;
  END WHILE;
END;
//
DELIMITER ;


CREATE TABLE `viagem` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_onibus` int NOT NULL,
  `cidade_origem` varchar(100) COLLATE utf8_bin NOT NULL,
  `data_saida` varchar(10) COLLATE utf8_bin NOT NULL,
  `horario_saida` varchar(5) COLLATE utf8_bin NOT NULL,
  `cidade_destino` varchar(100) COLLATE utf8_bin NOT NULL,
  `data_chegada` varchar(10) COLLATE utf8_bin NOT NULL,
  `horario_previsto_chegada` varchar(5) COLLATE utf8_bin NOT NULL,
  `ativo` tinyint DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_viagem_onibus_idx` (`id_onibus`),
  CONSTRAINT `fk_viagem_onibus` FOREIGN KEY (`id_onibus`) REFERENCES `onibus` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

CREATE TABLE `onibus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `placa` varchar(10) COLLATE utf8_bin NOT NULL,
  `quantidade_assento` INT NOT NULL,
  `ativo` tinyint DEFAULT '1',
  `disponibilidade` TINYINT DEFAULT '1',
  `em_manutencao` TINYINT DEFAULT '0',
  `quebrado` TINYINT DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `placa_UNIQUE` (`placa`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;


CREATE TABLE `passageiro` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) COLLATE utf8_bin NOT NULL,
  `sexo` varchar(1) COLLATE utf8_bin NOT NULL,
  `email` varchar(150) COLLATE utf8_bin NOT NULL,
  `cpf` varchar(14) COLLATE utf8_bin NOT NULL,
  `celular` varchar(14) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `cpf_UNIQUE` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;


UPDATE onibus
SET placa = 'NOVAPLACA', quantidade_assento = 50
WHERE id = 1;


DELETE FROM assento WHERE id_onibus = 1;
DELETE FROM viagem WHERE id_onibus = 1;
DELETE FROM onibus WHERE id = 1;


SELECT * FROM onibus;


UPDATE viagem
SET cidade_origem = 'Nova Origem', cidade_destino = 'Novo Destino', data_saida = '2024-10-10', horario_saida = '08:00:00'
WHERE id = 1;


DELETE FROM viagem WHERE id = 1;


SELECT * FROM viagem;


UPDATE passageiro
SET nome = 'Novo Nome', email = 'novoemail@example.com', celular = '999999999'
WHERE id = 1;


DELETE FROM passageiro WHERE id = 1;

SELECT * FROM passageiro;

SELECT * FROM passageiro;

SELECT * FROM onibus WHERE quebrado = 1;

SELECT * FROM onibus WHERE em_manutencao = 1;
