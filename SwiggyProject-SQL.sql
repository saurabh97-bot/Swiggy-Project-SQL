create database SwiggySql;
Use SwiggySql;

-- Create Users table to store information about users (customers and delivery agents.)
CREATE TABLE Users (
   UserID int primary key,
   Username varchar(90) NOT NULL,
   UserType varchar(90) NOT NULL CHECK (UserType IN ('Customer','DeliveryAgent')),
   PhoneNumber varchar(15) NOT NULL,
   Email varchar(50),
   Password varchar(255) NOT NULL
);

-- Create Restaurants table to store information about restaurants
CREATE TABLE Restaurants (
   RestaurantID INT primary key,
   RestaurantName varchar(100) NOT NULL,
   CuisineType varchar(50) NOT NULL,
   Location varchar(100) NOT NULL,
   PhoneNumber varchar(15) NOT NULL
);

-- Create the MenuItems table to store information about the menu items
CREATE TABLE MenuItems (
   MenuItemID INT primary key,
   RestaurantID INT,
   ItemName varchar(100) NOT NULL,
   Price Decimal (10,2) NOT NULL,
   Description TEXT,
   foreign key (RestaurantID) references Restaurants(RestaurantID)
   );
   
-- Create the Orders table to store information about customers orders
CREATE TABLE Orders (
   OrderID int primary key,
   UserID int,
   RestaurantID int,
   OrderDate timestamp default current_timestamp,
   DeliveryAddress varchar(255) NOT NULL,
   OrderStatus varchar(20) NOT NULL CHECK (OrderStatus IN ('Placed','Confirmed','InTransit','Delivered')),
   Foreign key (UserID) references Users(UserID),
   Foreign key	(RestaurantID) references Restaurants(RestaurantID)
   );
   
-- Create the OrderItems table to store information about items in each order
CREATE TABLE OrderItems (
   OrderItemID int primary key,
   OrderID int,
   MenuItemID int,
   Quantity int NOT NULL,
   Subtotal decimal(10,2) NOT NULL,
   foreign key (OrderID) references Orders(OrderID),
   foreign key (MenuItemID) references MenuItems(MenuItemID)
   );
   
-- Create the Reviews table to store reviews/ratings for restaurants
CREATE TABLE Reviews (
   ReviewID int primary key,
   UserID int,
   RestaurantID int,
   rating int NOT NULL CHECK (Rating >=  1 AND Rating <= 5),
   Comment Text,
   ReviewDate timestamp default current_timestamp,
   foreign key (UserID) references Users(UserID),
   foreign key (RestaurantID) references Restaurants(RestaurantID)
   );
   
##====================INSERTING DATA INTO THE TABLE===============##

-- Insert data into the Users table
INSERT INTO Users (UserID, Username, UserType, PhoneNumber, Email, Password)
VALUES
(1,'RajPatel','Customer','9876543211','raj.patel@gmail.com','securepwd'),
(2,'PreetiSharma','Customer','8765432109','preeti.sharma@yahoo.com','strongpass'),
(3,'DeliveryRider2','DeliveryAgent','7654321098',NULL,'delivery456'),
(4,'AmitSingh','Customer','9988776655','amit.singh@email.com','secure123'),
(5,'NehaVerma','Customer','8877665544','neha.verma@gmail.com','strongpwd'),
(6,'DeliveryRider3','DeliveryAgent','7766554433',NULL,'delivery789'),
(7,'SanyaGupta','Customer','6655443322','sanya.gupta@google.com','Sanya123'),
(8,'VikramYadav','Customer','5544332211','vikram.yadav@gmail.com','Vikram123'),
(9,'PriyaMalhotra','Customer','8765432101','Priya1997@gmail.com','Priya1997'),
(10,'RajeevKumar','Customer','7654321092','KumarRajeev@gmail.com','Rajeev@123');

