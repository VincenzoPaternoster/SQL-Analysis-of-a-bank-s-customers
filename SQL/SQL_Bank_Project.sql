/*

SQL FINAL PROJECT

*/
SELECT * FROM banca.cliente;
SELECT * FROM banca.conto;
SELECT * FROM banca.tipo_conto;
SELECT * FROM banca.transazioni;
SELECT * FROM banca.tipo_transazione;


/* INDICATORS */

/* TRANSACTION TYPE INDICATORS*/

-- Total outflows from accounts
DROP TABLE banca.Tot_uscite;
CREATE TEMPORARY TABLE banca.Tot_uscite 
AS
SELECT id_conto,
COUNT(id_tipo_trans) AS Num_Uscite,
ROUND(SUM(importo),3) AS Totale_Uscite
FROM banca.transazioni
WHERE id_tipo_trans IN (3,4,5,6,7)
GROUP BY 1;

-- Total account revenue
DROP TABLE banca.Tot_entrate;
CREATE TEMPORARY TABLE banca.Tot_entrate 
AS
SELECT id_conto,
COUNT(id_tipo_trans) AS Num_Entrate,
ROUND(SUM(importo),3) AS Totale_Entrate
FROM banca.transazioni
WHERE id_tipo_trans IN (0,1,2)
GROUP BY 1;

/* ACCOUNT INDICATORS*/
-- Number of accounts held
-- Number of type of accounts held

DROP TABLE banca.Tot_conti;
CREATE TEMPORARY TABLE banca.Tot_conti 
AS
SELECT id_cliente,
COUNT(id_conto) AS Num_conti,
COUNT(DISTINCT id_tipo_conto) AS Num_tipo_conti
FROM banca.conto
GROUP BY 1;


/* TRANSACTION INDICATORS BY ACCOUNT TYPE*/

-- Number of outgoing transactions by account type
DROP TABLE banca.Tot_tipo_uscite;
CREATE TEMPORARY TABLE banca.Tot_tipo_uscite 
AS
SELECT id_tipo_conto,
COUNT(*) AS Numero_uscite
FROM banca.transazioni
INNER JOIN banca.conto
ON transazioni.id_conto=conto.id_conto
WHERE id_tipo_trans IN (3,4,5,6,7)
GROUP BY 1;


-- Number of incoming transactions by account type
DROP TABLE banca.Tot_tipo_entrate;
CREATE TEMPORARY TABLE banca.Tot_tipo_entrate 
AS
SELECT id_tipo_conto,
COUNT(*) AS Numero_entrate
FROM banca.transazioni
INNER JOIN banca.conto
ON transazioni.id_conto=conto.id_conto
WHERE id_tipo_trans IN (0,1,2)
GROUP BY 1;

-- Total outgoing amount by account type
DROP TABLE banca.Imp_uscite;
CREATE TEMPORARY TABLE banca.Imp_uscite 
AS
SELECT id_tipo_conto,
ROUND(SUM(importo),3) AS Tot_Imp_Uscite
FROM banca.transazioni
INNER JOIN banca.conto
ON transazioni.id_conto=conto.id_conto
WHERE importo<0
GROUP BY 1;



-- Total incoming amount by account type
DROP TABLE banca.Imp_entrate;
CREATE TEMPORARY TABLE banca.Imp_entrate 
AS
SELECT id_tipo_conto,
ROUND(SUM(importo),3) AS Tot_Imp_Entrate
FROM banca.transazioni
INNER JOIN banca.conto
ON transazioni.id_conto=conto.id_conto
WHERE importo>0
GROUP BY 1;


-- Create first join table
CREATE TABLE banca.first_join_table
AS
SELECT 
	cliente.id_cliente,
	nome,
    cognome,
	data_nascita,
	TIMESTAMPDIFF(YEAR, data_nascita, CURDATE()) AS Eta,
    conto.id_conto,
    conto.id_tipo_conto,
    Num_conti,
    Num_tipo_conti,
    Num_Uscite,
    Totale_Uscite,
    Num_Entrate,
    Totale_Entrate
FROM banca.cliente
LEFT JOIN banca.conto ON cliente.id_cliente=conto.id_cliente
LEFT JOIN banca.Tot_conti ON cliente.id_cliente=Tot_conti.id_cliente
LEFT JOIN banca.Tot_uscite ON conto.id_conto=Tot_uscite.id_conto
LEFT JOIN banca.Tot_entrate ON conto.id_conto=Tot_entrate.id_conto
;

-- Ceate the semi-final table with the features to use for ML
CREATE TABLE banca.table_features
AS
SELECT 
	id_cliente,
    nome,
    cognome,
    data_nascita,
    TIMESTAMPDIFF(YEAR, data_nascita, CURDATE()) AS Eta,
COUNT(DISTINCT id_conto) AS Num_conti_ft,
COUNT(DISTINCT id_tipo_conto) AS Num_tipo_conti_ft,
SUM(Num_Uscite) AS Num_Uscite_ft,
SUM(Num_Entrate) AS Num_Entrate_ft,
SUM(Totale_Uscite) AS Tot_Uscite_ft,
SUM(Totale_Entrate) AS Tot_Entrate_ft 
FROM banca.first_join_table
GROUP BY 1,2,3,4,5;


