# SmartParking Billing Engine 🚗🏢

![Java](https://img.shields.io/badge/Java-21-orange.svg)
![Tomcat](https://img.shields.io/badge/Apache_Tomcat-9.0-f8dc75.svg)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue.svg)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3-purple.svg)

A complete, modern **Java Servlet + JSP** web application that acts as a billing engine for a multi-level smart city parking system. It calculates parking fees based on duration, vehicle type, grace periods, daily caps, and lost ticket penalties, persisting all generated receipts in a MySQL database.

---

## ✨ Features

### ⚙️ Business Logic & Billing Rules
* **Grace Period:** First 15 minutes of parking are completely free.
* **Smart Rounding:** Every remaining partial hour is rounded UP to the next full hour.
* **Vehicle-based Rates:**
  * 🚗 Car: ₹40 / hour
  * 🏍️ Bike: ₹20 / hour
  * 🚙 SUV: ₹60 / hour
* **Daily Caps:** Maximum charge of ₹300 per completed 24-hour block for multi-day stays.
* **Lost Ticket Penalty:** A flat ₹500 fee is applied (ignoring duration).

### 🖥️ User Interface
* **Smart City Theme:** Modern UI using HTML5, CSS3, and Bootstrap 5 with glassmorphism effects and animated gradient buttons.
* **Dynamic Validation:** Client-side and server-side validation ensuring exit time cannot precede entry time.
* **Professional Receipt:** Generates a detailed breakdown of the bill including billable hours, rates, grace periods, and total amount, with a built-in print functionality.

---

## 🛠️ Technology Stack

* **Backend:** Java 21, Java Servlets (javax.servlet), JDBC
* **Frontend:** JSP, HTML5, CSS3, Bootstrap 5
* **Database:** MySQL 8.x
* **Build Tool:** Maven
* **Server:** Apache Tomcat 9
* **IDE:** Eclipse Enterprise Edition

---

## 📂 Project Structure

```text
SmartParking/
├── src/main/java/
│   ├── dao/
│   │   └── ParkingBillDAO.java       # Database operations
│   ├── model/
│   │   └── ParkingBill.java          # Encapsulates billing data
│   ├── servlet/
│   │   └── BillingServlet.java       # Handles form POST requests
│   └── util/
│       ├── BillingCalculator.java    # Core business logic
│       └── DBConnection.java         # JDBC MySQL connection manager
├── WebContent/
│   ├── css/
│   │   └── style.css                 # Custom Smart City styling
│   ├── WEB-INF/
│   │   └── web.xml                   # Deployment descriptor
│   ├── index.jsp                     # Input form & landing page
│   └── result.jsp                    # Professional receipt display
├── database.sql                      # SQL schema for setup
└── pom.xml                           # Maven dependencies & configuration
```

---

## 🚀 Getting Started

Follow these instructions to run the project on your local machine.

### 1. Database Setup
1. Ensure you have **MySQL** installed and running on `localhost:3306`.
2. Open your preferred SQL client (e.g., MySQL Workbench, DBeaver) or command line.
3. Execute the provided `database.sql` script to create the schema and table:
   ```sql
   SOURCE path/to/SmartParking/database.sql;
   ```
4. If your MySQL credentials are not `root` / `root`, update them in `src/main/java/util/DBConnection.java`.

### 2. IDE Setup (Eclipse)
1. Open **Eclipse Enterprise Edition**.
2. Go to `File -> Import -> Maven -> Existing Maven Projects`.
3. Select the `SmartParking` directory and click Finish.
4. Right-click the project -> `Maven -> Update Project` (Alt + F5) to download the MySQL Connector/J dependency.

### 3. Running the Application
1. Add an **Apache Tomcat 9** server to your Eclipse environment.
2. Right-click the `SmartParking` project -> `Run As -> Run on Server`.
3. Select your Tomcat 9 server and click Finish.
4. The application will automatically open in your browser at `http://localhost:8080/SmartParking/`.

---

## 📝 Usage Instructions
1. Enter your **Vehicle Number**.
2. Select your **Vehicle Type** from the dropdown.
3. Select the **Entry Date & Time** and **Exit Date & Time**.
4. (Optional) Check the **Lost Ticket** option if applicable.
5. Click **Calculate Bill**.
6. View the detailed receipt and optionally print it. The record is automatically saved to the MySQL database.

---
*This project is built for demonstration purposes as part of a Smart City Parking Management System.*
