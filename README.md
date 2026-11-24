<!--
  MODÈLE DE README — Pipeline Data, séquence 1, chapitre 5
  Les blocs comme celui-ci sont des consignes : GitHub ne les affiche pas.
  Remplace chaque [crochet] par ton texte, puis supprime les crochets.
  Repères Markdown : une ligne qui commence par # est un titre ; une ligne qui commence par - est une puce.
-->

# Select Equity - Analyse financière des actions par ISIN

<!-- Une phrase qui dit ce que fait ton projet. Exemple : « Prévoir la production de 6 boulangeries selon la météo pour réduire les invendus. » -->
Select Equity est un tableau de bord Power BI qui compare cinq actions
du secteur des semi-conducteurs et aide à examiner une entrée au
31 décembre 2025. L’utilisateur sélectionne une entreprise par son nom
et son ISIN, puis consulte sa performance face à SOXX, ses indicateurs
financiers et la décision du modèle.

## 1. Le problème

Les cours de Bourse et les comptes des entreprises proviennent de sources
différentes. Select Equity les réunit pour comparer AMD, Broadcom, Intel,
Marvell et NVIDIA sur la période 2021–2025.

**Question centrale**

Comment combiner les données boursières et financières pour déterminer
quelles actions envisager à l’achat et à quel cours examiner une entrée ?

### Comment le modèle arrive à sa décision

1. **Évaluer l’action.** Un score sur 5 combine la performance face à SOXX,
   le risque de marché, la croissance du chiffre d’affaires, l’endettement
   et la valorisation. Il donne un signal Achat, Conserver ou Ne pas acheter.
2. **Évaluer le moment d’entrée.** Pour une action classée Achat ou
   Conserver, le ratio des cours ajustés action / SOXX doit être au moins
   un écart-type sous sa moyenne des 60 séances précédentes. Le rapport
   traduit ce seuil en dollars, à niveau de SOXX constant.

### Ce que montre le rapport

- **Fiche action** — Deux graphiques, les indicateurs, les deux signaux
  et une consigne en français adaptée à l’action sélectionnée.
- **Comment le signal est calculé** — Les règles du score et du filtre
  d’entrée, avec les résultats détaillés des cinq actions.

Par exemple, au 31 décembre 2025, NVIDIA obtient 4/5 et un signal Achat,
mais le filtre d’entrée indique d’attendre un repli. Sa clôture est de
186,50 USD et son seuil d'entrée calculé est de 181,45 USD à SOXX constant.

## 2. Les données

<!-- Une ligne par source envisagée, comme dans ta fiche projet. -->

| Source | Type | Ce qu'elle apporte |
|---|---|---|
| Yahoo Finance — cours historiques : [AMD](https://finance.yahoo.com/quote/AMD/history/) et [SOXX](https://finance.yahoo.com/quote/SOXX/history/) | Site web | Cours ajustés d’AMD, NVIDIA, Intel, Broadcom et Marvell sur 2021–2025, avec l’ETF SOXX comme référence sectorielle. |
| [SEC EDGAR — 10-Q AMD](https://www.sec.gov/Archives/edgar/data/2488/0000002488-25-000166-index.html) | API | Comptes 10-K et 10-Q et dates de dépôt pour utiliser les chiffres déjà publiés |
| Référentiel des cinq actions | Table SQL via Python | Correspondance ISIN, ticker, place de cotation et identifiant SEC |

## 3. L'organisation du dépôt

<!-- Laisse cette liste telle quelle : elle décrit les dossiers créés au chapitre 3. -->
- `data/raw/` : les données brutes, telles que reçues, jamais modifiées
- `data/processed/` : les données nettoyées, prêtes pour l'analyse
- `notebooks/` : les notebooks Jupyter d'exploration et d'analyse
- `scripts/` : les scripts Python du projet
- `sql/` : les requêtes SQL
- `api/` : dossier réservé dans la structure du projet
- `dashboard/` : le rapport Power BI et ses captures d'écran
- `docs/` : la fiche projet et les documents du projet

## 4. L'avancement

<!-- Les étapes de ton projet. La première est faite. Tu cocheras les suivantes une fois le module terminé, quand tu appliqueras chaque méthode à ton projet : remplace alors [ ] par [x]. -->
- [x] Sujet choisi, dossiers créés, dépôt publié
- [x] Collecte des données
- [x] Requêtes SQL
- [x] Nettoyage et dataset final
- [x] Stockage en base
- [x] Collecte des comptes via API SEC EDGAR
- [x] Analyse et tableau de bord

---
Sophie Shams · Formation Data Analyst & IA · DataSuits
