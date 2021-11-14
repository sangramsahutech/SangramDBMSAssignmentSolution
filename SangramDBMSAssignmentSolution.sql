create database if not exists TravelOnTheGoService;
use TravelOnTheGoService;
CREATE TABLE if not exists PASSENGER (
    passenger_id INT auto_increment,
    passenger_name VARCHAR(20),
    gender VARCHAR(1),
    PRIMARY KEY (passenger_id)
);
CREATE TABLE IF NOT EXISTS BUS_SCHEDULE (
    bus_no INT AUTO_INCREMENT,
    boarding_city VARCHAR(20),
    destination_city VARCHAR(20),
    distance INT,
    bus_type VARCHAR(20),
    PRIMARY KEY (bus_no)
);
CREATE TABLE IF NOT EXISTS BOOKING_DETAILS (
    ticket_no INT auto_increment,
    passenger_id INT,
    bus_no int,
    PRIMARY KEY (ticket_no),
    FOREIGN KEY (passenger_id)
        REFERENCES PASSENGER (passenger_id),
    FOREIGN KEY (bus_no)
        REFERENCES BUS_schedule (bus_no)
);
drop table price;
CREATE TABLE IF NOT EXISTS PRICE (
    bus_type varchar(20),
	distance int,
    price INT,
    season VARCHAR(20),
    PRIMARY KEY (bus_type, distance, season)
);
insert into passenger(passenger_name, gender) values('Sejal','F');
insert into passenger(passenger_name, gender) values('Anmol','M');
insert into passenger(passenger_name, gender) values('Pallavi','F');
insert into passenger(passenger_name, gender) values('Khusboo','F');
insert into passenger(passenger_name, gender) values('Udit','M');
insert into passenger(passenger_name, gender) values('Ankur','M');
insert into passenger(passenger_name, gender) values('Hemant','M');
insert into passenger(passenger_name, gender) values('Manish','M');
insert into passenger(passenger_name, gender) values('Piyush','M');
select * from passenger;

insert into booking_details(passenger_id, bus_no) values(1,1);
insert into booking_details(passenger_id, bus_no) values(2,2);
insert into booking_details(passenger_id, bus_no) values(3,3);
insert into booking_details(passenger_id, bus_no) values(4,4);
insert into booking_details(passenger_id, bus_no) values(5,5);
insert into booking_details(passenger_id, bus_no) values(6,6);
insert into booking_details(passenger_id, bus_no) values(7,7);
insert into booking_details(passenger_id, bus_no) values(8,8);
insert into booking_details(passenger_id, bus_no) values(9,9);
select * from booking_details;

insert into BUS_SCHEDULE(Boarding_City,Destination_City, Distance, Bus_Type) VALUES('Bengaluru','Chennai',350,'Sleeper');
insert into BUS_SCHEDULE(Boarding_City,Destination_City, Distance, Bus_Type) VALUES('Mumbai','Hyderabad',700,'Sitting');
insert into BUS_SCHEDULE(Boarding_City,Destination_City, Distance, Bus_Type) VALUES('Panaji','Bengaluru',600,'Sleeper');
insert into BUS_SCHEDULE(Boarding_City,Destination_City, Distance, Bus_Type) VALUES('Chennai','Mumbai',1500,'Sleeper');
insert into BUS_SCHEDULE(Boarding_City,Destination_City, Distance, Bus_Type) VALUES('Trivandrum','Panaji',1000,'Sleeper');
insert into BUS_SCHEDULE(Boarding_City,Destination_City, Distance, Bus_Type) VALUES('Nagpur','Hyderabad',500,'Sitting');
insert into BUS_SCHEDULE(Boarding_City,Destination_City, Distance, Bus_Type) VALUES('Panaji','Mumbai',700,'Sleeper');
insert into BUS_SCHEDULE(Boarding_City,Destination_City, Distance, Bus_Type) VALUES('Hyderabad','Bengaluru',500,'Sitting');
insert into BUS_SCHEDULE(Boarding_City,Destination_City, Distance, Bus_Type) VALUES('Pune','Nagpur',700,'Sitting');
SELECT * FROM BUS_SCHEDULE;

