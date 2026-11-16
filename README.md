<!--
  MODÈLE DE README — Pipeline Data, séquence 1, chapitre 5
  Les blocs comme celui-ci sont des consignes : GitHub ne les affiche pas.
  Remplace chaque [crochet] par ton texte, puis supprime les crochets.
  Repères Markdown : une ligne qui commence par # est un titre ; une ligne qui commence par - est une puce.
-->

# Select Equity - Analyse financière des actions par ISIN

<!-- Une phrase qui dit ce que fait ton projet. Exemple : « Prévoir la production de 6 boulangeries selon la météo pour réduire les invendus. » -->
Tableau de bord Power BI permettant d'analyser et de comparer les performances financières et boursières d'entreprises à partir de leur code ISIN, avec une première version consacrée aux semi-conducteurs.

## 1. Le problème

<!-- Reprends ta fiche projet : le contexte en 2 ou 3 phrases, la question centrale, l'utilisateur. -->
- **Contexte** : L'analyse d'actions cotées nécessite de rassembler des données financières et boursières provenant de différentes sources. Leur comparaison peut être complexe. Ce projet vise à centraliser ces informations dans un tableau de bord interactif Power BI, en commençant par le secteur des semi-conducteurs.
- **Question centrale** : Comment faciliter l'analyse et la comparaison d'actions cotées à partir de leur code ISIN, afin d'aider à la prise de décision financière ?
- **Utilisateur** : Investisseurs particuliers et analystes financiers souhaitant comparer des entreprises cotées et mieux comprendre leurs performances financières et boursières.

## 2. Les données

<!-- Une ligne par source envisagée, comme dans ta fiche projet. -->

| Source | Type | Ce qu'elle apporte |
|---|---|---|
| Yahoo Finance | Site web | Cours ajustés des cinq actions et de SOXX |
| SEC EDGAR | API | Comptes 10-K et 10-Q et dates de dépôt pour utiliser les chiffres déjà publiés |
| Référentiel des cinq actions | Table SQL via Python | Correspondance ISIN, ticker, place de cotation et identifiant SEC |

## 3. L'organisation du dépôt

<!-- Laisse cette liste telle quelle : elle décrit les dossiers créés au chapitre 3. -->
- `data/raw/` : les données brutes, telles que reçues, jamais modifiées
- `data/processed/` : les données nettoyées, prêtes pour l'analyse
- `notebooks/` : les notebooks Jupyter d'exploration et d'analyse
- `scripts/` : les scripts Python du projet
- `sql/` : les requêtes SQL
- `api/` : l'API du projet
- `dashboard/` : le rapport Power BI et ses captures d'écran
- `docs/` : la fiche projet et les documents du projet

## 4. L'avancement

<!-- Les étapes de ton projet. La première est faite. Tu cocheras les suivantes une fois le module terminé, quand tu appliqueras chaque méthode à ton projet : remplace alors [ ] par [x]. -->
- [x] Sujet choisi, dossiers créés, dépôt publié
- [ ] Collecte des données
- [ ] Requêtes SQL
- [ ] Nettoyage et dataset final
- [ ] Stockage en base
- [ ] API
- [ ] Analyse et tableau de bord

---
Sophie Shams · Formation Data Analyst & IA · DataSuits
