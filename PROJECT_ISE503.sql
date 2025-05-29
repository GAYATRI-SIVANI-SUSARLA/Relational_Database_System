-- LOCATION TABLE
CREATE TABLE TRAVEL_LOCATION(
LOC_ID CHAR(10) PRIMARY KEY,
CITY VARCHAR(50) NOT NULL,
LOC_STATE VARCHAR(50) NOT NULL,                     
COUNTRY VARCHAR(50) NOT NULL 
);

--PASSENGER TABLE
CREATE TABLE PASSENGER(
PASS_ID CHAR(10) PRIMARY KEY,
PASS_NAME VARCHAR(100) NOT NULL,
GENDER VARCHAR(10) NOT NULL,        
AGE INT NOT NULL
);

--GROUP TABLE
CREATE TABLE TRAVEL_GROUP(
GRP_ID CHAR(10) PRIMARY KEY,
GRP_SIZE INT NOT NULL,
SOURCE_ID CHAR(10) NOT NULL,
DEST_ID CHAR(10) NOT NULL,
PURPOSE VARCHAR(100),
PASS_ID CHAR(10),
FOREIGN KEY(PASS_ID) REFERENCES PASSENGER(PASS_ID)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(SOURCE_ID) REFERENCES TRAVEL_LOCATION(LOC_ID)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(DEST_ID) REFERENCES TRAVEL_LOCATION(LOC_ID)
ON DELETE CASCADE ON UPDATE CASCADE
);

--ACCOMMODATION TABLE
CREATE TABLE ACCOMMODATION(
ACC_ID CHAR(10) PRIMARY KEY,
ACC_TYPE VARCHAR(30) NOT NULL,  --EG.'HOTEL','RESORT','HOUSE'
RATE DECIMAL(10,3) NOT NULL,
FACILITIES TEXT,  --EG. LIKE POOL, SPA, ETC
DISCOUNT DECIMAL(5,3)
);

ALTER TABLE ACCOMMODATION
ALTER COLUMN DISCOUNT DROP DEFAULT;

--EMPLOYEE TABLE
CREATE TABLE EMPLOYEE(
EMP_ID CHAR(10) NOT NULL,
EMP_ROLE VARCHAR(30) NOT NULL, --EG. 'MANAGER','STAFF','SUPERVISOR',ETC
SUP_ID CHAR(10),  --SUPERVISOR ID
ACC_ID CHAR(10) NOT NULL,
PRIMARY KEY(ACC_ID, EMP_ID),
UNIQUE(EMP_ID),
FOREIGN KEY(ACC_ID) REFERENCES ACCOMMODATION(ACC_ID)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(SUP_ID) REFERENCES EMPLOYEE(EMP_ID)
ON DELETE CASCADE ON UPDATE CASCADE          -- SELF REF. F.K
);


--PAYMENT TABLE
CREATE TABLE PAYMENT(
PAY_ID CHAR(10) NOT NULL,
PAY_TYPE VARCHAR(30) NOT NULL,  -- Payment type (e.g., 'Credit Card', 'PayPal')
CARD_NO CHAR(20) NOT NULL,
EXPIRY_DATE DATE NOT NULL,
PASS_ID CHAR(10),
PRIMARY KEY(PAY_ID, PASS_ID),
FOREIGN KEY (PASS_ID) REFERENCES PASSENGER(PASS_ID)
ON DELETE CASCADE ON UPDATE CASCADE
);
ALTER TABLE PAYMENT
ALTER COLUMN CARD_NO TYPE CHAR(15);

--REVIEWS TABLE
CREATE TABLE REVIEWS(
REV_ID CHAR(10) NOT NULL,
RATING INT,
CONSTRAINT CC1 CHECK (RATING >= 1 AND RATING <= 5 ),
TEXT TEXT,
PASS_ID CHAR(10),
PRIMARY KEY(PASS_ID, REV_ID),
FOREIGN KEY (PASS_ID) REFERENCES PASSENGER(PASS_ID)
ON DELETE CASCADE ON UPDATE CASCADE
);