insert into price(bus_type, distance, price, season) values('Sleeper',350,770,'Festive');
insert into price(bus_type, distance, price, season) values('Sleeper',500,1100,'Festive');
insert into price(bus_type, distance, price, season) values('Sleeper',600,1320,'Festive');
insert into price(bus_type, distance, price, season) values('Sleeper',700,1540,'Festive');
insert into price(bus_type, distance, price, season) values('Sleeper',1000,2200,'Festive');
insert into price(bus_type, distance, price, season) values('Sleeper',1200,2640,'Festive');
insert into price(bus_type, distance, price, season) values('Sleeper',350,434,'Normal');
insert into price(bus_type, distance, price, season) values('Sitting',500,620,'Festive');
insert into price(bus_type, distance, price, season) values('Sitting',500,620,'Normal');
insert into price(bus_type, distance, price, season) values('Sitting',600,744,'Festive');
insert into price(bus_type, distance, price, season) values('Sitting',700,868,'Festive');
insert into price(bus_type, distance, price, season) values('Sitting',1000,1240,'Festive');
insert into price(bus_type, distance, price, season) values('Sitting',1200,1488,'Festive');
insert into price(bus_type, distance, price, season) values('Sitting',1500,1860,'Festive');
select * from price;

/* 3) How many females and how many male passengers travelled for a minimum distance of 
      600 KM s? */
	SELECT 
    p.gender, COUNT(1) AS count
FROM
    BOOKING_DETAILS b
        JOIN
    BUS_SCHEDULE bs ON b.bus_no = bs.bus_no
        JOIN
    PASSENGER p ON b.passenger_id = p.passenger_id
WHERE
    bs.distance >= 600
GROUP BY p.gender;

/* 4) Find the minimum ticket price for Sleeper Bus. */
SELECT 
    MIN(price)
FROM
    price
WHERE
    bus_type = 'Sleeper';
/* 5) Select passenger names whose names start with character 'S' */
SELECT 
    passenger_name
FROM
    passenger
WHERE
    passenger_name LIKE 'S%';

/* 6) Calculate price charged for each passenger displaying Passenger name, Boarding City,
Destination City, Bus_Type, Price in the output */
SELECT 
    p.passenger_name,
    b.boarding_city,
    b.destination_city,
    b.bus_type,
    pr.price
FROM
    bus_schedule b
        JOIN
    price pr ON b.bus_type = pr.bus_type
        AND b.distance = pr.distance
        JOIN
    booking_details bd ON bd.bus_no = b.bus_no
        JOIN
    passenger p ON p.passenger_id = bd.passenger_id
WHERE
    pr.season = 'Festive';

/* 7) What is the passenger name and his/her ticket price who travelled in Sitting bus for a
distance of 1000 KM s  */
SELECT 
    p.passenger_name, pr.price
FROM
    bus_schedule b
        JOIN
    price pr ON b.bus_type = pr.bus_type
        AND b.distance = pr.distance
        JOIN
    booking_details bd ON bd.bus_no = b.bus_no
        JOIN
    passenger p ON p.passenger_id = bd.passenger_id
WHERE
    b.distance = 1000;
        
/* 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
Panaji? */
SELECT 
    p1.bus_type, p1.price
FROM
    price p1
WHERE
    p1.distance = (SELECT 
            pr.distance
        FROM
            bus_schedule bs
                JOIN
            price pr ON bs.bus_type = pr.bus_type
                AND bs.distance = pr.distance
                JOIN
            booking_details bd ON bd.bus_no = bs.bus_no
                JOIN
            passenger p ON p.passenger_id = bd.passenger_id
        WHERE
            p.passenger_name = 'Pallavi');

/* 9) List the distances from the "Passenger" table which are unique (non-repeated
distances) in descending order. */
SELECT DISTINCT
    (distance)
FROM
    bus_schedule
ORDER BY distance DESC; 

/* 10) Display the passenger name and percentage of distance travelled by that passenger
from the total distance travelled by all passengers without using user variables. */
SELECT 
    p1.passenger_name,
    bs1.distance,
    bs1.distance * 100.0 / (SELECT 
            SUM(bs.distance)
        FROM
            passenger p
                JOIN
            booking_details bd ON p.passenger_id = bd.passenger_id
                JOIN
            bus_schedule bs ON bs.bus_no = bd.bus_no) AS percent_dist
FROM
    passenger p1
        JOIN
    booking_details bd1 ON p1.passenger_id = bd1.passenger_id
        JOIN
    bus_schedule bs1 ON bs1.bus_no = bd1.bus_no;
/* 11) Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise
 */
 SELECT 
    distance,
    price,
    season,
    CASE
        WHEN price > 1000 THEN 'Expensive'
        WHEN price BETWEEN 500 AND 1000 THEN 'Average Cost'
        ELSE 'Cheap'
    END AS remarks
FROM
    price;