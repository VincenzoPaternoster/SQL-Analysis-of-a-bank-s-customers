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



## 🧹 Data Cleaning
Key operations performed:
- Handling missing values
- Format correction (dates format)
- Data preprocessing (e.g. Remove punctuation, remove stopwords, tokenizzation, vectorizzation)
---

## 📊 Methodology:
- Used techniques (Nltk,N-gram, NER, Logistic Regression, Multilayer Perceptron)
- Main libraries (Pandas,Sklearn,Spacy,Matplotlib,Seaborn,Gensim)

---

## 🔍 Key results
- **Insight 1**: The categories of news with the most fake news concern ‘News’, “Politics” and ‘Left-news’ [Box chart](https://github.com/VincenzoPaternoster/NLP-Detection-of-Fake-News/blob/main/images/Insights%20on%20fake%20news/MostFakeCategories.png)
- **Insight 2**: The topics with the highest number of fake news stories are ‘Donald Trump’, ‘Hilary Clinton’, ‘White House’ and ‘United States’, in line with the period (from 2015 to 2018) in which the news was collected, i.e. pre, during and post US elections [Box chart](https://github.com/VincenzoPaternoster/NLP-Detection-of-Fake-News/blob/main/images/Insights%20on%20fake%20news/MostUsedTopics.png) and [Word cloud](https://github.com/VincenzoPaternoster/NLP-Detection-of-Fake-News/blob/main/images/Insights%20on%20fake%20news/WordCloud.png)
- **Insight 3**: News headlines have recognisable and repetitive patterns that include the use of names of people (PERSON), organisations (ORG) and nationalities/political groups (NORP). In fact, the main elements contained in fake news headlines are “Donald Trump”, “President Trump”, “Hilary Clinton”, “White House” and “Fox News” [Box chart](https://github.com/VincenzoPaternoster/NLP-Detection-of-Fake-News/blob/main/images/Insights%20on%20fake%20news/MostFrequentBi.png) and [Box chart with NER entities](https://github.com/VincenzoPaternoster/NLP-Detection-of-Fake-News/blob/main/images/Insights%20on%20fake%20news/NER_MostHead.png)
- **Insight 4**: Finally, two models (Logistic regression and Multi Perceptron, MLP) were trained and tested with the aim of creating a browser plug-in capable of filtering fake news. The analyses and results showed that the MLP model was better able to predict fake news than the Logistic regression model [Comparison between models](https://github.com/VincenzoPaternoster/NLP-Detection-of-Fake-News/blob/main/images/Training%20model/CombinedConfusion.png)


---

## 🧠 Conclusions
##### In this project I learned how to use spacy, nltk (n-gram), gensim (simple_preprocess) and sklearn (MLP,Logistic regression,Vectorizer, train_test_split, classification report, confusion matrix) in order to execute operations of natural language processing mixed with machine learning tecniques such as logistic regression and multilayer perceptron (MLP).
---

## 🛠️ Tools
- Python (pandas,matplotlib,seaborn,sklearn,gensim)
- Google Colab
- Obsidian

---

## 📬 Contacts

- **Vincenzo Paternoster**
- Email: vincenzopaternoster99@gmail.com
- LinkedIn: www.linkedin.com/in/vincenzo-paternoster
