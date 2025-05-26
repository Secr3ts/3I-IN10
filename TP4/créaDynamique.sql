-- 4.1
CREATE TABLE
    Softs AS (
        SELECT
            nomLog,
            version,
            prix
    );

ALTER TABLE Softs
RENAME COLUMN nomLog TO nomSoft;

CREATE TABLE
    PCSeuls AS
SELECT
    p.nPoste AS nP,
    p.nomPoste AS nomP,
    s.indIP AS seg,
    p.ad,
    p.typePoste AS typeP,
    p.nSalle AS salle
FROM
    Poste p
    JOIN Salle sa ON p.nSalle = sa.nSalle
    JOIN Segment s ON sa.indIP = s.indIP
WHERE
    p.typePoste IN ('PCWS', 'PCNT');