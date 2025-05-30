-- 4.2
SELECT
    typePoste
FROM
    Poste
WHERE
    nPoste = 'p8';

SELECT
    nomLog
FROM
    Logiciel
WHERE
    typeLog = 'UNIX';

SELECT
    nomP,
    seg,
    salle
FROM
    PCSeuls;

SELECT
    nomP,
    seg,
    salle
FROM
    PCSeuls
WHERE
    seg = '130.120.80'
ORDER BY
    salle DESC;

SELECT
    nLog
FROM
    Installer
WHERE
    nPoste = 'p6';

SELECT
    i.nLog
FROM
    Installer i
    JOIN Logiciel l ON i.nLog = l.nLog
WHERE
    l.nomLog = 'log1';

SELECT
    nomPoste,
    CONCAT ('130.120.80', ad)
FROM
    Poste
WHERE
    typePoste = 'TX';

-- 4.3
SELECT
    i.nPoste,
    COUNT(i.nLog) AS nb_log
FROM
    Installer i
GROUP BY
    i.nPoste;

SELECT
    nSalle,
    COUNT(nPoste) as nb_pc
FROM
    Poste
GROUP BY
    nSalle;

SELECT
    nLog,
    COUNT(DISTINCT nPoste) AS nb_pos
FROM
    Installer
GROUP BY
    nLog;

SELECT
    AVG(PRIX) AS avg_c
FROM
    Logiciel
WHERE
    typeLog = 'UNIX';

SELECT
    MAX(dateAch) as last_a
FROM
    Logiciel;

SELECT
    nPoste
FROM
    Installer
GROUP BY
    nPoste
HAVING
    COUNT(DISTINCT nLog) = 2;

SELECT
    COUNT(*) AS nb_pos
FROM
    (
        SELECT
            nPoste
        FROM
            Installer
        GROUP BY
            nPoste
        HAVING
            COUNT(DISTINCT nLog) = 2
    ) AS postes;

-- 4.4
SELECT
    t.nomType
FROM
    Types t
    LEFT JOIN Poste p ON t.typeLP = p.typePoste
WHERE
    p.nPoste IS NULL;

SELECT DISTINCT
    t.nomType
FROM
    Types t
    JOIN Poste p ON t.typeLP = p.typePoste
    JOIN Logiciel l ON t.typeLP = l.typeLog;

SELECT DISTINCT
    p.typePoste as type_no_log
FROM
    Poste p
    LEFT JOIN Logiciel l ON p.typePoste = l.typeLog
WHERE
    l.nLog IS NULL;

SELECT
    CONCAT ('130.120.80', p.ad)
FROM
    Poste p,
    Installer i
WHERE
    i.nLog = 'log6'
    AND p.nPoste = i.nPoste;

SELECT
    CONCAT ('130.120.80', p.ad)
FROM
    Poste p,
    Installer i
WHERE
    i.nLog = (
        SELECT
            nLog
        FROM
            Logiciel
        WHERE
            nomLog = 'Oracle 8'
    )
    AND p.nPoste = i.nPoste;

SELECT
    s.nomSegment
FROM
    Segment s
    JOIN Salle sa ON s.indIP = sa.indIP
    JOIN Poste p ON sa.nSalle = p.nSalle
WHERE
    p.typePoste = 'TX'
GROUP BY
    s.nomSegment
HAVING
    COUNT(p.nPoste) = 3;

SELECT
    sa.nomSalle
FROM
    Salle sa
    JOIN Poste p ON sa.nSalle = p.nSalle
    JOIN Installer i ON p.nPoste = i.nPoste
    JOIN Logiciel l ON i.nLog = l.nLog
WHERE
    l.nomLog = 'Oracle 6'
GROUP BY
    sa.nomSalle;

SELECT
    nomLog
FROM
    Logiciel
WHERE
    dateAch = (
        SELECT
            MAX(dateAch)
        FROM
            Logiciel
    );

SELECT 
    sg.nomSegment,
    sa.nomSalle,
    CONCAT(sg.indIP, '.', p.ad) AS adresse_ip,
    l.nomLog,
    i.dateIns
FROM 
    Installer i
    JOIN Poste p ON i.nPoste = p.nPoste
    JOIN Salle sa ON p.nSalle = sa.nSalle
    JOIN Segment sg ON sa.indIP = sg.indIP
    JOIN Logiciel l ON i.nLog = l.nLog
ORDER BY 
    sg.nomSegment, sa.nomSalle, adresse_ip;

SELECT 
    s.nomSegment
FROM 
    Segment s
    JOIN Salle sa ON s.indIP = sa.indIP
    JOIN Poste p ON sa.nSalle = p.nSalle
WHERE 
    p.typePoste = 'TX'
GROUP BY 
    s.nomSegment
HAVING 
    COUNT(p.nPoste) = 3;

SELECT 
    sa.nomSalle
FROM 
    Salle sa
    JOIN Poste p ON sa.nSalle = p.nSalle
    JOIN Installer i ON p.nPoste = i.nPoste
    JOIN Logiciel l ON i.nLog = l.nLog
WHERE 
    l.nomLog = 'Oracle 6'
GROUP BY 
    sa.nomSalle;

SELECT 
    nomLog
FROM 
    Logiciel
WHERE 
    dateAch = (
        SELECT MAX(dateAch) FROM Logiciel
    );

SELECT 
    sa.nomSalle,
    COUNT(*) AS nb_installations
FROM 
    Installer i
    JOIN Poste p ON i.nPoste = p.nPoste
    JOIN Salle sa ON p.nSalle = sa.nSalle
GROUP BY 
    sa.nomSalle;

-- 4.6
SELECT DISTINCT i2.nPoste
FROM Installer i1
JOIN Installer i2 ON i1.nLog = i2.nLog
WHERE i1.nPoste = 'p6'
  AND i2.nPoste <> 'p6';

SELECT i2.nPoste
FROM Installer i2
WHERE i2.nPoste <> 'p6'
GROUP BY i2.nPoste
HAVING 
    NOT EXISTS (
        SELECT *
        FROM Installer i1
        WHERE i1.nPoste = 'p6'
        AND i1.nLog NOT IN (
            SELECT i3.nLog
            FROM Installer i3
            WHERE i3.nPoste = i2.nPoste
        )
    );

SELECT i2.nPoste
FROM Installer i2
WHERE i2.nPoste <> 'p2'
GROUP BY i2.nPoste
HAVING 
    NOT EXISTS (
        SELECT *
        FROM Installer i1
        WHERE i1.nPoste = 'p2'
        AND i1.nLog NOT IN (
            SELECT i3.nLog FROM Installer i3 WHERE i3.nPoste = i2.nPoste
        )
    )
    AND NOT EXISTS (
        SELECT *
        FROM Installer i1
        WHERE i1.nPoste = i2.nPoste
        AND i1.nLog NOT IN (
            SELECT i3.nLog FROM Installer i3 WHERE i3.nPoste = 'p2'
        )
    );
