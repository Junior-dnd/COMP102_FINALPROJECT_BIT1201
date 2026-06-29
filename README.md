# 🏪 Market Stall Allocation Database System

> A relational database system designed to improve the management of market stalls within local councils in Sierra Leone, implemented using **MySQL**.

## 📌 Project Overview

Markets play a significant role in Sierra Leone's economy by providing opportunities for small-scale traders, retailers, and entrepreneurs. This project replaces traditional, paper-based market management with a computerized **relational database solution**.

### Problem Statement
Manual market stall management suffers from:
- Data loss, duplication, and misplacement of paper records
- Difficulty tracking stall occupancy, trader information, and payments
- Poor transparency and accountability in market administration
- High time and effort required to update records and generate reports

### Solution
A fully implemented **MySQL relational database** that manages:
- Trader registration and stall allocation
- Payment tracking and financial reporting
- Council staff assignment and accountability
- Buyer transaction records

---

## 🌍 SDG Alignment

This project supports **UN Sustainable Development Goal 11 — Sustainable Cities and Communities**.

| SDG 11 Target | How This System Contributes |
|---------------|----------------------------|
| Organized urban development | Efficient stall allocation reduces informal, unregulated market sprawl |
| Improved public services | Digital records enable faster, more accurate council administration |
| Transparency & accountability | Payment and allocation records build trust between traders and government |
| Inclusive economic growth | Reliable allocation data supports stable trader livelihoods |

---

## 🗃️ Database Design

This project is a continuation of **Assignment 1**, where the Conceptual Data Model (CDM), Logical Data Model (LDM), and Physical Data Model (PDM) were developed. In this phase, the physical model is **refined and implemented** in MySQL.

### Refinements Made
| Area | Change | Reason |
|------|--------|--------|
| Trader Age attribute | Changed from `AGE` → `INT` | Standard MySQL data type for numeric values |
| Market Capacity attribute | Changed from `VARCHAR` → `INT` | Enables numeric comparisons and calculations |
| Foreign key constraints | Strengthened across all tables | Enforces referential integrity |
| Stall Status | Added default value `'Available'` | Reduces data entry errors |

---

## 🗂️ Entities & Tables

The database consists of **8 entities**:

### 1. `CouncilStaff`
Stores information about council employees responsible for market administration.

| Column | Data Type | Constraint |
|--------|-----------|------------|
| CouncilStaffID | INT | PRIMARY KEY |
| FullName | VARCHAR | NOT NULL |
| Role | VARCHAR | NOT NULL |
| Contact | VARCHAR | |

---

### 2. `Market`
Stores information about markets managed by local councils.

| Column | Data Type | Constraint |
|--------|-----------|------------|
| MarketID | INT | PRIMARY KEY |
| MarketName | VARCHAR | NOT NULL |
| Location | VARCHAR | NOT NULL |
| Capacity | INT | |

---

### 3. `Stall`
Stores information about individual market stalls.

| Column | Data Type | Constraint |
|--------|-----------|------------|
| StallID | INT | PRIMARY KEY |
| MarketID | INT | FOREIGN KEY → Market |
| Size | VARCHAR | |
| Status | VARCHAR | DEFAULT 'Available' |

---

### 4. `Trader`
Stores information about registered traders operating within markets.

| Column | Data Type | Constraint |
|--------|-----------|------------|
| TraderID | INT | PRIMARY KEY |
| FullName | VARCHAR | NOT NULL |
| Contact | VARCHAR | |
| Age | INT | |
| Address | VARCHAR | |
| Gender | VARCHAR | |
| RegistrationDate | DATE | |
| GoodsSold | VARCHAR | |

---

### 5. `Buyer`
Stores information about customers purchasing goods within the market.

| Column | Data Type | Constraint |
|--------|-----------|------------|
| BuyerID | INT | PRIMARY KEY |
| FullName | VARCHAR | NOT NULL |
| Contact | VARCHAR | |
| Address | VARCHAR | |
| GoodsBought | VARCHAR | |

---

### 6. `Allocation`
Records stall assignments made to traders by council staff.

| Column | Data Type | Constraint |
|--------|-----------|------------|
| AllocationID | INT | PRIMARY KEY |
| CouncilStaffID | INT | FOREIGN KEY → CouncilStaff |
| TraderID | INT | FOREIGN KEY → Trader |
| StallID | INT | FOREIGN KEY → Stall |
| AllocationDate | DATE | |
| ExpiryDate | DATE | |

---

### 7. `Payment`
Stores payment transactions associated with market activities.

