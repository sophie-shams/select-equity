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

-- Je crée la table des indicateurs financiers.
-- Chaque action peut avoir une ligne par date d'analyse.

CREATE TABLE IF NOT EXISTS select_equity.synthese_financiere (
    Ticker VARCHAR(10) NOT NULL,
    Date_bilan DATE NOT NULL,
    Date_depot DATE NOT NULL,
    Dette_nette_MUSD DECIMAL(18,4),
    Marge_operationnelle_pct DECIMAL(18,6),
    BPA_4_trimestres_USD DECIMAL(18,6),
    PE_historique DECIMAL(18,6),
    Date_analyse DATE NOT NULL,
    PRIMARY KEY (Ticker, Date_analyse)
);
-- Je vérifie les cinq actions importées pour la date d'analyse.

SELECT Ticker, Dette_nette_MUSD, Marge_operationnelle_pct, PE_historique
FROM select_equity.synthese_financiere
WHERE Date_analyse = '2025-12-31'
ORDER BY Ticker;
-- Je crée une table pour les indicateurs de marché calculés sur 2021–2025.
-- Chaque ticker a une seule ligne, y compris SOXX.

CREATE TABLE IF NOT EXISTS select_equity.synthese_marche (
    Ticker VARCHAR(10) PRIMARY KEY,
    Rendement_cumule_pct DECIMAL(18,6),
    Ecart_vs_SOXX_points DECIMAL(18,6),
    Perte_maximale_pct DECIMAL(18,6),
    Date_creux CHAR(10)
);
-- Je vérifie qu'une ligne a été importée pour chacun des six tickers.
SELECT *
FROM select_equity.synthese_marche
ORDER BY Ticker;

-- Je réunis les indicateurs de marché et les indicateurs financiers par ticker.
-- Je pars du référentiel pour avoir une ligne par action et son ISIN.

CREATE OR REPLACE VIEW select_equity.v_fiche_action_2025 AS
SELECT
    r.Ticker,
    r.ISIN,
    m.Rendement_cumule_pct,
    m.Ecart_vs_SOXX_points,
    m.Perte_maximale_pct,
    STR_TO_DATE(m.Date_creux, '%d/%m/%Y') AS Date_creux,
    f.Dette_nette_MUSD,
    f.Marge_operationnelle_pct,
    f.PE_historique,
    f.Date_bilan,
    f.Date_depot,
    f.Date_analyse
FROM select_equity.referentiel_titres AS r
LEFT JOIN select_equity.synthese_marche AS m
    ON m.Ticker = r.Ticker
LEFT JOIN select_equity.synthese_financiere AS f
    ON f.Ticker = r.Ticker
    AND f.Date_analyse = '2025-12-31';

-- Je vérifie que la vue affiche une fiche pour chacune des cinq actions.

SELECT *
FROM select_equity.v_fiche_action_2025
ORDER BY Ticker;