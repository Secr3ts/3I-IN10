# creParc.sql - TP1
USE Parc;

CREATE TABLE Segment (
    indIP VARCHAR(11) NOT NULL,
    nomSegment VARCHAR(20) NOT NULL,
    etage TINYINT(1),
    PRIMARY KEY (indIP)
);

CREATE TABLE Salle (
    nSalle VARCHAR(7) NOT NULL,
    nomSalle VARCHAR(20) NOT NULL,
    nbPoste TINYINT(2),
    indIP VARCHAR(11) NOT NULL,
    PRIMARY KEY (nSalle),
    FOREIGN KEY (indIP) REFERENCES Segment(indIP)
);

CREATE TABLE Poste (
    nPoste VARCHAR(7) NOT NULL,
    nomPoste VARCHAR(20) NOT NULL,
    ad VARCHAR(3),
    typePoste VARCHAR(9),
    nSalle VARCHAR(7) NOT NULL,
    PRIMARY KEY (nPoste),
    FOREIGN KEY (nSalle) REFERENCES Salle(nSalle)
);

CREATE TABLE Logiciel (
    nLog VARCHAR(5) NOT NULL,
    nomLog VARCHAR(20) NOT NULL,
    dateAch dateTIME,
    version VARCHAR(7),
    typeLog VARCHAR(9),
    prix DECIMAL(6,2),
    PRIMARY KEY (nLog),
    CHECK (prix >= 0)
);

CREATE TABLE Installer(
    nPoste VARCHAR(7) NOT NULL,
    nLog VARCHAR(5) NOT NULL,
    numIns INTEGER(5) NOT NULL,
    dateIns TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    delai SMALLINT,
    PRIMARY KEY (numIns),
    FOREIGN KEY (nPoste) REFERENCES Poste(nPoste),
    FOREIGN KEY (nLog) REFERENCES Logiciel(nLog)
);

CREATE TABLE Types(
    typeLP VARCHAR(9) NOT NULL,
    nomType VARCHAR(20),
    PRIMARY KEY (typeLP)
);
