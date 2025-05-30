-- 4.1
CREATE TABLE
    Softs AS
SELECT
    l.nomLog AS nomSoft,
    l.version AS version,
    l.prix AS prix
FROM
    Logiciel l;

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