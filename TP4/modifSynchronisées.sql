-- 4.5
INSERT INTO Installer (nPoste, nLog, numIns, dateIns, delai)
VALUES 
('p2', 'log6', NULL, SYSDATE(), NULL),
('p8', 'log1', NULL, SYSDATE(), NULL),
('p10', 'log1', NULL, SYSDATE(), NULL);

UPDATE Segment s
SET nbSalle = (
    SELECT COUNT(DISTINCT sa.nSalle)
    FROM Salle sa
    WHERE sa.indIP = s.indIP
);

UPDATE Segment s
SET nbPoste = (
    SELECT COUNT(p.nPoste)
    FROM Salle sa
    JOIN Poste p ON sa.nSalle = p.nSalle
    WHERE sa.indIP = s.indIP
);

UPDATE Logiciel l
SET nbInstall = (
    SELECT COUNT(*)
    FROM Installer i
    WHERE i.nLog = l.nLog
);

UPDATE Poste p
SET nbLog = (
    SELECT COUNT(*)
    FROM Installer i
    WHERE i.nPoste = p.nPoste
);
