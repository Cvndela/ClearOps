![ClearOps](https://img.shields.io/badge/Event%20Market%20Risk%20Simulation-E?style=for-the-badge&logo=soundcharts&logoColor=white&logoSize=auto&label=ClearOps&labelColor=801100&color=B62203)
![Python](https://img.shields.io/badge/Python-Data%20Generator-0D1117?style=for-the-badge&logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-PostgreSQL-0D1117?style=for-the-badge&logo=postgresql&logoColor=white)

# ClearOps  
## Event-Based Market Clearing & Operational Risk Simulation

ClearOps is an exchange-inspired simulation designed to model the core workflows used in real derivatives and event-based markets.  
This project replicates the fundamental components of a clearing and risk operations engine—trade ingestion, exposure aggregation, settlement logic, and anomaly detection—similar to processes used at CFTC-regulated exchanges.

ClearOps demonstrates strong applied knowledge in:
- Market operations & clearing workflows  
- Risk exposure monitoring  
- SQL-driven surveillance  
- Data quality and reconciliation  
- Incident investigation & RCA reporting  
- Operational risk controls  
- Exchange-style compliance thinking  

---

## Project Purpose

ClearOps was created to simulate and understand real operational challenges faced by exchanges such as Kalshi, CME, CBOE, and clearing firms handling high-volume event trading.

The goal is to show:
- How a clearing engine detects inconsistencies  
- How exposure is maintained across users  
- How anomalies emerge in real market pipelines  
- How operational risk controls catch the issues  
- How RCAs are formally written and escalated  

This project reflects responsibilities performed in roles like:
- Operations Risk Analyst  
- Market Operations Analyst  
- Clearing Analyst  
- Compliance Analyst  
- Data Quality Analyst  

---

## Core Components

### 1. Synthetic Market Data Generation
A Python script creates:
- 10 event markets (YES/NO structured)
- 300 users  
- ~2,500 trades with randomized direction, price, timestamps, and quantities  

The generator intentionally avoids corrupting critical fields.  
All anomalies found later are created through operational logic, not random noise.

---

### 2. Exchange-Style PostgreSQL Schema

The database includes core tables reflecting real clearing systems:

| Table             | Purpose                                  |
|-------------------|-------------------------------------------|
| `markets`         | Market metadata, outcomes, expiration     |
| `users`           | Exchange user registry                    |
| `trades`          | Raw execution data                        |
| `positions`       | YES/NO exposure computed per user/market  |
| `risk_exceptions` | Centralized anomaly store                 |

---

### 3. Position Aggregation & Netting

A SQL script calculates user exposures:

- YES position  
- NO position  
- Net directional exposure  

This enables downstream surveillance checks such as:
- Directional conflicts  
- Large concentrations  
- Exposure vs outcome mismatches  

The final dataset contains **3,000 positions** across 300 users.

---

## Automated Risk Checks (SQL Surveillance)

ClearOps includes operational controls similar to those used by exchanges.

### Implemented Surveillance Checks
- **Duplicate trades** — 9 detected  
- **Invalid prices** outside the 0–1 range — 18 detected  
- **Conflicting positions** (YES+NO above threshold) — 33 detected  
- **Settlement mismatches** after outcome finalization — 3 detected  
- **Timestamp sequencing irregularities** — 399 detected  

All anomalies populate the centralized `risk_exceptions` table.

---

## Incident Reports (RCAs)

Three full RCA documents are included under `/reports/`.  
Each follows industry-standard operational risk structure:

- Executive Summary  
- Issue Description  
- Impact Analysis  
- Root Cause  
- Contributing Factors  
- Corrective Actions  
- Preventive Controls  

### Incident Reports
- [RCA #1 – Timestamp Sequencing Irregularities](reports/RCA_1_Timestamp_Sequencing.md)  
- [RCA #2 – Conflicting Positions](reports/RCA_2_Conflicting_Positions.md)  
- [RCA #3 – Settlement Mismatch](reports/RCA_3_Settlement_Mismatch.md)  

---

## Exposure & Dashboard-Ready Metrics  
*(Planned Enhancements)*

- Total open interest  
- User-level exposure heatmaps  
- Market-level liquidity  
- Concentration risk distribution  
- Anomaly density over time  
- Trade frequency variance  

These will be generated using SQL views designed for BI dashboards.

---

## How to Run ClearOps

```sql
-- 1. Load the database schema
\i schema.sql

-- 2. Import synthetic data
\i seed_data.sql

-- 3. Compute user positions
\i compute_positions.sql

-- 4. Inject operational anomalies (optional)
\i anomaly_injection.sql

-- 5. Run all risk checks
\i risk_checks/conflicting_positions.sql
\i risk_checks/invalid_price.sql
\i risk_checks/duplicate_trades.sql
\i risk_checks/timestamp_out_of_order.sql
\i risk_checks/settlement_mismatch.sql

-- 6. Review anomalies
SELECT * FROM risk_exceptions;
```
## Why This Project Matters
ClearOps demonstrates strong understanding of:
- How real exchanges detect and respond to operational issues
- How clearing engines compute user-level exposure
- How anomalies emerge from sequencing, settlement, price boundaries
- How structured RCAs are written for compliance & risk
- How SQL serves as the backbone of clearing oversight
- How operational risk connects technical + regulatory workflows

This is a practical, hands-on simulation of the exact challenges faced by risk operations, compliance, and clearing analysts.


**Future Enhancements**
- Margin modeling
- User-level risk scoring
- Real-time anomaly dashboard
- Market microstructure simulations
- Multi-market correlation checks
- Rest API ingestion mock layer

## **License**
This project is for educational and professional demonstration purposes.