--FLIGHT TABLE 
CREATE TABLE FLIGHT(
FLIGHT_NO CHAR(10) PRIMARY KEY,
FLIGHT_NAME VARCHAR(30) NOT NULL,  -- e.g., 'Delta', 'American Airlines'
SOURCE_ID CHAR(10) NOT NULL,
DEST_ID CHAR(10) NOT NULL,
FLIGHT_CLASS VARCHAR(50) NOT NULL,  -- e.g., 'Economy', 'Business'
FARE DECIMAL(5,2) NOT NULL,
FOREIGN KEY (SOURCE_ID) REFERENCES TRAVEL_LOCATION(LOC_ID)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (DEST_ID) REFERENCES TRAVEL_LOCATION(LOC_ID)
ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE FLIGHT
DROP COLUMN FARE,
DROP COLUMN FLIGHT_CLASS;

--CRUISE TABLE 
CREATE TABLE CRUISE(
CRUISE_NO CHAR(10) PRIMARY KEY,
SOURCE_ID CHAR(10) NOT NULL,
DEST_ID CHAR(10) NOT NULL,
FARE DECIMAL(5,2) NOT NULL,
FOREIGN KEY (SOURCE_ID) REFERENCES TRAVEL_LOCATION(LOC_ID)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (DEST_ID) REFERENCES TRAVEL_LOCATION(LOC_ID)
ON DELETE CASCADE ON UPDATE CASCADE
);
ALTER TABLE CRUISE
DROP COLUMN FARE;

--FLIGHT_TRANSPORT TABLE
CREATE TABLE FLIGHT_TRANSPORT(
FLIGHT_NO CHAR(10) primary key,
CATEGORY VARCHAR(30),
PRICE DECIMAL(5,2),
CONSTRAINT CHK1_CATEGORY CHECK (CATEGORY IN('ECONOMY','PREMIUM ECONOMY','BUSINESS','FIRST','OTHER')),
FOREIGN KEY (FLIGHT_NO) REFERENCES FLIGHT(FLIGHT_NO)
ON DELETE CASCADE ON UPDATE CASCADE
);

--CRUISE_TRANSPORT TABLE
CREATE TABLE CRUISE_TRANSPORT(
CRUISE_NO CHAR(10) primary key,
CATEGORY VARCHAR(30),
PRICE DECIMAL(5,2),
CONSTRAINT CHK2_CATEGORY CHECK (CATEGORY IN('INSIDE','OCEAN VIEW','BALCONY','SUITE','OTHER')),
FOREIGN KEY (CRUISE_NO) REFERENCES CRUISE(CRUISE_NO)
ON DELETE CASCADE ON UPDATE CASCADE
);

-----------------------TOTAL 11 TABLES--------------------------------------------------------------------------------------
-------NOW INSERT VALUES INTO THE 11 TABLES---------------------------------------------------------------------------------
-------POPULATE TABLES WITH 50 VALUES EACH----------------------------------------------------------------------------------

--POPULATING TRAVEL_LOCATION TABLE 

INSERT INTO TRAVEL_LOCATION (LOC_ID, CITY, LOC_STATE, COUNTRY) VALUES
('LOC0000001', 'New York', 'New York', 'United States'),
('LOC0000002', 'London', 'England', 'United Kingdom'),
('LOC0000003', 'Tokyo', 'Tokyo', 'Japan'),
('LOC0000004', 'Paris', 'Île-de-France', 'France'),
('LOC0000005', 'Sydney', 'New South Wales', 'Australia'),
('LOC0000006', 'Toronto', 'Ontario', 'Canada'),
('LOC0000007', 'Mumbai', 'Maharashtra', 'India'),
('LOC0000008', 'Berlin', 'Berlin', 'Germany'),
('LOC0000009', 'Cape Town', 'Western Cape', 'South Africa'),
('LOC0000010', 'Rio de Janeiro', 'Rio de Janeiro', 'Brazil'),
('LOC0000011', 'Rome', 'Lazio', 'Italy'),
('LOC0000012', 'Beijing', 'Beijing', 'China'),
('LOC0000013', 'Dubai', 'Dubai', 'United Arab Emirates'),
('LOC0000014', 'Mexico City', 'Mexico City', 'Mexico'),
('LOC0000015', 'Bangkok', 'Bangkok', 'Thailand'),
('LOC0000016', 'Moscow', 'Moscow', 'Russia'),
('LOC0000017', 'Seoul', 'Seoul', 'South Korea'),
('LOC0000018', 'Barcelona', 'Catalonia', 'Spain'),
('LOC0000019', 'Singapore', 'Singapore', 'Singapore'),
('LOC0000020', 'Istanbul', 'Istanbul', 'Turkey'),
('LOC0000021', 'Los Angeles', 'California', 'United States'),
('LOC0000022', 'Amsterdam', 'North Holland', 'Netherlands'),
('LOC0000023', 'Vienna', 'Vienna', 'Austria'),
('LOC0000024', 'Cairo', 'Cairo', 'Egypt'),
('LOC0000025', 'Buenos Aires', 'Buenos Aires', 'Argentina'),
('LOC0000026', 'Kyoto', 'Kyoto', 'Japan'),
('LOC0000027', 'Vancouver', 'British Columbia', 'Canada'),
('LOC0000028', 'Delhi', 'Delhi', 'India'),
('LOC0000029', 'Munich', 'Bavaria', 'Germany'),
('LOC0000030', 'Nairobi', 'Nairobi', 'Kenya'),
('LOC0000031', 'Sao Paulo', 'Sao Paulo', 'Brazil'),
('LOC0000032', 'Athens', 'Attica', 'Greece'),
('LOC0000033', 'Shanghai', 'Shanghai', 'China'),
('LOC0000034', 'Lisbon', 'Lisbon', 'Portugal'),
('LOC0000035', 'Jakarta', 'Jakarta', 'Indonesia'),
('LOC0000036', 'Hanoi', 'Hanoi', 'Vietnam'),
('LOC0000037', 'Dublin', 'Leinster', 'Ireland'),
('LOC0000038', 'Stockholm', 'Stockholm', 'Sweden'),
('LOC0000039', 'Lima', 'Lima', 'Peru'),
('LOC0000040', 'Kuala Lumpur', 'Kuala Lumpur', 'Malaysia'),
('LOC0000041', 'Miami', 'Florida', 'United States'),
('LOC0000042', 'Prague', 'Prague', 'Czech Republic'),
('LOC0000043', 'Budapest', 'Budapest', 'Hungary'),
('LOC0000044', 'Edinburgh', 'Scotland', 'United Kingdom'),
('LOC0000045', 'Auckland', 'Auckland', 'New Zealand'),
('LOC0000046', 'Manila', 'Metro Manila', 'Philippines'),
('LOC0000047', 'Zurich', 'Zurich', 'Switzerland'),
('LOC0000048', 'Lagos', 'Lagos', 'Nigeria'),
('LOC0000049', 'Santiago', 'Santiago', 'Chile'),
('LOC0000050', 'Oslo', 'Oslo', 'Norway');

--POPULATING PASSENGER

INSERT INTO PASSENGER (PASS_ID, PASS_NAME, GENDER, AGE) VALUES
('PAS0000001', 'John Michael Smith', 'Male', 34),
('PAS0000002', 'Emma Louise Johnson', 'Female', 28),
('PAS0000003', 'Michael James Brown', 'Male', 45),
('PAS0000004', 'Sarah Elizabeth Davis', 'Female', 19),
('PAS0000005', 'David Andrew Wilson', 'Male', 62),
('PAS0000006', 'Laura Marie Taylor', 'Female', 37),
('PAS0000007', 'James Robert Anderson', 'Male', 29),
('PAS0000008', 'Emily Grace Thomas', 'Female', 24),
('PAS0000009', 'Robert William Jackson', 'Male', 53),
('PAS0000010', 'Sophie Ann White', 'Female', 41),
('PAS0000011', 'William Henry Harris', 'Male', 36),
('PAS0000012', 'Olivia Rose Martin', 'Female', 22),
('PAS0000013', 'Thomas Edward Thompson', 'Male', 48),
('PAS0000014', 'Ava Sophia Garcia', 'Female', 31),
('PAS0000015', 'Charles Joseph Martinez', 'Male', 27),
('PAS0000016', 'Isabella Claire Robinson', 'Female', 50),
('PAS0000017', 'Joseph Daniel Clark', 'Male', 65),
('PAS0000018', 'Mia Evelyn Rodriguez', 'Female', 33),
('PAS0000019', 'Daniel Steven Lewis', 'Male', 39),
('PAS0000020', 'Charlotte Jane Lee', 'Female', 26),
('PAS0000021', 'Henry George Walker', 'Male', 58),
('PAS0000022', 'Amelia Faith Hall', 'Female', 30),
('PAS0000023', 'George Benjamin Allen', 'Male', 42),
('PAS0000024', 'Harper Lily Young', 'Female', 21),
('PAS0000025', 'Edward Thomas Hernandez', 'Male', 47),
('PAS0000026', 'Evelyn Rose King', 'Female', 35),
('PAS0000027', 'Andrew Paul Wright', 'Male', 51),
('PAS0000028', 'Abigail Hope Lopez', 'Female', 29),
('PAS0000029', 'Matthew John Hill', 'Male', 60),
('PAS0000030', 'Sofia Marie Scott', 'Female', 23),
('PAS0000031', 'Steven Richard Green', 'Male', 38),
('PAS0000032', 'Luna Victoria Adams', 'Female', 27),
('PAS0000033', 'Paul Anthony Baker', 'Male', 44),
('PAS0000034', 'Aria Elizabeth Gonzalez', 'Female', 32),
('PAS0000035', 'Mark David Nelson', 'Male', 55),
('PAS0000036', 'Ella Katherine Carter', 'Female', 20),
('PAS0000037', 'Richard Alan Mitchell', 'Male', 49),
('PAS0000038', 'Grace Olivia Perez', 'Female', 28),
('PAS0000039', 'Peter Michael Roberts', 'Male', 40),
('PAS0000040', 'Chloe Isabelle Turner', 'Female', 25),
('PAS0000041', 'Samuel Lee Phillips', 'Male', 52),
('PAS0000042', 'Zoe Abigail Campbell', 'Female', 34),
('PAS0000043', 'Benjamin Scott Parker', 'Male', 30),
('PAS0000044', 'Lily Madeline Evans', 'Female', 26),
('PAS0000045', 'Nathan Christopher Edwards', 'Male', 46),
('PAS0000046', 'Hannah Brooke Collins', 'Female', 22),
('PAS0000047', 'Luke Daniel Stewart', 'Male', 41),
('PAS0000048', 'Julia Faith Sanchez', 'Female', 29),
('PAS0000049', 'Jack Ryan Morris', 'Male', 57),
('PAS0000050', 'Mila Harper Rogers', 'Female', 33);

--POPULATING TRAVEL_GROUP

INSERT INTO TRAVEL_GROUP (GRP_ID, GRP_SIZE, SOURCE_ID, DEST_ID, PURPOSE, PASS_ID) VALUES
('GRP0000001', 4, 'LOC0000001', 'LOC0000002', 'Vacation', 'PAS0000001'),
('GRP0000002', 2, 'LOC0000003', 'LOC0000004', 'Business', 'PAS0000002'),
('GRP0000003', 6, 'LOC0000005', 'LOC0000006', 'Family Visit', 'PAS0000003'),
('GRP0000004', 1, 'LOC0000007', 'LOC0000008', 'Education', 'PAS0000004'),
('GRP0000005', 3, 'LOC0000009', 'LOC0000010', 'Vacation', 'PAS0000005'),
('GRP0000006', 5, 'LOC0000011', 'LOC0000012', NULL, 'PAS0000006'),
('GRP0000007', 2, 'LOC0000013', 'LOC0000014', 'Business', 'PAS0000007'),
('GRP0000008', 7, 'LOC0000015', 'LOC0000016', 'Vacation', 'PAS0000008'),
('GRP0000009', 3, 'LOC0000017', 'LOC0000018', 'Medical', 'PAS0000009'),
('GRP0000010', 4, 'LOC0000019', 'LOC0000020', 'Family Visit', 'PAS0000010'),
('GRP0000011', 1, 'LOC0000021', 'LOC0000022', 'Business', 'PAS0000011'),
('GRP0000012', 5, 'LOC0000023', 'LOC0000024', 'Vacation', 'PAS0000012'),
('GRP0000013', 2, 'LOC0000025', 'LOC0000026', 'Education', 'PAS0000013'),
('GRP0000014', 6, 'LOC0000027', 'LOC0000028', NULL, 'PAS0000014'),
('GRP0000015', 3, 'LOC0000029', 'LOC0000030', 'Vacation', 'PAS0000015'),
('GRP0000016', 4, 'LOC0000031', 'LOC0000032', 'Business', 'PAS0000016'),
('GRP0000017', 2, 'LOC0000033', 'LOC0000034', 'Family Visit', 'PAS0000017'),
('GRP0000018', 5, 'LOC0000035', 'LOC0000036', 'Vacation', 'PAS0000018'),
('GRP0000019', 1, 'LOC0000037', 'LOC0000038', 'Medical', 'PAS0000019'),
('GRP0000020', 3, 'LOC0000039', 'LOC0000040', 'Business', 'PAS0000020'),
('GRP0000021', 4, 'LOC0000041', 'LOC0000042', 'Vacation', 'PAS0000021'),
('GRP0000022', 2, 'LOC0000043', 'LOC0000044', NULL, 'PAS0000022'),
('GRP0000023', 6, 'LOC0000045', 'LOC0000046', 'Family Visit', 'PAS0000023'),
('GRP0000024', 3, 'LOC0000047', 'LOC0000048', 'Education', 'PAS0000024'),
('GRP0000025', 5, 'LOC0000049', 'LOC0000050', 'Vacation', 'PAS0000025'),
('GRP0000026', 1, 'LOC0000002', 'LOC0000001', 'Business', 'PAS0000026'),
('GRP0000027', 4, 'LOC0000004', 'LOC0000003', 'Vacation', 'PAS0000027'),
('GRP0000028', 2, 'LOC0000006', 'LOC0000005', 'Medical', 'PAS0000028'),
('GRP0000029', 3, 'LOC0000008', 'LOC0000007', 'Family Visit', 'PAS0000029'),
('GRP0000030', 5, 'LOC0000010', 'LOC0000009', 'Vacation', 'PAS0000030'),
('GRP0000031', 2, 'LOC0000012', 'LOC0000011', 'Business', 'PAS0000031'),
('GRP0000032', 6, 'LOC0000014', 'LOC0000013', NULL, 'PAS0000032'),
('GRP0000033', 3, 'LOC0000016', 'LOC0000015', 'Education', 'PAS0000033'),
('GRP0000034', 4, 'LOC0000018', 'LOC0000017', 'Vacation', 'PAS0000034'),
('GRP0000035', 1, 'LOC0000020', 'LOC0000019', 'Medical', 'PAS0000035'),
('GRP0000036', 5, 'LOC0000022', 'LOC0000021', 'Family Visit', 'PAS0000036'),
('GRP0000037', 2, 'LOC0000024', 'LOC0000023', 'Business', 'PAS0000037'),
('GRP0000038', 3, 'LOC0000026', 'LOC0000025', 'Vacation', 'PAS0000038'),
('GRP0000039', 4, 'LOC0000028', 'LOC0000027', 'Education', 'PAS0000039'),
('GRP0000040', 2, 'LOC0000030', 'LOC0000029', NULL, 'PAS0000040'),
('GRP0000041', 5, 'LOC0000032', 'LOC0000031', 'Vacation', 'PAS0000041'),
('GRP0000042', 3, 'LOC0000034', 'LOC0000033', 'Business', 'PAS0000042'),
('GRP0000043', 1, 'LOC0000036', 'LOC0000035', 'Medical', 'PAS0000043'),
('GRP0000044', 4, 'LOC0000038', 'LOC0000037', 'Family Visit', 'PAS0000044'),
('GRP0000045', 2, 'LOC0000040', 'LOC0000039', 'Vacation', 'PAS0000045'),
('GRP0000046', 6, 'LOC0000042', 'LOC0000041', 'Education', 'PAS0000046'),
('GRP0000047', 3, 'LOC0000044', 'LOC0000043', NULL, 'PAS0000047'),
('GRP0000048', 5, 'LOC0000046', 'LOC0000045', 'Business', 'PAS0000048'),
('GRP0000049', 2, 'LOC0000048', 'LOC0000047', 'Vacation', 'PAS0000049'),
('GRP0000050', 4, 'LOC0000050', 'LOC0000049', 'Family Visit', 'PAS0000050');

--POPULATING ACCOMMODATION

truncate table accommodation,employee

INSERT INTO ACCOMMODATION (ACC_ID, ACC_TYPE, RATE, FACILITIES, DISCOUNT) VALUES
('ACC0000001', 'Hotel', 150.000, 'Wi-Fi, Pool, Gym', 0.100),
('ACC0000002', 'Resort', 350.000, 'Pool, Spa, Restaurant, Beach Access', 0.150),
('ACC0000003', 'House', 200.000, 'Wi-Fi, Parking, Kitchen', 0.000),
('ACC0000004', 'Apartment', 120.000, 'Wi-Fi, Air Conditioning', 0.050),
('ACC0000005', 'Villa', 400.000, 'Pool, Wi-Fi, Parking, Garden', 0.200),
('ACC0000006', 'Hostel', 50.000, 'Wi-Fi, Shared Kitchen', 0.000),
('ACC0000007', 'Bed and Breakfast', 100.000, 'Wi-Fi, Breakfast Included', 0.080),
('ACC0000008', 'Hotel', 180.000, 'Wi-Fi, Gym, Restaurant', 0.120),
('ACC0000009', 'Resort', 300.000, 'Pool, Spa, Wi-Fi, Tennis Court', 0.100),
('ACC0000010', 'House', 220.000, 'Wi-Fi, Kitchen, Parking', 0.000),
('ACC0000011', 'Apartment', 140.000, 'Wi-Fi, Balcony', 0.070),
('ACC0000012', 'Villa', 450.000, 'Pool, Wi-Fi, Private Beach', 0.250),
('ACC0000013', 'Hostel', 60.000, 'Wi-Fi, Common Area', 0.000),
('ACC0000014', 'Hotel', 170.000, 'Wi-Fi, Pool, Bar', 0.090),
('ACC0000015', 'Resort', 320.000, 'Pool, Spa, Restaurant, Golf Course', 0.180),
('ACC0000016', 'House', 190.000, 'Wi-Fi, Garden, Parking', 0.050),
('ACC0000017', 'Apartment', 130.000, 'Wi-Fi, Kitchenette', 0.000),
('ACC0000018', 'Villa', 380.000, 'Pool, Wi-Fi, BBQ Area', 0.150),
('ACC0000019', 'Bed and Breakfast', 110.000, 'Wi-Fi, Breakfast, Parking', 0.060),
('ACC0000020', 'Hotel', 200.000, 'Wi-Fi, Gym, Conference Room', 0.100),
('ACC0000021', 'Resort', 340.000, 'Pool, Spa, Wi-Fi, Kids Club', 0.200),
('ACC0000022', 'House', 210.000, 'Wi-Fi, Parking, Air Conditioning', 0.000),
('ACC0000023', 'Apartment', 150.000, 'Wi-Fi, Balcony, Kitchen', 0.080),
('ACC0000024', 'Hostel', 55.000, 'Wi-Fi, Shared Bathroom', 0.000),
('ACC0000025', 'Villa', 420.000, 'Pool, Wi-Fi, Private Garden', 0.220),
('ACC0000026', 'Hotel', 160.000, 'Wi-Fi, Restaurant, Parking', 0.110),
('ACC0000027', 'Resort', 360.000, 'Pool, Spa, Beach Access, Wi-Fi', 0.170),
('ACC0000028', 'House', 180.000, 'Wi-Fi, Kitchen, Parking', 0.000),
('ACC0000029', 'Apartment', 125.000, 'Wi-Fi, Air Conditioning', 0.050),
('ACC0000030', 'Bed and Breakfast', 105.000, 'Wi-Fi, Breakfast', 0.070),
('ACC0000031', 'Hotel', 190.000, 'Wi-Fi, Pool, Gym', 0.090),
('ACC0000032', 'Resort', 310.000, 'Pool, Spa, Restaurant, Wi-Fi', 0.130),
('ACC0000033', 'House', 230.000, 'Wi-Fi, Garden, Kitchen', 0.000),
('ACC0000034', 'Apartment', 145.000, 'Wi-Fi, Balcony', 0.060),
('ACC0000035', 'Villa', 390.000, 'Pool, Wi-Fi, Parking, Spa', 0.200),
('ACC0000036', 'Hostel', 65.000, 'Wi-Fi, Common Area', 0.000),
('ACC0000037', 'Hotel', 175.000, 'Wi-Fi, Bar, Restaurant', 0.100),
('ACC0000038', 'Resort', 330.000, 'Pool, Spa, Wi-Fi, Fitness Center', 0.150),
('ACC0000039', 'House', 195.000, 'Wi-Fi, Parking, Air Conditioning', 0.000),
('ACC0000040', 'Apartment', 135.000, 'Wi-Fi, Kitchenette', 0.080),
('ACC0000041', 'Bed and Breakfast', 115.000, 'Wi-Fi, Breakfast, Garden', 0.050),
('ACC0000042', 'Hotel', 185.000, 'Wi-Fi, Gym, Pool', 0.120),
('ACC0000043', 'Resort', 350.000, 'Pool, Spa, Beach Access, Restaurant', 0.180),
('ACC0000044', 'House', 205.000, 'Wi-Fi, Kitchen, Parking', 0.000),
('ACC0000045', 'Apartment', 140.000, 'Wi-Fi, Balcony, Air Conditioning', 0.070),
('ACC0000046', 'Villa', 410.000, 'Pool, Wi-Fi, Private Garden', 0.210),
('ACC0000047', 'Hostel', 70.000, 'Wi-Fi, Shared Kitchen', 0.000),
('ACC0000048', 'Hotel', 195.000, 'Wi-Fi, Restaurant, Parking', 0.110),
('ACC0000049', 'Resort', 340.000, 'Pool, Spa, Wi-Fi, Kids Club', 0.160),
('ACC0000050', 'House', 215.000, 'Wi-Fi, Garden, Kitchen', 0.000);

--POPULATING EMPLOYEE

INSERT INTO EMPLOYEE (EMP_ID, EMP_ROLE, SUP_ID, ACC_ID) VALUES
('EMP0000001', 'Manager', NULL, 'ACC0000001'),
('EMP0000002', 'Manager', NULL, 'ACC0000002'),
('EMP0000003', 'Manager', NULL, 'ACC0000003'),
('EMP0000004', 'Manager', NULL, 'ACC0000004'),
('EMP0000005', 'Manager', NULL, 'ACC0000005'),
('EMP0000006', 'Supervisor', 'EMP0000001', 'ACC0000001'),
('EMP0000007', 'Supervisor', 'EMP0000001', 'ACC0000001'),
('EMP0000008', 'Supervisor', 'EMP0000002', 'ACC0000002'),
('EMP0000009', 'Supervisor', 'EMP0000002', 'ACC0000002'),
('EMP0000010', 'Supervisor', 'EMP0000003', 'ACC0000003'),
('EMP0000011', 'Supervisor', 'EMP0000003', 'ACC0000003'),
('EMP0000012', 'Supervisor', 'EMP0000004', 'ACC0000004'),
('EMP0000013', 'Supervisor', 'EMP0000004', 'ACC0000004'),
('EMP0000014', 'Supervisor', 'EMP0000005', 'ACC0000005'),
('EMP0000015', 'Supervisor', 'EMP0000005', 'ACC0000005'),
('EMP0000016', 'Staff', 'EMP0000006', 'ACC0000001'),
('EMP0000017', 'Receptionist', 'EMP0000006', 'ACC0000001'),
('EMP0000018', 'Housekeeper', 'EMP0000007', 'ACC0000001'),
('EMP0000019', 'Concierge', 'EMP0000007', 'ACC0000001'),
('EMP0000020', 'Staff', 'EMP0000008', 'ACC0000002'),
('EMP0000021', 'Receptionist', 'EMP0000008', 'ACC0000002'),
('EMP0000022', 'Housekeeper', 'EMP0000009', 'ACC0000002'),
('EMP0000023', 'Concierge', 'EMP0000009', 'ACC0000002'),
('EMP0000024', 'Staff', 'EMP0000010', 'ACC0000003'),
('EMP0000025', 'Receptionist', 'EMP0000010', 'ACC0000003'),
('EMP0000026', 'Housekeeper', 'EMP0000011', 'ACC0000003'),
('EMP0000027', 'Concierge', 'EMP0000011', 'ACC0000003'),
('EMP0000028', 'Staff', 'EMP0000012', 'ACC0000004'),
('EMP0000029', 'Receptionist', 'EMP0000012', 'ACC0000004'),
('EMP0000030', 'Housekeeper', 'EMP0000013', 'ACC0000004'),
('EMP0000031', 'Concierge', 'EMP0000013', 'ACC0000004'),
('EMP0000032', 'Staff', 'EMP0000014', 'ACC0000005'),
('EMP0000033', 'Receptionist', 'EMP0000014', 'ACC0000005'),
('EMP0000034', 'Housekeeper', 'EMP0000015', 'ACC0000005'),
('EMP0000035', 'Concierge', 'EMP0000015', 'ACC0000005'),
('EMP0000036', 'Staff', 'EMP0000001', 'ACC0000006'),
('EMP0000037', 'Receptionist', 'EMP0000006', 'ACC0000007'),
('EMP0000038', 'Housekeeper', 'EMP0000007', 'ACC0000008'),
('EMP0000039', 'Staff', 'EMP0000008', 'ACC0000009'),
('EMP0000040', 'Concierge', 'EMP0000009', 'ACC0000010'),
('EMP0000041', 'Staff', 'EMP0000010', 'ACC0000011'),
('EMP0000042', 'Receptionist', 'EMP0000011', 'ACC0000012'),
('EMP0000043', 'Housekeeper', 'EMP0000012', 'ACC0000013'),
('EMP0000044', 'Staff', 'EMP0000013', 'ACC0000014'),
('EMP0000045', 'Concierge', 'EMP0000014', 'ACC0000015'),
('EMP0000046', 'Staff', 'EMP0000015', 'ACC0000016'),
('EMP0000047', 'Receptionist', 'EMP0000001', 'ACC0000017'),
('EMP0000048', 'Housekeeper', 'EMP0000002', 'ACC0000018'),
('EMP0000049', 'Staff', 'EMP0000003', 'ACC0000019'),
('EMP0000050', 'Concierge', 'EMP0000004', 'ACC0000020');

--POPULATING PAYMENT

INSERT INTO PAYMENT (PAY_ID, PAY_TYPE, CARD_NO, EXPIRY_DATE, PASS_ID) VALUES
('PAY0000001', 'Credit Card', '453201511234567', '2027-10-15', 'PAS0000001'),
('PAY0000002', 'PayPal', 'PP987654321     ', '2028-05-20', 'PAS0000002'),
('PAY0000003', 'Debit Card', '542398761234567', '2026-11-25', 'PAS0000003'),
('PAY0000004', 'Bank Transfer', 'BT456789123     ', '2029-03-10', 'PAS0000004'),
('PAY0000005', 'Mobile Payment', 'MB123456789     ', '2027-07-05', 'PAS0000005'),
('PAY0000006', 'Credit Card', '491612341234567', '2028-09-30', 'PAS0000006'),
('PAY0000007', 'PayPal', 'PP456123789     ', '2026-08-15', 'PAS0000007'),
('PAY0000008', 'Debit Card', '471623451234567', '2029-06-12', 'PAS0000008'),
('PAY0000009', 'Credit Card', '453901231234567', '2027-12-01', 'PAS0000009'),
('PAY0000010', 'Mobile Payment', 'MB789123456     ', '2028-08-18', 'PAS0000010'),
('PAY0000011', 'Bank Transfer', 'BT789123456     ', '2026-10-22', 'PAS0000011'),
('PAY0000012', 'Credit Card', '426512341234567', '2029-04-07', 'PAS0000012'),
('PAY0000013', 'PayPal', 'PP123789456     ', '2027-11-13', 'PAS0000013'),
('PAY0000014', 'Debit Card', '448512341234567', '2028-03-08', 'PAS0000014'),
('PAY0000015', 'Credit Card', '455612341234567', '2026-12-14', 'PAS0000015'),
('PAY0000016', 'Mobile Payment', 'MB456789123     ', '2029-09-01', 'PAS0000016'),
('PAY0000017', 'Bank Transfer', 'BT123456789     ', '2027-06-06', 'PAS0000017'),
('PAY0000018', 'PayPal', 'PP789456123     ', '2028-10-11', 'PAS0000018'),
('PAY0000019', 'Credit Card', '471612341234567', '2026-07-19', 'PAS0000019'),
('PAY0000020', 'Debit Card', '453212341234567', '2029-05-04', 'PAS0000020'),
('PAY0000021', 'Credit Card', '491712341234567', '2027-12-10', 'PAS0000021'),
('PAY0000022', 'Mobile Payment', 'MB789456123     ', '2028-02-15', 'PAS0000022'),
('PAY0000023', 'PayPal', 'PP456789123     ', '2026-09-20', 'PAS0000023'),
('PAY0000024', 'Bank Transfer', 'BT456123789     ', '2029-07-16', 'PAS0000024'),
('PAY0000025', 'Credit Card', '426612341234567', '2027-08-22', 'PAS0000025'),
('PAY0000026', 'Debit Card', '448612341234567', '2028-11-27', 'PAS0000026'),
('PAY0000027', 'Credit Card', '453312341234567', '2026-10-03', 'PAS0000001'),
('PAY0000028', 'PayPal', 'PP123456789     ', '2029-08-08', 'PAS0000002'),
('PAY0000029', 'Mobile Payment', 'MB123789456     ', '2027-05-14', 'PAS0000003'),
('PAY0000030', 'Bank Transfer', 'BT789456123     ', '2028-12-19', 'PAS0000004'),
('PAY0000031', 'Credit Card', '471712341234567', '2026-06-25', 'PAS0000005'),
('PAY0000032', 'Debit Card', '453912341234567', '2029-09-30', 'PAS0000006'),
('PAY0000033', 'PayPal', 'PP789123456     ', '2027-04-05', 'PAS0000007'),
('PAY0000034', 'Credit Card', '426712341234567', '2028-05-11', 'PAS0000008'),
('PAY0000035', 'Mobile Payment', 'MB456123789     ', '2026-12-17', 'PAS0000009'),
('PAY0000036', 'Bank Transfer', 'BT123789456     ', '2029-02-22', 'PAS0000010'),
('PAY0000037', 'Credit Card', '448712341234567', '2027-07-28', 'PAS0000011'),
('PAY0000038', 'Debit Card', '455712341234567', '2028-10-03', 'PAS0000012'),
('PAY0000039', 'PayPal', 'PP456123456     ', '2026-08-09', 'PAS0000013'),
('PAY0000040', 'Credit Card', '453412341234567', '2029-04-15', 'PAS0000014'),
('PAY0000041', 'Mobile Payment', 'MB789123789     ', '2027-11-21', 'PAS0000015'),
('PAY0000042', 'Bank Transfer', 'BT456789456     ', '2028-03-27', 'PAS0000016'),
('PAY0000043', 'Credit Card', '426812341234567', '2026-09-02', 'PAS0000017'),
('PAY0000044', 'Debit Card', '448812341234567', '2029-08-08', 'PAS0000018'),
('PAY0000045', 'PayPal', 'PP123789123     ', '2027-06-14', 'PAS0000019'),
('PAY0000046', 'Credit Card', '453512341234567', '2028-09-19', 'PAS0000020'),
('PAY0000047', 'Mobile Payment', 'MB456789456     ', '2026-11-25', 'PAS0000021'),
('PAY0000048', 'Bank Transfer', 'BT789123789     ', '2029-03-02', 'PAS0000022'),
('PAY0000049', 'Credit Card', '471812341234567', '2027-10-07', 'PAS0000023'),
('PAY0000050', 'Debit Card', '453612341234567', '2028-12-13', 'PAS0000024');

--POPULATING REVIEWS

INSERT INTO REVIEWS (REV_ID, RATING, TEXT, PASS_ID) VALUES
('REV0000001', 5, 'Amazing experience, highly recommend!', 'PAS0000001'),
('REV0000002', 4, 'Great service, very comfortable.', 'PAS0000002'),
('REV0000003', 3, 'It was okay, nothing special.', 'PAS0000003'),
('REV0000004', 2, 'Disappointing, needs improvement.', 'PAS0000004'),
('REV0000005', 5, 'Fantastic stay, will come again!', 'PAS0000005'),
('REV0000006', NULL, 'No comment.', 'PAS0000006'),
('REV0000007', 4, 'Friendly staff, good facilities.', 'PAS0000007'),
('REV0000008', 3, 'Average experience, could be better.', 'PAS0000008'),
('REV0000009', 5, 'Loved every moment, top-notch!', 'PAS0000009'),
('REV0000010', 1, 'Terrible service, very unhappy.', 'PAS0000010'),
('REV0000011', 4, 'Nice place, enjoyed my stay.', 'PAS0000011'),
('REV0000012', 3, 'Decent but room for improvement.', 'PAS0000012'),
('REV0000013', 5, 'Perfect vacation, highly satisfied!', 'PAS0000013'),
('REV0000014', 2, 'Not worth the price, disappointed.', 'PAS0000014'),
('REV0000015', 4, 'Good value, pleasant stay.', 'PAS0000015'),
('REV0000016', NULL, NULL, 'PAS0000016'),
('REV0000017', 3, 'Okay, but service was slow.', 'PAS0000017'),
('REV0000018', 5, 'Absolutely wonderful, will return!', 'PAS0000018'),
('REV0000019', 4, 'Very clean and comfortable.', 'PAS0000019'),
('REV0000020', 2, 'Poor facilities, not recommended.', 'PAS0000020'),
('REV0000021', 5, 'Exceeded expectations, fantastic!', 'PAS0000021'),
('REV0000022', 3, 'It was fine, nothing remarkable.', 'PAS0000022'),
('REV0000023', 4, 'Great location, friendly staff.', 'PAS0000023'),
('REV0000024', 1, 'Awful experience, avoid!', 'PAS0000024'),
('REV0000025', 5, 'Best hotel I’ve stayed in!', 'PAS0000025'),
('REV0000026', 4, 'Enjoyable stay, good amenities.', 'PAS0000026'),
('REV0000027', 3, 'Mediocre, expected more.', 'PAS0000001'),
('REV0000028', NULL, 'No feedback provided.', 'PAS0000002'),
('REV0000029', 5, 'Incredible service, loved it!', 'PAS0000003'),
('REV0000030', 2, 'Unclean rooms, very dissatisfied.', 'PAS0000004'),
('REV0000031', 4, 'Nice ambiance, would stay again.', 'PAS0000005'),
('REV0000032', 3, 'Average, nothing stood out.', 'PAS0000006'),
('REV0000033', 5, 'Superb experience, highly recommend!', 'PAS0000007'),
('REV0000034', 4, 'Comfortable and welcoming.', 'PAS0000008'),
('REV0000035', 2, 'Service was lacking, disappointed.', 'PAS0000009'),
('REV0000036', 5, 'Perfect in every way!', 'PAS0000010'),
('REV0000037', 3, 'Okay experience, could improve.', 'PAS0000011'),
('REV0000038', 4, 'Good stay, friendly environment.', 'PAS0000012'),
('REV0000039', NULL, NULL, 'PAS0000013'),
('REV0000040', 5, 'Outstanding service, loved it!', 'PAS0000014'),
('REV0000041', 2, 'Not great, needs better management.', 'PAS0000015'),
('REV0000042', 4, 'Very nice, enjoyed the facilities.', 'PAS0000016'),
('REV0000043', 3, 'Fair, but service was inconsistent.', 'PAS0000017'),
('REV0000044', 5, 'Wonderful stay, highly satisfied!', 'PAS0000018'),
('REV0000045', 4, 'Great value for money.', 'PAS0000019'),
('REV0000046', 2, 'Poor experience, wouldn’t return.', 'PAS0000020'),
('REV0000047', 5, 'Fantastic, exceeded all expectations!', 'PAS0000021'),
('REV0000048', 3, 'It was alright, nothing special.', 'PAS0000022'),
('REV0000049', 4, 'Pleasant stay, good service.', 'PAS0000023'),
('REV0000050', 1, 'Terrible, worst stay ever.', 'PAS0000024');

--POPULATING FLIGHT

INSERT INTO FLIGHT (FLIGHT_NO, FLIGHT_NAME, SOURCE_ID, DEST_ID) VALUES
('FLT0000001', 'Delta', 'LOC0000001', 'LOC0000002'),
('FLT0000002', 'American Airlines', 'LOC0000003', 'LOC0000004'),
('FLT0000003', 'Emirates', 'LOC0000005', 'LOC0000006'),
('FLT0000004', 'Lufthansa', 'LOC0000007', 'LOC0000008'),
('FLT0000005', 'Qantas', 'LOC0000009', 'LOC0000010'),
('FLT0000006', 'Air Canada', 'LOC0000011', 'LOC0000012'),
('FLT0000007', 'British Airways', 'LOC0000013', 'LOC0000014'),
('FLT0000008', 'Singapore Airlines', 'LOC0000015', 'LOC0000016'),
('FLT0000009', 'Cathay Pacific', 'LOC0000017', 'LOC0000018'),
('FLT0000010', 'Air France', 'LOC0000019', 'LOC0000020'),
('FLT0000011', 'United Airlines', 'LOC0000021', 'LOC0000022'),
('FLT0000012', 'Turkish Airlines', 'LOC0000023', 'LOC0000024'),
('FLT0000013', 'ANA', 'LOC0000025', 'LOC0000026'),
('FLT0000014', 'KLM', 'LOC0000027', 'LOC0000028'),
('FLT0000015', 'LATAM', 'LOC0000029', 'LOC0000030'),
('FLT0000016', 'Qatar Airways', 'LOC0000031', 'LOC0000032'),
('FLT0000017', 'Etihad Airways', 'LOC0000033', 'LOC0000034'),
('FLT0000018', 'Swiss Air', 'LOC0000035', 'LOC0000036'),
('FLT0000019', 'Iberia', 'LOC0000037', 'LOC0000038'),
('FLT0000020', 'Aeromexico', 'LOC0000039', 'LOC0000040'),
('FLT0000021', 'Delta', 'LOC0000041', 'LOC0000042'),
('FLT0000022', 'American Airlines', 'LOC0000043', 'LOC0000044'),
('FLT0000023', 'Emirates', 'LOC0000045', 'LOC0000046'),
('FLT0000024', 'Lufthansa', 'LOC0000047', 'LOC0000048'),
('FLT0000025', 'Qantas', 'LOC0000049', 'LOC0000050'),
('FLT0000026', 'Air Canada', 'LOC0000002', 'LOC0000001'),
('FLT0000027', 'British Airways', 'LOC0000004', 'LOC0000003'),
('FLT0000028', 'Singapore Airlines', 'LOC0000006', 'LOC0000005'),
('FLT0000029', 'Cathay Pacific', 'LOC0000008', 'LOC0000007'),
('FLT0000030', 'Air France', 'LOC0000010', 'LOC0000009'),
('FLT0000031', 'United Airlines', 'LOC0000012', 'LOC0000011'),
('FLT0000032', 'Turkish Airlines', 'LOC0000014', 'LOC0000013'),
('FLT0000033', 'ANA', 'LOC0000016', 'LOC0000015'),
('FLT0000034', 'KLM', 'LOC0000018', 'LOC0000017'),
('FLT0000035', 'LATAM', 'LOC0000020', 'LOC0000019'),
('FLT0000036', 'Qatar Airways', 'LOC0000022', 'LOC0000021'),
('FLT0000037', 'Etihad Airways', 'LOC0000024', 'LOC0000023'),
('FLT0000038', 'Swiss Air', 'LOC0000026', 'LOC0000025'),
('FLT0000039', 'Iberia', 'LOC0000028', 'LOC0000027'),
('FLT0000040', 'Aeromexico', 'LOC0000030', 'LOC0000029'),
('FLT0000041', 'Delta', 'LOC0000032', 'LOC0000031'),
('FLT0000042', 'American Airlines', 'LOC0000034', 'LOC0000033'),
('FLT0000043', 'Emirates', 'LOC0000036', 'LOC0000035'),
('FLT0000044', 'Lufthansa', 'LOC0000038', 'LOC0000037'),
('FLT0000045', 'Qantas', 'LOC0000040', 'LOC0000039'),
('FLT0000046', 'Air Canada', 'LOC0000042', 'LOC0000041'),
('FLT0000047', 'British Airways', 'LOC0000044', 'LOC0000043'),
('FLT0000048', 'Singapore Airlines', 'LOC0000046', 'LOC0000045'),
('FLT0000049', 'Cathay Pacific', 'LOC0000048', 'LOC0000047'),
('FLT0000050', 'Air France', 'LOC0000050', 'LOC0000049');

--POPULATING CRUISE

INSERT INTO CRUISE (CRUISE_NO, SOURCE_ID, DEST_ID) VALUES
('CRU0000001', 'LOC0000001', 'LOC0000019'), -- New York to Barcelona
('CRU0000002', 'LOC0000021', 'LOC0000005'), -- Los Angeles to Sydney
('CRU0000003', 'LOC0000017', 'LOC0000014'), -- Singapore to Bangkok
('CRU0000004', 'LOC0000044', 'LOC0000023'), -- Miami to Buenos Aires
('CRU0000005', 'LOC0000008', 'LOC0000040'), -- Cape Town to Lisbon
('CRU0000006', 'LOC0000019', 'LOC0000002'), -- Barcelona to London
('CRU0000007', 'LOC0000005', 'LOC0000027'), -- Sydney to Auckland
('CRU0000008', 'LOC0000013', 'LOC0000020'), -- Dubai to Istanbul
('CRU0000009', 'LOC0000040', 'LOC0000011'), -- Lisbon to Rome
('CRU0000010', 'LOC0000020', 'LOC0000015'), -- Istanbul to Mexico City
('CRU0000011', 'LOC0000016', 'LOC0000032'), -- Amsterdam to Athens
('CRU0000012', 'LOC0000007', 'LOC0000029'), -- Rio de Janeiro to Lima
('CRU0000013', 'LOC0000022', 'LOC0000006'), -- Vancouver to Toronto
('CRU0000014', 'LOC0000030', 'LOC0000038'), -- Dublin to Edinburgh
('CRU0000015', 'LOC0000018', 'LOC0000034'), -- Seoul to Santiago
('CRU0000016', 'LOC0000044', 'LOC0000001'), -- Miami to New York
('CRU0000017', 'LOC0000002', 'LOC0000019'), -- London to Barcelona
('CRU0000018', 'LOC0000027', 'LOC0000005'), -- Auckland to Sydney
('CRU0000019', 'LOC0000014', 'LOC0000017'), -- Bangkok to Singapore
('CRU0000020', 'LOC0000023', 'LOC0000047'), -- Buenos Aires to Bogota
('CRU0000021', 'LOC0000011', 'LOC0000035'), -- Rome to Prague
('CRU0000022', 'LOC0000032', 'LOC0000016'), -- Athens to Amsterdam
('CRU0000023', 'LOC0000029', 'LOC0000007'), -- Lima to Rio de Janeiro
('CRU0000024', 'LOC0000038', 'LOC0000030'), -- Edinburgh to Dublin
('CRU0000025', 'LOC0000034', 'LOC0000018'), -- Santiago to Seoul
('CRU0000026', 'LOC0000040', 'LOC0000044'), -- Lisbon to Miami
('CRU0000027', 'LOC0000019', 'LOC0000008'), -- Barcelona to Cape Town
('CRU0000028', 'LOC0000005', 'LOC0000021'), -- Sydney to Los Angeles
('CRU0000029', 'LOC0000017', 'LOC0000013'), -- Singapore to Dubai
('CRU0000030', 'LOC0000020', 'LOC0000002'), -- Istanbul to London
('CRU0000031', 'LOC0000001', 'LOC0000040'), -- New York to Lisbon
('CRU0000032', 'LOC0000044', 'LOC0000011'), -- Miami to Rome
('CRU0000033', 'LOC0000027', 'LOC0000014'), -- Auckland to Bangkok
('CRU0000034', 'LOC0000016', 'LOC0000038'), -- Amsterdam to Edinburgh
('CRU0000035', 'LOC0000030', 'LOC0000019'), -- Dublin to Barcelona
('CRU0000036', 'LOC0000018', 'LOC0000027'), -- Seoul to Auckland
('CRU0000037', 'LOC0000023', 'LOC0000029'), -- Buenos Aires to Lima
('CRU0000038', 'LOC0000007', 'LOC0000047'), -- Rio de Janeiro to Bogota
('CRU0000039', 'LOC0000021', 'LOC0000005'), -- Los Angeles to Sydney
('CRU0000040', 'LOC0000013', 'LOC0000017'), -- Dubai to Singapore
('CRU0000041', 'LOC0000040', 'LOC0000001'), -- Lisbon to New York
('CRU0000042', 'LOC0000011', 'LOC0000044'), -- Rome to Miami
('CRU0000043', 'LOC0000032', 'LOC0000002'), -- Athens to London
('CRU0000044', 'LOC0000038', 'LOC0000016'), -- Edinburgh to Amsterdam
('CRU0000045', 'LOC0000020', 'LOC0000014'), -- Istanbul to Bangkok
('CRU0000046', 'LOC0000027', 'LOC0000018'), -- Auckland to Seoul
('CRU0000047', 'LOC0000044', 'LOC0000023'), -- Miami to Buenos Aires
('CRU0000048', 'LOC0000008', 'LOC0000019'), -- Cape Town to Barcelona
('CRU0000049', 'LOC0000017', 'LOC0000020'), -- Singapore to Istanbul
('CRU0000050', 'LOC0000005', 'LOC0000040'); -- Sydney to Lisbon


--POPULATING FLIGHT_TRANSPORT

INSERT INTO FLIGHT_TRANSPORT (FLIGHT_NO, CATEGORY, PRICE) VALUES
('FLT0000001', 'ECONOMY', 130.00),
('FLT0000002', 'BUSINESS', 460.00),
('FLT0000003', 'PREMIUM ECONOMY', 240.00),
('FLT0000004', 'FIRST', 720.00),
('FLT0000005', 'OTHER', 250.00),
('FLT0000006', 'ECONOMY', 110.00),
('FLT0000007', 'BUSINESS', 480.00),
('FLT0000008', 'PREMIUM ECONOMY', 260.00),
('FLT0000009', 'ECONOMY', 150.00),
('FLT0000010', 'FIRST', 780.00),
('FLT0000011', 'OTHER', 300.00),
('FLT0000012', 'ECONOMY', 170.00),
('FLT0000013', 'BUSINESS', 450.00),
('FLT0000014', 'PREMIUM ECONOMY', 220.00),
('FLT0000015', 'FIRST', 740.00),
('FLT0000016', 'ECONOMY', 100.00),
('FLT0000017', 'OTHER', 270.00),
('FLT0000018', 'BUSINESS', 490.00),
('FLT0000019', 'PREMIUM ECONOMY', 280.00),
('FLT0000020', 'ECONOMY', 140.00),
('FLT0000021', 'FIRST', 760.00),
('FLT0000022', 'OTHER', 230.00),
('FLT0000023', 'ECONOMY', 180.00),
('FLT0000024', 'BUSINESS', 470.00),
('FLT0000025', 'PREMIUM ECONOMY', 250.00),
('FLT0000026', 'ECONOMY', 120.00),
('FLT0000027', 'FIRST', 700.00),
('FLT0000028', 'OTHER', 350.00),
('FLT0000029', 'BUSINESS', 440.00),
('FLT0000030', 'PREMIUM ECONOMY', 265.00),
('FLT0000031', 'ECONOMY', 160.00),
('FLT0000032', 'FIRST', 790.00),
('FLT0000033', 'OTHER', 200.00),
('FLT0000034', 'BUSINESS', 500.00),
('FLT0000035', 'PREMIUM ECONOMY', 270.00),
('FLT0000036', 'ECONOMY', 90.00),
('FLT0000037', 'FIRST', 730.00),
('FLT0000038', 'OTHER', 280.00),
('FLT0000039', 'BUSINESS', 455.00),
('FLT0000040', 'PREMIUM ECONOMY', 255.00),
('FLT0000041', 'ECONOMY', 145.00),
('FLT0000042', 'FIRST', 750.00),
('FLT0000043', 'OTHER', 260.00),
('FLT0000044', 'BUSINESS', 475.00),
('FLT0000045', 'PREMIUM ECONOMY', 230.00),
('FLT0000046', 'ECONOMY', 175.00),
('FLT0000047', 'FIRST', 710.00),
('FLT0000048', 'OTHER', 240.00),
('FLT0000049', 'BUSINESS', 420.00),
('FLT0000050', 'PREMIUM ECONOMY', 200.00);


--POPULATING CRUISE_TRANSPORT

INSERT INTO CRUISE_TRANSPORT (CRUISE_NO, CATEGORY, PRICE) VALUES
('CRU0000001', 'INSIDE', 100.00),
('CRU0000002', 'BALCONY', 250.00),
('CRU0000003', 'OCEAN VIEW', 160.00),
('CRU0000004', 'SUITE', 500.00),
('CRU0000005', 'OTHER', 220.00),
('CRU0000006', 'INSIDE', 90.00),
('CRU0000007', 'OCEAN VIEW', 145.00),
('CRU0000008', 'BALCONY', 270.00),
('CRU0000009', 'SUITE', 580.00),
('CRU0000010', 'INSIDE', 110.00),
('CRU0000011', 'OTHER', 200.00),
('CRU0000012', 'OCEAN VIEW', 175.00),
('CRU0000013', 'BALCONY', 240.00),
('CRU0000014', 'INSIDE', 95.00),
('CRU0000015', 'SUITE', 550.00),
('CRU0000016', 'OCEAN VIEW', 150.00),
('CRU0000017', 'INSIDE', 85.00),
('CRU0000018', 'BALCONY', 260.00),
('CRU0000019', 'OTHER', 230.00),
('CRU0000020', 'SUITE', 600.00),
('CRU0000021', 'INSIDE', 105.00),
('CRU0000022', 'OCEAN VIEW', 165.00),
('CRU0000023', 'BALCONY', 280.00),
('CRU0000024', 'INSIDE', 120.00),
('CRU0000025', 'SUITE', 620.00),
('CRU0000026', 'OTHER', 250.00),
('CRU0000027', 'OCEAN VIEW', 140.00),
('CRU0000028', 'INSIDE', 100.00),
('CRU0000029', 'BALCONY', 255.00),
('CRU0000030', 'SUITE', 570.00),
('CRU0000031', 'INSIDE', 90.00),
('CRU0000032', 'OCEAN VIEW', 180.00),
('CRU0000033', 'OTHER', 210.00),
('CRU0000034', 'BALCONY', 265.00),
('CRU0000035', 'SUITE', 590.00),
('CRU0000036', 'INSIDE', 115.00),
('CRU0000037', 'OCEAN VIEW', 155.00),
('CRU0000038', 'BALCONY', 245.00),
('CRU0000039', 'INSIDE', 95.00),
('CRU0000040', 'SUITE', 560.00),
('CRU0000041', 'OTHER', 240.00),
('CRU0000042', 'OCEAN VIEW', 170.00),
('CRU0000043', 'INSIDE', 110.00),
('CRU0000044', 'BALCONY', 275.00),
('CRU0000045', 'SUITE', 610.00),
('CRU0000046', 'INSIDE', 100.00),
('CRU0000047', 'OCEAN VIEW', 145.00),
('CRU0000048', 'OTHER', 225.00),
('CRU0000049', 'BALCONY', 260.00),
('CRU0000050', 'SUITE', 580.00);

---------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------SQL QUERIES---------------------------------------------------------------------------

-- 1. /* List employees who are supervisors and also mention how many employees they supervise. */

SELECT s.EMP_ID AS Supervisor_ID, s.EMP_ROLE, 
COUNT(e.EMP_ID) AS Supervised_Employees
FROM EMPLOYEE e
JOIN EMPLOYEE s ON e.SUP_ID = s.EMP_ID
GROUP BY s.EMP_ID, s.EMP_ROLE;

--2. /*Find the top 5 passengers who have written the highest-rated reviews and include their age, gender, and payment method. */

SELECT DISTINCT p.PASS_NAME, p.AGE, p.GENDER, r.RATING, pay.PAY_TYPE
FROM REVIEWS r
JOIN PASSENGER p ON r.PASS_ID = p.PASS_ID
JOIN PAYMENT pay ON p.PASS_ID = pay.PASS_ID
WHERE R.RATING IS NOT NULL
ORDER BY r.RATING DESC
LIMIT 5;

--3. /* Find the cities where accommodations with a 5-star rating offer facilities like a pool, spa, or Wi-Fi.*/

SELECT DISTINCT tl.CITY
FROM TRAVEL_LOCATION tl
JOIN TRAVEL_GROUP tg ON tl.LOC_ID = tg.DEST_ID
JOIN ACCOMMODATION a ON a.ACC_ID IN (
    SELECT ACC_ID
    FROM EMPLOYEE e
    WHERE e.ACC_ID = a.ACC_ID
)
JOIN REVIEWS r ON tg.PASS_ID = r.PASS_ID
WHERE r.RATING = 5
  AND (a.FACILITIES LIKE '%Pool%' OR a.FACILITIES LIKE '%Spa%' OR a.FACILITIES LIKE '%WiFi%');

  
--4./*  Cruise Details with Source/Destination and Passenger Information*/ 

SELECT 
    c.CRUISE_NO,
    src.CITY AS DEPARTURE_CITY, src.COUNTRY AS DEPARTURE_COUNTRY,
    dest.CITY AS ARRIVAL_CITY, dest.COUNTRY AS ARRIVAL_COUNTRY,
    ct.CATEGORY, ct.PRICE,
    p.PASS_NAME, p.AGE, p.GENDER
FROM 
    CRUISE c
JOIN 
    TRAVEL_LOCATION src ON c.SOURCE_ID = src.LOC_ID
JOIN 
    TRAVEL_LOCATION dest ON c.DEST_ID = dest.LOC_ID
JOIN 
    CRUISE_TRANSPORT ct ON c.CRUISE_NO = ct.CRUISE_NO
JOIN 
    TRAVEL_GROUP tg ON src.LOC_ID = tg.SOURCE_ID
JOIN 
    PASSENGER p ON tg.PASS_ID = p.PASS_ID
WHERE 
    ct.CATEGORY IN ('SUITE', 'BALCONY');
	
--5. /*Popular Travel Routes*/

SELECT 
    src.CITY AS SOURCE_CITY, 
    dest.CITY AS DESTINATION_CITY,
    count(*) AS TRAVEL_COUNT
FROM 
    TRAVEL_GROUP tg
JOIN 
    TRAVEL_LOCATION src ON tg.SOURCE_ID = src.LOC_ID
JOIN 
    TRAVEL_LOCATION dest ON tg.DEST_ID = dest.LOC_ID
GROUP BY 
    src.CITY, dest.CITY
ORDER BY 
    TRAVEL_COUNT desc
LIMIT 5;


--6./*All passengers who traveled both by flight and cruise*/

SELECT DISTINCT p.PASS_NAME, tl.CITY AS Destination
FROM PASSENGER p
JOIN TRAVEL_GROUP tg ON p.PASS_ID = tg.PASS_ID
JOIN TRAVEL_LOCATION tl ON tg.DEST_ID = tl.LOC_ID
JOIN FLIGHT f ON f.DEST_ID = tl.LOC_ID
JOIN CRUISE c ON c.DEST_ID = tl.LOC_ID;

--7./*Top 5 accommodation types and facilities offered by accommodations*/
SELECT 
    a.ACC_TYPE,
    a.FACILITIES,
    COUNT(DISTINCT p.PASS_ID) AS Total_Passengers
FROM ACCOMMODATION a
JOIN EMPLOYEE e ON a.ACC_ID = e.ACC_ID
JOIN TRAVEL_GROUP tg ON 1 = 1
JOIN PASSENGER p ON tg.PASS_ID = p.PASS_ID
GROUP BY a.ACC_TYPE, a.FACILITIES
ORDER BY Total_Passengers DESC
LIMIT 5;


--8./*Top 3 categories of the cruise along with price and source_city and their destination city*/
SELECT 
    ct.CATEGORY,
    ct.PRICE,
    tl_src.CITY AS SOURCE_CITY,
    tl_dest.CITY AS DESTINATION
FROM CRUISE_TRANSPORT ct
JOIN CRUISE c ON ct.CRUISE_NO = c.CRUISE_NO
JOIN TRAVEL_LOCATION tl_src ON c.SOURCE_ID = tl_src.LOC_ID
JOIN TRAVEL_LOCATION tl_dest ON c.DEST_ID = tl_dest.LOC_ID
JOIN TRAVEL_GROUP tg ON tg.DEST_ID = c.DEST_ID
GROUP BY ct.CATEGORY, ct.PRICE, tl_src.CITY, tl_dest.CITY
LIMIT 3;


--9./*Which age group are using what type of payment method*/
SELECT 
    CASE 
        WHEN AGE < 20 THEN 'Teen'
        WHEN AGE BETWEEN 20 AND 30 THEN '20s'
        WHEN AGE BETWEEN 31 AND 40 THEN '30s'
        WHEN AGE BETWEEN 41 AND 50 THEN '40s'
        ELSE '50+'
    END AS  AgeGroup,
    PAY_TYPE,
    COUNT(*) AS PaymentCount
FROM PASSENGER p
JOIN PAYMENT py ON p.PASS_ID = py.PASS_ID
GROUP BY AgeGroup, PAY_TYPE
ORDER BY  AgeGroup;

--10./*List the passengers who paid exclusively with PayPal, submitted a non-empty review, and traveled using a flight. For each, show their review and the source and destination cities of the flight*/
SELECT 
    p.PASS_ID,
    p.PASS_NAME,
    dep.CITY AS source_city,
    arr.CITY AS destination_city,
    r.RATING,
    r.TEXT AS review
FROM 
    PASSENGER p
JOIN 
    TRAVEL_GROUP tg ON p.PASS_ID = tg.PASS_ID
JOIN 
    TRAVEL_LOCATION dep ON tg.SOURCE_ID = dep.LOC_ID
JOIN 
    TRAVEL_LOCATION arr ON tg.DEST_ID = arr.LOC_ID
JOIN 
    FLIGHT f ON tg.SOURCE_ID = f.SOURCE_ID AND tg.DEST_ID = f.DEST_ID
JOIN 
    PAYMENT py ON p.PASS_ID = py.PASS_ID
JOIN 
    REVIEWS r ON p.PASS_ID = r.PASS_ID
WHERE 
    py.PAY_TYPE = 'PayPal'
    AND r.RATING IS NOT NULL
    AND r.TEXT IS NOT NULL
    AND p.PASS_ID IN (
        SELECT PASS_ID 
        FROM PAYMENT 
        GROUP BY PASS_ID
        HAVING COUNT(DISTINCT PAY_TYPE) = 1 
           AND MIN(PAY_TYPE) = 'PayPal'
    )
ORDER BY 
    p.PASS_NAME;