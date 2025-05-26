
-- Requête 27 : Installations détaillées triées par segment, salle et adresse IP
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

-- Requête 28 (Q20 avec SQL2 JOIN)
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

-- Requête 29 (Q21 avec SQL2 JOIN)
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

-- Requête 30 (Q22 avec SQL2)
SELECT 
    nomLog
FROM 
    Logiciel
WHERE 
    dateAch = (
        SELECT MAX(dateAch) FROM Logiciel
    );

-- Requête 31 (Nombres d'installations totales par salle)
SELECT 
    sa.nomSalle,
    COUNT(*) AS nb_installations
FROM 
    Installer i
    JOIN Poste p ON i.nPoste = p.nPoste
    JOIN Salle sa ON p.nSalle = sa.nSalle
GROUP BY 
    sa.nomSalle;
