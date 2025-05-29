# Travel Agency System
![travel agency system](https://github.com/GAYATRI-SIVANI-SUSARLA/Relational_Database_System/blob/main/photos/Screenshot%202025-05-29%20131152.png)
## Project Overview
This course project is focused on designing and implementing a relational database system that
models real-world data and supports common transaction operations. Used a relational
database system PostgreSQL to create database. Designed user interface and transaction handling implemented Python.
## Objective 
- Purpose: Create a user-friendly system for managing travel bookings (flights, cruises, accommodations) and payments in the travel and tourism domain.
- PostgreSQL Focus: Built a robust database with 11 tables, each populated with 50+ synthetic records, ensuring data integrity and supporting complex analytics.
- Queries: Executed 10 SQL queries to extract insights, like top-rated reviews, popular routes, and payment trends.
- Python Tkinter: Developed a basic interface using Tkinter and psycopg2 to connect to PostgreSQL, enabling users to book trips, select options, pay, and leave reviews.
![postgre sql](https://github.com/GAYATRI-SIVANI-SUSARLA/Relational_Database_System/blob/main/photos/Screenshot%202025-05-29%20130720.png)

### Relational Entities
- TRAVEL_LOCATION (PK: LOC_ID, Attributes: CITY, LOC_STATE, COUNTRY)
- PASSENGER (PK: PASS_ID, Attributes: PASS_NAME, GENDER, AGE)
- TRAVEL_GROUP (PK: GRP_ID, FK: PASS_ID, SOURCE_ID, DEST_ID)
- ACCOMMODATION (PK: ACC_ID, Attributes: ACC_TYPE, RATE, FACILITIES, DISCOUNT)
- EMPLOYEE (PK: ACC_ID, EMP_ID, FK: ACC_ID, SUP_ID)
- PAYMENT (PK: PAY_ID, PASS_ID, FK: PASS_ID, Attributes: PAY_TYPE, CARD_NO, EXPIRY_DATE)
- REVIEWS (PK: PASS_ID, REV_ID, FK: PASS_ID, Attributes: RATING, TEXT)
- FLIGHT (PK: FLIGHT_NO, FK: SOURCE_ID, DEST_ID, Attributes: FLIGHT_NAME)
- CRUISE (PK: CRUISE_NO, FK: SOURCE_ID, DEST_ID)
- FLIGHT_TRANSPORT (PK: FLIGHT_NO, FK: FLIGHT_NO, Attributes: CATEGORY, PRICE)
- CRUISE_TRANSPORT (PK: CRUISE_NO, FK: CRUISE_NO, Attributes: CATEGORY, PRICE)



## EER Diagram(Crow's Foot)
![EER](https://github.com/GAYATRI-SIVANI-SUSARLA/Relational_Database_System/blob/main/Travel%20Agency%20System_final%20(1)-1.png)

#### Notations
![notation](https://github.com/GAYATRI-SIVANI-SUSARLA/Relational_Database_System/blob/main/photos/Screenshot%202025-05-29%20130720.png)

## Code
- Creation of database system, tables and queries are mentioned here: [SQL CODE](https://github.com/GAYATRI-SIVANI-SUSARLA/Relational_Database_System/blob/main/PROJECT_ISE503.sql)
- Python code for interface is available here: [Interface](https://github.com/GAYATRI-SIVANI-SUSARLA/Relational_Database_System/blob/main/SQL_TRAVEL%20AGENCY%20SYSTEM.py)


## Interface Demo
![photo1](https://github.com/GAYATRI-SIVANI-SUSARLA/Relational_Database_System/blob/main/photos/Screenshot%202025-05-29%20143641.png)
![photo2](https://github.com/GAYATRI-SIVANI-SUSARLA/Relational_Database_System/blob/main/photos/Screenshot%202025-05-29%20143655.png)
![photo3](https://github.com/GAYATRI-SIVANI-SUSARLA/Relational_Database_System/blob/main/photos/Screenshot%202025-05-29%20143708.png)
![photo4](https://github.com/GAYATRI-SIVANI-SUSARLA/Relational_Database_System/blob/main/photos/Screenshot%202025-05-29%20143722.png)

## Conclusion
- Built a robust travel agency system with a normalized PostgreSQL database.
- Integrated Tkinter for user interaction and came up with complex SQL queries for insights.
- Ensures data integrity with PK/FK constraints and support scalability.





  
