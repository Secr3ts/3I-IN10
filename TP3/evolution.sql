-- 3.1

ALTER TABLE Segment
ADD COLUMN nbSalle TINYINT(2) DEFAULT 0,
ADD COLUMN nbPoste TINYINT(2) DEFAULT 0
;

ALTER TABLE Logiciel
ADD COLUMN nbInstall TINYINT(2) DEFAULT 0;

ALTER TABLE Poste
ADD COLUMN nbLog TINYINT(2) DEFAULT 0;

-- 3.2

ALTER TABLE Salle
MODIFY COLUMN nomSalle VARCHAR(30);

ALTER TABLE Segment
MODIFY COLUMN nomSegment VARCHAR(15);

ALTER TABLE Segment
MODIFY COLUMN nomSegment VARCHAR(14)

-- Pas possible car nomSegment == 14 ?

-- 3.3
ALTER TABLE Installer
ADD CONSTRAINT unique_log UNIQUE (nPoste, nLog);

ALTER TABLE Poste
ADD CONSTRAINT fk_poste_type
FOREIGN KEY (typePoste) REFERENCES Types(typeLP);

ALTER TABLE Logiciel
ADD CONSTRAINT fk_lt
FOREIGN KEY (typeLog) REFERENCES Types(typeLP);

-- 3.4

ALTER TABLE Salle
ADD CONSTRAINT fk_salle_segment
FOREIGN KEY (indIP) REFERENCES Segment(indIP);

ALTER TABLE Logiciel
ADD CONSTRAINT fk_logiciel_type
FOREIGN KEY (typeLog) REFERENCES Types(typeLP);

INSERT INTO Types (typeLP, nomType) VALUES
('BeOS', 'Système Be');