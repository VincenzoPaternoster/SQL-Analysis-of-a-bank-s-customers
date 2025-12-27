# 📌 SQL Analysis of a bank's customers
The aim of the project is to create a feature table for training machine learning models, enriching customer data with various indicators calculated from their transactions and accounts. 
The final table will refer to the customer ID and contain both quantitative and qualitative information.

---

## 📂 Repository Structure
```
SQL Analysis of a bank's customers/
  │── data/
      │── cliente.txt
      │── conto.txt
      │── tipo_conto.txt
      │── transazioni.txt
      │── tipo_transazione.txt
  │── images/
  │── SQL/
      │── SQL_Bank_Project.sql
  │__ README.md

```
## 🎯 Project objectives


#### 1. The main objective of the project is to create a feature table (denormalized table) for training machine learning models, enriching customer data with various indicators calculated from their transactions and accounts.

#### 2. Before obtaining the denormalised table, it will be necessary to calculate demographic and behavioural indicators,such as:

##### Basic indicator
###### a) Customer age

##### Transaction indicators
###### b) Number of outgoing transactions on all accounts
###### c) Number of incoming transactions on all accounts
###### d) Total amount transacted outgoing on all accounts
###### e) Total amount transacted incoming on all accounts

##### Account indicators
###### f) Total number of accounts held
###### g) Number of accounts held by type

##### Transaction indicators by account type
###### h) Number of outgoing transactions by account type
###### i) Number of incoming transactions by account type
###### l) Outgoing transaction amount by account type 
###### m) Incoming transaction amount by account type 

---

## 🗂️ Dataset
**Source:** Profession AI - Master in Data Analytics

**Period examined:** from 2019 to 2022  

**Dimension of dataset:** dataset_cliente=200 customers

**Dimension of dataset:** dataset_transazioni=14.685 transactions

**Dimension of dataset:** dataset_conto=240 accounts

### 📌 Key variables

##### CLIENTE
| Variables |Type |Description |
|-----------|-----|------------|
| id_cliente |int  |Customer identifier|
| nome  |text      |Customer name|
| cognome|text     |Customer surname|
| data_nascita|date|Customer birthday |

##### CONTO
| Variables |Type |Description |
|-----------|-----|------------|
| id_conto |int  |Account identifier|
| id_cliente |int  |Customer identifier|
| id_tipo_conto|int|Type of account|


##### TIPO CONTO
| Variables |Type |Description |
|-----------|-----|------------|
| id_tipo_conto|int| Type of account|
| desc_tipo_conto|text |Account description|

##### TRANSAZIONI
| Variables |Type |Description |
|-----------|-----|------------|
| data |date          |Date of transaction|
| id_tipo_tran|int  |Type of transaction|
| importo|real/float  |Transaction amount|
| id_conto|int        |Account identifier|


##### TIPO TRANSAZIONE
| Variables |Type |Description |
|-----------|-----|------------|
| id_tipo_tran|int  |Type of transaction|
| desc_tipo_trans|text        |Transaction description|
| segno|text        |Transaction symbol (+ or -)|

---


## 🧠 Conclusions
##### In this project, I learned how to use basic SQL commands and understood how to build a denormalised table (feature table) ready to be used for training machine learning models.
---

## 🛠️ Tools
- MySQL 
- XAMPP Control Panel
---

## 📬 Contacts

- **Vincenzo Paternoster**
- Email: vincenzopaternoster99@gmail.com
- LinkedIn: www.linkedin.com/in/vincenzo-paternoster
