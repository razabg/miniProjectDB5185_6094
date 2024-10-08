﻿--orderdetails - new with order id primary key, orders - without product-id ,include products differnt key ref maybe need to delete. change description to information
-- הקשר שאין להם טבלאות הם עם חץ עגול זאת אומרת מי שבכיוון הנגדי של החץ העגול יהיה את המפתח של הצד השני

CREATE TABLE Sellers ( 
  seller_name VARCHAR2(20) NOT NULL, 
  seller_id INT NOT NULL,
  phone VARCHAR2(20) NOT NULL, 
  address VARCHAR2(30) NOT NULL, 
  PRIMARY KEY (seller_id)
);

CREATE TABLE Categories ( 
  category_id INT NOT NULL,
  category_name VARCHAR2(35) NOT NULL, 
  information VARCHAR2(50),
  PRIMARY KEY (category_id)
);

CREATE TABLE OrderDetails (
  order_id INT NOT NULL,
  delivery_method VARCHAR2(20) NOT NULL,
  tracking_number VARCHAR2(20) NOT NULL,
  PRIMARY KEY (order_id),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id)
  
);

CREATE TABLE Buyers ( 
  buyer_id INT NOT NULL,
  buyer_name VARCHAR2(200) NOT NULL, 
  email VARCHAR2(255) NOT NULL, 
  phone VARCHAR2(20) NOT NULL, 
  address VARCHAR2(200) NOT NULL, 
  PRIMARY KEY (buyer_id)
);

CREATE TABLE Products ( 
  product_id INT NOT NULL,
  product_name VARCHAR2(200) NOT NULL, 
  status VARCHAR2(20), 
  price NUMBER(10,2) NOT NULL, -- Use NUMBER for price with precision (10) and scale (2)
  category_id INT NOT NULL,
  stock INT ,
  available_date date,
  PRIMARY KEY (product_id),
  FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Orders ( 
  order_id INT NOT NULL,
  order_date DATE NOT NULL, 
  buyer_id INT NOT NULL,
  PRIMARY KEY (order_id),
  FOREIGN KEY (buyer_id) REFERENCES Buyers(buyer_id)
);



CREATE TABLE Reviews ( 
  review_id INT NOT NULL,
  rating NUMBER(10,1), -- Use NUMBER for rating with precision (10) and scale (1)
  comment_text VARCHAR2(2000), 
  review_date DATE NOT NULL, 
  product_id INT NOT NULL,
  buyer_id INT NOT NULL,
  PRIMARY KEY (review_id),
  FOREIGN KEY (product_id) REFERENCES Products(product_id),
  FOREIGN KEY (buyer_id) REFERENCES Buyers(buyer_id)
);

CREATE TABLE sell (
  seller_id INT NOT NULL,
  product_id INT NOT NULL,
  PRIMARY KEY (seller_id, product_id),
  FOREIGN KEY (seller_id) REFERENCES Sellers(seller_id),
  FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE include_products (
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT not null,
  PRIMARY KEY (order_id, product_id),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
  
  
);
