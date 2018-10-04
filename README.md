## Project Overview

**Elema** is the project for the course "Project Workshop of Database Systems" (CS357, SS2017) of SJTU. The aim of this project is to create a food-delivery system similiar to the Chinese webpage ["ele.me"](https://www.ele.me/home/). 

The system consists of a backend including a webserver hosting the webpage, an interface written in PHP and a MySQL database storing all information, as well as a webpage as the frontend. 

## How to Install

To install the system on the local machine, at first an Apache Webserver and a MySQL database as well as PHP must be installed. The contents of the directory "website" must be placed into the "www" (or "htdocs" in some cases) directory of the Apache server. The SQL script "elema.sql" in the directory "Database" must be executed on the MySQL server. It will create necessary databases, tables, users, views, constraints and triggers. The webpage can now be accessed over "http://localhost" and the admin panel over "http://localhost/control".

## Functional Requirements

### Customer

* A customer should be able to sign up his information to become a user in this system. Later he should be able to log in the system with his ID and password.

* A customer should be able to order food through this system, including inputing his location, selecting near restaurants, choosing desired dishes in the menu, placing the order and checking the state of the order.

* A customer should be able to see the progess of his orders on his profile page and comment his order by rating and writing comments.

### Restaurant

* A restaurant should be able to register as a food provider, log in the system and edit its information such as name, address and icon.

* A restaurant should be able to receive the orders placed by customers and change the state to "processing", "in delivery" and "completed".

* A restaurant should be able to manage its dishes, including adding new dishes, deleting old dishes and modifying the information of its meals.

## E/R Model

![](/Showcase/ERDiagram.jpg)

## Product Showcase

### Customer
| ![](/Showcase/Customer/1.png) | ![](/Showcase/Customer/2.png) |
|:---:|:---:|
| 1 | 2 |
![](/Showcase/Customer/3.png) ![](/Showcase/Customer/4.png)
![](/Showcase/Customer/5.png) ![](/Showcase/Customer/6.png)
![](/Showcase/Customer/7.png) ![](/Showcase/Customer/8.png)
![](/Showcase/Customer/9.png) ![](/Showcase/Customer/10.png)
![](/Showcase/Customer/11.png) ![](/Showcase/Customer/12.png)

### Restaurant
![](/Showcase/Restaurant/1.png) ![](/Showcase/Restaurant/2.png)
![](/Showcase/Restaurant/3.png) ![](/Showcase/Restaurant/4.png)  
