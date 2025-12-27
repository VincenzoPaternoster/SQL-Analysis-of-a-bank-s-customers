/*

CALCULATE INDICATORS

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