-- Insert data into the Restaurants Table
INSERT INTO Restaurants (RestaurantID, RestaurantName, CuisineType, Location, PhoneNumber)
VALUES
(101,'Spices of India','Indian','789 Curry Lane, Spice City','111-222-3334'),
(102,'Tandoori Delights','Indian','456 Naan Street, Masala Town','444-555-6667'),
(103,'Saravana Bhavan','South Indian','321 Dosa Avenue, Chutney Village','777-888-9999'),
(104,'Paneer Palace','North Indian','987 Roti Road, Gravy Town','222-333-4444'),
(105,'Dhaba Delicacies','Punjabi','567 Paratha Street, Dal City','555-666-7777'),
(106,'Coastal Curry House','South Indian','432 Idli Lane, Sambar City','888-999-0000'),
(107,'Biryani Paradise','Hyderabadi','789 Spice Boulevard, Biryani City','333-444-5555'),
(108,'Chaat Corner','Street Food','567 Chaat Street, Snack Town','666-777-8888'),
(109,'Rajasthani Road','Rajastani','321 Desert Road, Thali Village','999-000-1111'),
(110,'Dosa Delight','South Indian','123 Masala Street, Sambhar Town','111-222-3355');

-- Insert Data into Menu Items Table
INSERT INTO MenuItems (MenuItemID, RestaurantID, ItemName, Price, Description)
VALUES
(301,101,'Butter Chicken',14.99,'Tender chicken cooked in rich buttery tomato sauce'),
(302,102,'Tandoori Chicken',12.99,'Marinated chicken grilled to perfection in a tandoor'),
(303,103,'Masala Dosa',8.49,'Crispy rice crepe filled with spiced potato filling'),
(304,104,'Paneer Tikka',10.99,'Marinated and grilled paneer cubes with spices'),
(305,105,'Amritsari Chole',9.99,'Chickpeas cooked in a tangy and spicy Punjabi style'),
(306,106,'Fish Curry',16.99,'Fish simmered in a flavorful South Indian curry'),
(307,107,'Hyderabadi Biryani',13.99,'Fragrant basmati rice cooked with aromatic spices and meat'),
(308,108,'Pani Puri',6.99,'Crunchy semolina balls filled with spicy tangy water'),
(309,109,'Dal Baati Churma',11.49,'Rajasthani dish comprising lentils, baked dough balls, and crushed wheat'),
(310,110,'Mysore Masala Dosa',9.99,'Spicy red chutney spread on dosa with potato filling');
   
-- Insert Data into orders table
INSERT INTO Orders (OrderID, UserID, RestaurantID, DeliveryAddress, OrderStatus)
VALUES
(401,1,101,'789 Curry Lane, Spice City','Confirmed'),
(402,2,102,'456 Naan Street, Masala Town','Placed'),
(403,3,103,'321 Dosa Avenue, Chutney Village','Delivered'),
(404,4,104,'987 Roti Road, Gravy Town','InTransit'),
(405,5,105,'567 Paratha Street, Dal City','Confirmed'),
(406,6,106,'432 Idli Lane, Sambar City','Delivered'),
(407,7,105,'567 Paratha Street, Dal City','Delivered'),
(408,8,110,'123 Masala Street, Sambhar Town','InTransit');


-- Insert Data into OrderItems
INSERT INTO OrderItems (OrderItemID, OrderID, MenuItemID, Quantity, Subtotal)
VALUES
(501,401,301,2,29.98),
(502,402,302,1,12.99),
(503,403,303,3,25.47),
(504,404,304,2,21.98),
(505,405,305,1,9.99),
(506,406,306,1,16.99);


