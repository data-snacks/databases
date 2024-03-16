DROP SCHEMA IF EXISTS salarios;
CREATE SCHEMA salarios;
USE salarios;

DROP TABLE IF EXISTS `profesiones`;

CREATE TABLE `profesiones` (
  `id` INT NOT NULL,
  `profesion` VARCHAR(45) NULL,
  `salario` INT NULL,
  PRIMARY KEY (`id`));

INSERT INTO profesiones(Id, profesion, salario) VALUES (1,'A',38946);
INSERT INTO profesiones(Id, profesion, salario) VALUES (2,'A',43420);
INSERT INTO profesiones(Id, profesion, salario) VALUES (3,'A',49191);
INSERT INTO profesiones(Id, profesion, salario) VALUES (4,'A',50430);
INSERT INTO profesiones(Id, profesion, salario) VALUES (5,'A',50557);
INSERT INTO profesiones(Id, profesion, salario) VALUES (6,'A',52580);
INSERT INTO profesiones(Id, profesion, salario) VALUES (7,'A',53595);
INSERT INTO profesiones(Id, profesion, salario) VALUES (8,'A',54135);
INSERT INTO profesiones(Id, profesion, salario) VALUES (9,'A',60181);
INSERT INTO profesiones(Id, profesion, salario) VALUES (10,'A',62500);
INSERT INTO profesiones(Id, profesion, salario) VALUES (11,'B',33219);
INSERT INTO profesiones(Id, profesion, salario) VALUES (12,'B',36254);
INSERT INTO profesiones(Id, profesion, salario) VALUES (13,'B',38801);
INSERT INTO profesiones(Id, profesion, salario) VALUES (14,'B',46335);
INSERT INTO profesiones(Id, profesion, salario) VALUES (15,'B',46840);
INSERT INTO profesiones(Id, profesion, salario) VALUES (16,'B',47596);
INSERT INTO profesiones(Id, profesion, salario) VALUES (17,'B',55130);
INSERT INTO profesiones(Id, profesion, salario) VALUES (18,'B',56863);
INSERT INTO profesiones(Id, profesion, salario) VALUES (19,'B',78070);
INSERT INTO profesiones(Id, profesion, salario) VALUES (20,'B',88830);

SELECT * FROM profesiones;