<div align="center">

# 🅿️ SmartParking Billing Engine

### Smart City Parking Management System

![Java](https://img.shields.io/badge/Java-21-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![Servlet](https://img.shields.io/badge/Servlet-4.0-4A90D9?style=for-the-badge)
![JSP](https://img.shields.io/badge/JSP-2.3-007396?style=for-the-badge)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white)
![Tomcat](https://img.shields.io/badge/Tomcat-9.0-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black)
![Maven](https://img.shields.io/badge/Maven-3.9-C71A36?style=for-the-badge&logo=apachemaven&logoColor=white)

A full-stack **Java Servlet + JSP** web application that powers an automated billing engine for a multi-level smart city parking system. It computes parking fees based on duration, vehicle type, grace periods, daily caps, and lost ticket penalties — with persistent storage in MySQL.

---

</div>

## ✨ Features

| Feature | Description |
|:--------|:------------|
| ⏱️ **Grace Period** | First 15 minutes of parking are completely free |
| 🔄 **Smart Rounding** | Partial hours are always rounded UP to the next full hour |
| 🚗 **Vehicle-based Rates** | Car: ₹40/hr · Bike: ₹20/hr · SUV: ₹60/hr |
| 📅 **Daily Cap** | Maximum charge of ₹300 per completed 24-hour block |
| 🎫 **Lost Ticket** | Flat ₹500 penalty (duration is ignored) |
| 📊 **Multi-Day Stay** | Automatic per-day capping for extended parking |
| 🧾 **Professional Receipt** | Detailed breakdown with Print functionality |
| 💾 **Database Persistence** | All bills saved to MySQL via JDBC |
| ✅ **Input Validation** | Server-side and client-side validation |

---

## 🏗️ System Architecture

```mermaid
graph TB
    subgraph Client ["🖥️ Client (Browser)"]
        A["index.jsp<br/>Input Form"]
        B["result.jsp<br/>Receipt Display"]
    end

    subgraph Server ["⚙️ Apache Tomcat 9"]
        C["BillingServlet<br/>(Controller)"]
        D["BillingCalculator<br/>(Business Logic)"]
        E["ParkingBill<br/>(Model)"]
        F["ParkingBillDAO<br/>(Data Access)"]
        G["DBConnection<br/>(JDBC Manager)"]
    end

    subgraph Database ["🗄️ MySQL"]
        H["smart_parking_db<br/>parking_bills table"]
    end

    A -- "POST /calculateBill" --> C
    C -- "Validates & Builds" --> E
    C -- "Calls" --> D
    D -- "Computes Bill" --> E
    C -- "Saves via" --> F
    F -- "Uses" --> G
    G -- "JDBC" --> H
    C -- "Forwards bill" --> B

    style Client fill:#eff6ff,stroke:#3b82f6,stroke-width:2px
    style Server fill:#f0fdf4,stroke:#16a34a,stroke-width:2px
    style Database fill:#fefce8,stroke:#eab308,stroke-width:2px
```

---

## 📐 Class Diagram

```mermaid
classDiagram
    class ParkingBill {
        -String ownerName
        -String contactNumber
        -String vehicleNumber
        -String vehicleType
        -String slotNumber
        -LocalDateTime entryTime
        -LocalDateTime exitTime
        -long totalDurationMinutes
        -long billableHours
        -boolean graceApplied
        -double hourlyRate
        -double parkingFee
        -boolean lostTicket
        -boolean dailyCapApplied
        -double totalAmount
        +getOwnerName() String
        +setOwnerName(String) void
        +getContactNumber() String
        +setContactNumber(String) void
        +getVehicleNumber() String
        +setVehicleNumber(String) void
        +getVehicleType() String
        +setVehicleType(String) void
        +getSlotNumber() String
        +setSlotNumber(String) void
        +getEntryTime() LocalDateTime
        +setEntryTime(LocalDateTime) void
        +getExitTime() LocalDateTime
        +setExitTime(LocalDateTime) void
        +getTotalDurationMinutes() long
        +setTotalDurationMinutes(long) void
        +getBillableHours() long
        +setBillableHours(long) void
        +isGraceApplied() boolean
        +setGraceApplied(boolean) void
        +getHourlyRate() double
        +setHourlyRate(double) void
        +getParkingFee() double
        +setParkingFee(double) void
        +isLostTicket() boolean
        +setLostTicket(boolean) void
        +isDailyCapApplied() boolean
        +setDailyCapApplied(boolean) void
        +getTotalAmount() double
        +setTotalAmount(double) void
    }

    class BillingCalculator {
        -int GRACE_PERIOD_MINUTES$
        -double RATE_CAR$
        -double RATE_BIKE$
        -double RATE_SUV$
        -double DAILY_CAP$
        -double LOST_TICKET_PENALTY$
        +calculateBill(ParkingBill) ParkingBill$
        -getHourlyRate(String) double$
    }

    class BillingServlet {
        -long serialVersionUID
        +doPost(HttpServletRequest, HttpServletResponse) void
    }

    class ParkingBillDAO {
        +saveBill(ParkingBill) void
    }

    class DBConnection {
        -String URL$
        -String USER$
        -String PASSWORD$
        +getConnection() Connection$
    }

    class ParkingSlot {
        -int slotId
        -String slotNumber
        -String floorLevel
        -String vehicleType
        -boolean occupied
        -String vehicleNumber
        -String ownerName
        -String occupiedSince
        +getSlotId() int
        +setSlotId(int) void
        +getSlotNumber() String
        +setSlotNumber(String) void
        +getFloorLevel() String
        +setFloorLevel(String) void
        +getVehicleType() String
        +setVehicleType(String) void
        +isOccupied() boolean
        +setOccupied(boolean) void
        +getVehicleNumber() String
        +setVehicleNumber(String) void
        +getOwnerName() String
        +setOwnerName(String) void
        +getOccupiedSince() String
        +setOccupiedSince(String) void
    }

    class ParkingSlotDAO {
        +assignSlot(String, String, String) String
        +releaseSlot(String) void
        +getAllSlots() List~ParkingSlot~
        +getSlotCounts(String) int[]
    }

    class VehiclesServlet {
        -long serialVersionUID
        +doGet(HttpServletRequest, HttpServletResponse) void
    }

    class ReportsServlet {
        -long serialVersionUID
        +doGet(HttpServletRequest, HttpServletResponse) void
    }

    BillingServlet --> BillingCalculator : calls
    BillingServlet --> ParkingBill : creates
    BillingServlet --> ParkingBillDAO : uses
    BillingServlet --> ParkingSlotDAO : uses
    BillingCalculator --> ParkingBill : computes
    ParkingBillDAO --> DBConnection : gets connection
    ParkingBillDAO --> ParkingBill : persists
    ParkingSlotDAO --> DBConnection : gets connection
    ParkingSlotDAO --> ParkingSlot : manipulates
    VehiclesServlet --> ParkingSlotDAO : uses
    ReportsServlet --> ParkingBillDAO : uses

    style ParkingBill fill:#dbeafe,stroke:#2563eb,color:#000
    style BillingCalculator fill:#dcfce7,stroke:#16a34a,color:#000
    style BillingServlet fill:#fef3c7,stroke:#d97706,color:#000
    style VehiclesServlet fill:#fef3c7,stroke:#d97706,color:#000
    style ReportsServlet fill:#fef3c7,stroke:#d97706,color:#000
    style ParkingBillDAO fill:#fce7f3,stroke:#db2777,color:#000
    style ParkingSlotDAO fill:#fbcfe8,stroke:#ec4899,color:#000
    style DBConnection fill:#f3e8ff,stroke:#9333ea,color:#000
    style ParkingSlot fill:#e0e7ff,stroke:#4f46e5,color:#000
```

---

## 🔄 Application Flow

```mermaid
flowchart TD
    A([User Opens index.jsp]) --> B[Fill Vehicle Details]
    B --> C{Lost Ticket?}
    C -- Yes --> D[Disable Date/Time Fields]
    C -- No --> E[Enter Entry & Exit Date/Time]
    D --> F[Submit Form]
    E --> F

    F --> G["BillingServlet receives POST"]
    G --> H{Validate Input}
    H -- Invalid --> I[Set Error Message]
    I --> J[Forward back to index.jsp]
    H -- Valid --> K[Create ParkingBill Object]

    K --> L["BillingCalculator.calculateBill()"]

    L --> M{Lost Ticket?}
    M -- Yes --> N["Total = ₹500 Flat Penalty"]
    M -- No --> O{Duration ≤ 15 min?}
    O -- Yes --> P["Total = ₹0 (Grace Period)"]
    O -- No --> Q[Subtract 15 min Grace]
    Q --> R["Round UP to full hours"]
    R --> S["Apply Hourly Rate"]
    S --> T{Multi-Day?}
    T -- Yes --> U["Cap each 24hr block at ₹300"]
    T -- No --> V{Fee > ₹300?}
    V -- Yes --> W["Apply ₹300 Daily Cap"]
    V -- No --> X[Use Calculated Fee]

    N --> Y["ParkingBillDAO.saveBill()"]
    P --> Y
    U --> Y
    W --> Y
    X --> Y

    Y --> Z["Forward to result.jsp"]
    Z --> AA([Display Professional Receipt])

    style A fill:#eff6ff,stroke:#3b82f6,color:#000
    style AA fill:#f0fdf4,stroke:#16a34a,color:#000
    style N fill:#fef2f2,stroke:#ef4444,color:#000
    style P fill:#f0fdf4,stroke:#16a34a,color:#000
```

---

## 🗄️ Database Schema

```mermaid
erDiagram
    PARKING_BILLS {
        INT id PK "AUTO_INCREMENT"
        VARCHAR owner_name
        VARCHAR contact_number
        VARCHAR vehicle_number "NOT NULL"
        VARCHAR vehicle_type "NOT NULL"
        VARCHAR slot_number
        DATETIME entry_time
        DATETIME exit_time
        BIGINT total_duration_minutes
        BIGINT billable_hours
        BOOLEAN grace_applied
        DECIMAL hourly_rate
        DECIMAL parking_fee
        BOOLEAN lost_ticket
        BOOLEAN daily_cap_applied
        DECIMAL total_amount
        TIMESTAMP created_at "DEFAULT CURRENT_TIMESTAMP"
    }

    PARKING_SLOTS {
        INT slot_id PK "AUTO_INCREMENT"
        VARCHAR slot_number "NOT NULL UNIQUE"
        VARCHAR floor_level "NOT NULL"
        VARCHAR vehicle_type "NOT NULL"
        BOOLEAN is_occupied "DEFAULT FALSE"
        VARCHAR vehicle_number
        VARCHAR owner_name
        DATETIME occupied_since
    }

    PARKING_BILLS }o--o| PARKING_SLOTS : "occupies"
```

---

## 📂 Project Structure

```
SmartParking/
│
├── 📄 pom.xml                             # Maven config (Java 21, Servlet API, MySQL Connector)
├── 📄 database.sql                        # MySQL schema setup script
├── 📄 README.md
├── 📄 .gitignore
│
├── 📁 src/main/java/
│   ├── 📁 model/
│   │   └── 📄 ParkingBill.java            # POJO — encapsulates all billing data
│   ├── 📁 util/
│   │   ├── 📄 BillingCalculator.java      # Core business logic engine
│   │   └── 📄 DBConnection.java           # JDBC connection manager
│   ├── 📁 dao/
│   │   └── 📄 ParkingBillDAO.java         # Data Access Object for MySQL persistence
│   └── 📁 servlet/
│       └── 📄 BillingServlet.java         # Controller — handles form POST requests
│
└── 📁 WebContent/
    ├── 📄 index.jsp                        # Landing page with billing form
    ├── 📄 result.jsp                       # Professional receipt display
    ├── 📁 css/
    │   └── 📄 style.css                   # Custom Smart City theme
    └── 📁 WEB-INF/
        └── 📄 web.xml                     # Deployment descriptor
```

---

## 💰 Billing Rules Reference

```
┌─────────────────────────────────────────────────────────┐
│                   BILLING LOGIC                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Lost Ticket?                                           │
│  ├── YES → Charge flat ₹500. Ignore duration.           │
│  └── NO  → Continue ↓                                   │
│                                                         │
│  Duration ≤ 15 minutes?                                 │
│  ├── YES → Charge ₹0. Grace period applied.             │
│  └── NO  → Continue ↓                                   │
│                                                         │
│  Step 1: Subtract 15 min grace period                   │
│  Step 2: Convert remaining mins → hours (round UP)      │
│          Example: 61 min → 2 hrs, 121 min → 3 hrs       │
│  Step 3: Apply hourly rate                              │
│          Car=₹40  Bike=₹20  SUV=₹60                     │
│  Step 4: Apply daily cap (₹300 per 24hr block)          │
│                                                         │
│  Multi-Day Example (50 hours, Car):                     │
│  ├── 2 × 24hr blocks = 2 × ₹300 = ₹600                 │
│  ├── Remaining 2 hrs  = 2 × ₹40  = ₹80                  │
│  └── Total = ₹680                                       │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## 🛠️ Technology Stack

| Layer | Technology | Purpose |
|:------|:-----------|:--------|
| **Language** | Java 21 | Core application logic |
| **Web Framework** | Java Servlets (javax.servlet 4.0) | HTTP request handling |
| **View Engine** | JavaServer Pages (JSP) | Dynamic HTML rendering |
| **Frontend** | HTML5, CSS3, Bootstrap 5 | Responsive UI with modern design |
| **Icons** | Bootstrap Icons | Professional iconography |
| **Database** | MySQL 8.x | Persistent storage |
| **JDBC Driver** | MySQL Connector/J 8.3 | Java ↔ MySQL communication |
| **Build Tool** | Apache Maven | Dependency and build management |
| **Server** | Apache Tomcat 9 | Servlet container |
| **IDE** | Eclipse Enterprise Edition | Development environment |

---

## 🚀 Getting Started

### Prerequisites

- **Java 21** (JDK)
- **Apache Tomcat 9.x**
- **MySQL 8.x** (running on `localhost:3306`)
- **Eclipse Enterprise Edition** (recommended)
- **Maven 3.x**

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/KL2300030695/SmartParking.git
cd SmartParking
```

### 2️⃣ Setup the Database

Open MySQL Workbench (or any SQL client) and execute:

```sql
SOURCE /path/to/SmartParking/database.sql;
```

This creates the `smart_parking_db` database and `parking_bills` table.

> **Note:** If your MySQL credentials are different from `root` / `root`, update them in `src/main/java/util/DBConnection.java`.

### 3️⃣ Import into Eclipse

1. `File` → `Import` → `Maven` → `Existing Maven Projects`
2. Browse to the cloned `SmartParking` directory
3. Click `Finish`
4. Right-click project → `Maven` → `Update Project` (`Alt + F5`)

### 4️⃣ Configure Tomcat

1. `Window` → `Show View` → `Servers`
2. Click `No servers available. Click this link to create a new server...`
3. Select `Apache Tomcat v9.0` → Browse to your Tomcat directory → `Finish`

### 5️⃣ Run the Application

1. Right-click `SmartParking` → `Run As` → `Run on Server`
2. Select your Tomcat 9 server → `Finish`
3. Application opens at: **`http://localhost:8080/SmartParking/`**

---

## 🧪 Test Scenarios

| # | Scenario | Input | Expected Output |
|:-:|:---------|:------|:----------------|
| 1 | **Grace Period** | Duration = 10 min, Car | Total = ₹0.00 |
| 2 | **Exact Hour** | Duration = 60 min, Car | Total = ₹40.00 (1 hr after grace) |
| 3 | **Round Up** | Duration = 61 min, Car | Total = ₹80.00 (2 hrs after grace) |
| 4 | **Daily Cap** | Duration = 12 hrs, Car | Total = ₹300.00 (capped) |
| 5 | **Multi-Day** | Duration = 50 hrs, Car | Total = ₹680.00 (2×₹300 + 2×₹40) |
| 6 | **Lost Ticket** | Lost Ticket = Yes | Total = ₹500.00 |
| 7 | **Bike Rate** | Duration = 2 hrs, Bike | Total = ₹40.00 (2×₹20) |
| 8 | **SUV Rate** | Duration = 2 hrs, SUV | Total = ₹120.00 (2×₹60) |

---

## 📜 License

This project is built for academic and demonstration purposes as part of a **Smart City Parking Management System**.

---

<div align="center">

**Built with ❤️ using Java Servlets, JSP, and Bootstrap 5**

</div>
