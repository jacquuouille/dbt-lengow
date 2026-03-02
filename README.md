# 📊 Custom Pricing Competitiveness Dashboard

The goal of this project is to **design the end-to-end solution to a client**, from data extraction to dashboard creation. The final output will allow the client to self-serve answers to recurring questions about how
their prices compare to competitors in the market.

![Lineage](screenshots/lineage.png)
  
## ⚙️ Exploring Lineage

```sql
dbt docs generate
dbt docs serve
```

### The documentation interface allows you to:
- Visualize data lineage (upstream sources and downstream dependencies)
- Explore model relationships
- Access column-level metadata and descriptions
- Review tests and data quality checks
- Understand business logic implemented in each model

### In particular, the Data Model section provides a clear overview of:
- The list of analytical tables and views 
- Their business purpose and intended use
- Key metrics and transformations applied
- This ensures full transparency of the transformation layer and makes it easy for stakeholders and analysts to understand how data is structured and how each model should be used.

## 📈 Exploring Dashboard
The dashboard is built on external data provided by the client. Please coordinate with the team regarding data cleaning and preparation.

Explore the dashboard [here](https://lookerstudio.google.com/u/0/reporting/58cda53a-5e0b-46b9-91b5-b6b104ca021d/page/p_79kqjm8d1d) (additional pages available):
- 📊 Overview
- 🛒 Products
- 🛍️ Competitor Domains
- 📚 Glossary


<p align="center">
  <img src="screenshots/page_2_dash.png" width="45%" />
  &nbsp;&nbsp;
  <img src="screenshots/page_1_dash.png" width="45%" />
</p>


