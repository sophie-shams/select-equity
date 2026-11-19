-- Select Equity
-- Je prépare les tables du projet et je contrôle les données importées
-- Je relie les cours au référentiel par ticker pour retrouver l'ISIN de chaque action

-- Je crée la base select-equity pour regrouper les tables du projet
CREATE DATABASE IF NOT EXISTS select_equity;
USE select_equity;
SELECT DATABASE() AS base_active;
-- Je prépare la table qui associe chaque ticker à son ISIN et à son CIK
CREATE TABLE IF NOT EXISTS select_equity.referentiel_titres (
    Ticker VARCHAR(10) PRIMARY KEY,
    ISIN CHAR(12) NOT NULL UNIQUE,
    Place_cotation VARCHAR(80) NOT NULL,
    CIK CHAR(10) NOT NULL
);
SELECT Ticker, ISIN, Place_cotation, CIK
FROM select_equity.referentiel_titres
ORDER BY Ticker;
-- Je prépare la table des cours, avec une seule ligne par ticker et par séance
CREATE TABLE IF NOT EXISTS select_equity.cours_journaliers (
    `Date` DATE NOT NULL,
    Cloture_ajustee DECIMAL(20,10) NOT NULL,
    Cloture DECIMAL(20,10) NOT NULL,
    High DECIMAL(20,10),
    Low DECIMAL(20,10),
    Open DECIMAL(20,10),
    Volume BIGINT,
    Ticker VARCHAR(10) NOT NULL,
    PRIMARY KEY (`Date`, Ticker)
);
-- Je compte les séances par ticker pour vérifier que le CSV a été importé en entier
SELECT Ticker, COUNT(*) AS nombre_seances
FROM select_equity.cours_journaliers
GROUP BY Ticker
ORDER BY Ticker;
-- Je teste la jointure sur une suele date pour vérifier que les cinq actions retrouvent leur ISIN et que SOXX reste visible
SELECT
    c.Ticker,
    r.ISIN,
    c.`Date`,
    c.Cloture_ajustee
FROM select_equity.cours_journaliers AS c
LEFT JOIN select_equity.referentiel_titres AS r
    ON c.Ticker = r.Ticker
WHERE c.`Date` = '2025-12-31'
ORDER BY c.Ticker;
-- J'enregiestre la jointure dans une vue pour pouvoir la réutiliser sur toutes les dates
CREATE OR REPLACE VIEW select_equity.v_cours_avec_isin AS
SELECT
    c.`Date`,
    c.Ticker,
    r.ISIN,
    c.Cloture,
    c.Cloture_ajustee
FROM select_equity.cours_journaliers AS c
LEFT JOIN select_equity.referentiel_titres AS r
    ON c.Ticker = r.Ticker;
-- Je verifie le nombre de lignes
SELECT
    COUNT(*) AS total_lignes,
    COUNT(ISIN) AS lignes_avec_isin
FROM select_equity.v_cours_avec_isin;