-- Insert Data into Reviews Table
INSERT INTO Reviews (ReviewID, UserID, RestaurantID, Rating, Comment, ReviewDate)
VALUES
(601,3,103, 5,'Amazing food and great service!','2023-03-15 18:30:00'),
(602, 4, 104, 4,'Paneer Tikka was a bit too spicy for my liking.','2023-03-16 12:45:00'),
(603, 5, 103, 5,'Fantastic South Indian cuisine!','2023-03-17 20:15:00'),
(604, 6, 106, 3,'Fish Curry was average. Expected more flavor.','2023-03-18 14:20:00'),
(605, 7, 105, 5, 'Authentic Punjabi flavors! Loved the Chole.','2023-03-19 17:45:00'),
(606, 8, 106, 3, 'Lobster is good. I love it!!!','2023-03-20 11:10:00'),
(607, 3, 109, 4, 'Dal Baati Churma brought back memories of Rajasthan.','2023-03-21 19:30:00'),
(608, 4, 110, 5, 'Mysore Masala Dosa was good, but not exceptional.','2023-03-22 12:00:00');


## ========================RUNNING SOME SQL QUERIES======================= ##

-- 1.Retrieve all users:
SELECT * FROM Users;

-- 2.Retrieve all indian Restaurants:
SELECT * FROM Restaurants WHERE CuisineType LIKE 'Indian%';

-- 3.Retrieve all menu items for a specific restaurant (e.g., RestaurantID 103)
SELECT * FROM MenuItems WHERE RestaurantID = 103;

-- 4.Retrieve all orders along with their items
SELECT Orders.OrderID, Orders.UserID, Orders.RestaurantID, Orders.DeliveryAddress, Orders.OrderStatus, 
       OrderItems.MenuItemID, OrderItems.Quantity, OrderItems.Subtotal
FROM Orders
INNER JOIN OrderItems ON Orders.OrderID = OrderItems.OrderID;

-- 5.Retrieve all reviews with user and restaurant details
SELECT Reviews.ReviewID, Reviews.UserID, Users.UserName, Reviews.RestaurantID, Restaurants.RestaurantName,
       Reviews.Rating, Reviews.Comment, Reviews.ReviewDate
FROM Reviews
INNER JOIN Users ON Reviews.UserID = Users.UserID
INNER JOIN Restaurants ON Reviews.RestaurantID = Restaurants.RestaurantID;

-- 6.Calculate the average rating for each restaurant
SELECT RestaurantID, AVG(Rating) AS AverageRating
FROM Reviews
GROUP BY RestaurantID;

-- 7.Retrieve all orders with their associated user and restaurant information
SELECT Orders.OrderID, Users.UserName AS CustomerName, Restaurants.RestaurantName,
       Orders.DeliveryAddress, Orders.OrderStatus, Orders.OrderDate
FROM Orders
INNER JOIN Users ON Orders.UserID = Users.UserID
INNER JOIN Restaurants ON Orders.RestaurantID = Restaurants.RestaurantID;

-- 8.Find the total revenue generated by each restaurant (sum of order subtotals)
SELECT Orders.OrderID, Users.UserName AS CustomerName, Restaurants.RestaurantName,
       Orders.DeliveryAddress, Orders.OrderStatus, Orders.OrderDate
FROM Orders
INNER JOIN Users ON Orders.UserID = Users.UserID
INNER JOIN Restaurants ON Orders.RestaurantID = Restaurants.RestaurantID;

-- 9.Retrieve the top-rated restaurants along with their average ratings
SELECT Restaurants.RestaurantID, Restaurants.RestaurantName, AVG(Reviews.Rating) AS AverageRating
FROM Restaurants
LEFT JOIN Reviews ON Restaurants.RestaurantID = Reviews.RestaurantID
GROUP BY Restaurants.RestaurantID, Restaurants.RestaurantName
ORDER BY AverageRating DESC;

-- 10.Find the most ordered menu item across all orders
SELECT Orders.OrderID, MenuItems.MenuItemID, MenuItems.ItemName, OrderItems.Quantity
FROM Orders
JOIN OrderItems ON Orders.OrderID = OrderItems.OrderID
JOIN MenuItems ON OrderItems.MenuItemID = MenuItems.MenuItemID;

-- 11.Retrieve all customers who have placed orders
SELECT DISTINCT Users.UserID, Users.UserName
FROM Users
INNER JOIN Orders ON Users.UserID = Orders.UserID;