| Column | Data Type | Constraint |
|--------|-----------|------------|
| PaymentID | INT | PRIMARY KEY |
| BuyerID | INT | FOREIGN KEY → Buyer |
| Amount | DECIMAL | NOT NULL |
| PaymentDate | DATE | |
| Method | VARCHAR | |

---

### 8. `AllocationPayment`
Bridge table linking allocations and payments (resolves many-to-many).

| Column | Data Type | Constraint |
|--------|-----------|------------|
| AllocationID | INT | FOREIGN KEY → Allocation |
| PaymentID | INT | FOREIGN KEY → Payment |

---

## 🔗 Relationships

```
Market          ──< Stall              (One-to-Many)
CouncilStaff    ──< Allocation         (One-to-Many)
Trader          ──< Allocation         (One-to-Many)
Stall           ──< Allocation         (One-to-Many)
Buyer           ──< Payment            (One-to-Many)
Allocation >──< Payment  via AllocationPayment  (Many-to-Many)
```

---

## 🔧 Key Design Decisions

- **Primary Keys** — Every table has a unique identifier to prevent duplicate records and simplify retrieval.
- **Foreign Keys** — Cross-table relationships enforced to prevent orphan records and maintain referential integrity.
- **DECIMAL for Amount** — Ensures accurate financial calculations without floating-point errors.
- **DATE type** — Used for `AllocationDate`, `ExpiryDate`, and `PaymentDate` to enable timeline tracking.
- **Default Values** — `Status` in the `Stall` table defaults to `'Available'` so new stalls are immediately usable.
- **Normalization** — `Buyer` is kept separate from `Trader` to avoid duplication and improve data integrity.
- **Bridge Table** — `AllocationPayment` resolves the many-to-many relationship between `Allocation` and `Payment`.

---

## 💻 SQL Operations

The following SQL operations were implemented and tested:

| Operation | Description |
|-----------|-------------|
| `CREATE DATABASE` | Created the `Market_Stall_Allocation_System` database |
| `CREATE TABLE` | Built all 8 tables with constraints and relationships |
| `INSERT` | Added sample trader, stall, allocation, and payment records |
| `UPDATE` | Modified existing trader and stall records |
| `DELETE` | Removed obsolete or test records |
| `SELECT` | Retrieved data from single and multiple tables |
| `WHERE` | Filtered records by specified conditions |
| `ORDER BY` | Sorted records (e.g., payments by amount) |
| `SUM / COUNT / AVG / MAX / MIN` | Generated summary reports via aggregate functions |
| `LIMIT` | Restricted result sets for efficient querying |

---

## ⚙️ Setup & Installation

### Prerequisites
- [MySQL Server](https://dev.mysql.com/downloads/mysql/) (version 5.7 or higher)
- [MySQL Workbench](https://dev.mysql.com/downloads/workbench/) or any MySQL client

### Steps

1. **Clone or download this project**
   ```bash
   git clone https://github.com/your-username/market-stall-allocation.git
   cd market-stall-allocation
   ```

2. **Open your MySQL client and run the setup script**
   ```sql
   SOURCE setup.sql;
   ```
   Or manually:
   ```sql
   CREATE DATABASE Market_Stall_Allocation_System;
   USE Market_Stall_Allocation_System;
   ```

3. **Create tables** by running the table creation script:
   ```sql
   SOURCE create_tables.sql;
   ```

4. **Insert sample data**:
   ```sql
   SOURCE sample_data.sql;
   ```

5. **Run queries** to test the system:
   ```sql
   SOURCE queries.sql;
   ```

---

## 📖 Usage

### Example Queries

**View all available stalls:**
```sql
SELECT * FROM Stall WHERE Status = 'Available';
```

**List all active allocations with trader names:**
```sql
SELECT a.AllocationID, t.FullName AS Trader, s.StallID, a.AllocationDate, a.ExpiryDate
FROM Allocation a
JOIN Trader t ON a.TraderID = t.TraderID
JOIN Stall s ON a.StallID = s.StallID;
```

**Total payments collected:**
```sql
SELECT SUM(Amount) AS TotalRevenue FROM Payment;
```

**Count traders per market:**
```sql
SELECT m.MarketName, COUNT(a.TraderID) AS TotalTraders
FROM Market m
JOIN Stall s ON m.MarketID = s.MarketID
JOIN Allocation a ON s.StallID = a.StallID
GROUP BY m.MarketName;
```

---

## 👥 Authors
OSMAN JUNIOR KAMARA
PRECIOUS AMINATRA SANDY
ALPHA C.K ALLIEU


---

*Built with MySQL · Aligned with SDG 11 · Limkokwing University, Sierra Leone*