-- Create table to join semi-final table with table containing information about account types
DROP TABLE banca.clien_tipo_cont;
CREATE TEMPORARY TABLE banca.clien_tipo_cont
AS
SELECT DISTINCT
	id_cliente,
    id_conto,
    id_tipo_conto
FROM banca.conto;


-- Calculate the amount and total incoming and outgoing for each account type and for each customer
DROP TABLE banca.final_clien_cont;
CREATE TEMPORARY TABLE banca.final_clien_cont
SELECT 
	id_cliente,
    COUNT(CASE WHEN id_tipo_conto=0 AND id_tipo_trans IN (0,1,2) THEN 1 END) AS Num_Ent_Cont0,
    COUNT(CASE WHEN id_tipo_conto=1 AND id_tipo_trans IN (0,1,2) THEN 1 END) AS Num_Ent_Cont1,
    COUNT(CASE WHEN id_tipo_conto=2 AND id_tipo_trans IN (0,1,2) THEN 1 END) AS Num_Ent_Cont2,
    COUNT(CASE WHEN id_tipo_conto=3 AND id_tipo_trans IN (0,1,2) THEN 1 END) AS Num_Ent_Cont3,
    COUNT(CASE WHEN id_tipo_conto=0 AND id_tipo_trans IN (3,4,5,6,7) THEN 1 END) AS Num_Usc_Cont0,
    COUNT(CASE WHEN id_tipo_conto=1 AND id_tipo_trans IN (3,4,5,6,7) THEN 1 END) AS Num_Usc_Cont1,
    COUNT(CASE WHEN id_tipo_conto=2 AND id_tipo_trans IN (3,4,5,6,7) THEN 1 END) AS Num_Usc_Cont2,
    COUNT(CASE WHEN id_tipo_conto=3 AND id_tipo_trans IN (3,4,5,6,7) THEN 1 END) AS Num_Usc_Cont3,

    ROUND(SUM(CASE WHEN id_tipo_conto=0 AND id_tipo_trans IN (0,1,2) THEN importo ELSE 0 END),3)AS 	 Imp_Ent_Cont0,
    ROUND(SUM(CASE WHEN id_tipo_conto=1 AND id_tipo_trans IN (0,1,2) THEN importo ELSE 0 END ),3) AS Imp_Ent_Cont1,
    ROUND(SUM(CASE WHEN id_tipo_conto=2 AND id_tipo_trans IN (0,1,2) THEN importo ELSE 0 END),3) AS  Imp_Ent_Cont2,
    ROUND(SUM(CASE WHEN id_tipo_conto=3 AND id_tipo_trans IN (0,1,2) THEN importo ELSE 0 END),3) AS  Imp_Ent_Cont3,
    ROUND(SUM(CASE WHEN id_tipo_conto=0 AND id_tipo_trans IN (3,4,5,6,7) THEN importo ELSE 0 END),3) AS Imp_Usc_Cont0,
    ROUND(SUM(CASE WHEN id_tipo_conto=1 AND id_tipo_trans IN (3,4,5,6,7) THEN importo ELSE 0 END),3) AS Imp_Usc_Cont1,
    ROUND(SUM(CASE WHEN id_tipo_conto=2 AND id_tipo_trans IN (3,4,5,6,7) THEN importo ELSE 0 END),3) AS Imp_Usc_Cont2,
    ROUND(SUM(CASE WHEN id_tipo_conto=3 AND id_tipo_trans IN (3,4,5,6,7) THEN importo ELSE 0 END),3) AS Imp_Usc_Cont3
    
FROM banca.clien_tipo_cont
LEFT JOIN banca.transazioni
ON clien_tipo_cont.id_conto=transazioni.id_conto
GROUP BY 1;
 
-- Final Join
CREATE TABLE banca.ultimate_table
AS
SELECT 
	table_features.id_cliente,
    nome,
    cognome,
    data_nascita,
    TIMESTAMPDIFF(YEAR, data_nascita, CURDATE()) AS Eta,
    Num_conti_ft,
    Num_tipo_conti_ft,
	Num_Uscite_ft,
	Num_Entrate_ft,
	Tot_Uscite_ft,
	Tot_Entrate_ft, 
    Num_Ent_Cont0,
    Num_Ent_Cont1,
    Num_Ent_Cont2,
    Num_Ent_Cont3,
    Imp_Ent_Cont0,
    Imp_Ent_Cont1,
    Imp_Ent_Cont2,
    Imp_Ent_Cont3,
    Num_Usc_Cont0,
    Num_Usc_Cont1,
    Num_Usc_Cont2,
    Num_Usc_Cont3,
    Imp_Usc_Cont0,
    Imp_Usc_Cont1,
    Imp_Usc_Cont2,
    Imp_Usc_Cont3
    
FROM banca.table_features
LEFT JOIN banca.final_clien_cont
ON table_features.id_cliente=final_clien_cont.id_cliente;
