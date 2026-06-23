CREATE TABLE IF NOT EXISTS EXPERTISE (
    Expertise_ID INTEGER PRIMARY KEY NOT NULL,
    Expertise_Name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS PERSONAL_GEEK_SQUAD_CONSULTANT (
    Employee_ID INTEGER PRIMARY KEY NOT NULL,
    First_Name TEXT NOT NULL,
    Last_Name TEXT NOT NULL,
    Date_of_Birth DATE,
    Specialization_Type TEXT,
    Certification_Level TEXT,
    Date_of_Hire DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS CONSULTANT_EXPERTISE (
    Employee_ID INTEGER NOT NULL,
    Expertise_ID INTEGER NOT NULL,
    PRIMARY KEY (Employee_ID, Expertise_ID),
    FOREIGN KEY (Employee_ID) REFERENCES PERSONAL_GEEK_SQUAD_CONSULTANT(Employee_ID),
    FOREIGN KEY (Expertise_ID) REFERENCES EXPERTISE(Expertise_ID)
);

CREATE TABLE IF NOT EXISTS CUSTOMER (
    Customer_ID INTEGER PRIMARY KEY NOT NULL,
    First_Name TEXT NOT NULL,
    Last_Name TEXT NOT NULL,
    Email_Address TEXT NOT NULL,
    Phone_Number TEXT,
    Home_Address TEXT,
    Employee_ID INTEGER NOT NULL,
    FOREIGN KEY (Employee_ID) REFERENCES PERSONAL_GEEK_SQUAD_CONSULTANT(Employee_ID)
);

CREATE TABLE IF NOT EXISTS SERVICE_TICKET (
    Ticket_ID INTEGER PRIMARY KEY NOT NULL,
    Date_Created DATE NOT NULL,
    Issue_Category TEXT,
    Problem_Description TEXT,
    Resolution_Notes TEXT,
    Status TEXT NOT NULL CHECK (Status IN ('Open', 'In-Progress', 'Resolved')),
    Customer_ID INTEGER NOT NULL,
    Employee_ID INTEGER NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID),
    FOREIGN KEY (Employee_ID) REFERENCES PERSONAL_GEEK_SQUAD_CONSULTANT(Employee_ID)
);

CREATE TABLE IF NOT EXISTS ORDER_TABLE (
    Order_Number INTEGER PRIMARY KEY NOT NULL,
    Order_Date DATE NOT NULL,
    Total_Amount REAL,
    Shipping_Method TEXT,
    Customer_ID INTEGER NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID)
);

CREATE TABLE IF NOT EXISTS PRODUCT (
    Product_ID INTEGER PRIMARY KEY NOT NULL,
    Model_Name TEXT NOT NULL,
    Manufacturer TEXT,
    Category TEXT,
    Unit_Price REAL NOT NULL CHECK (Unit_Price >= 0)
);

CREATE TABLE IF NOT EXISTS ORDER_PRODUCT (
    Order_Number INTEGER NOT NULL,
    Product_ID INTEGER NOT NULL,
    Quantity INTEGER NOT NULL CHECK (Quantity > 0),
    Unit_Price REAL NOT NULL,
    PRIMARY KEY (Order_Number, Product_ID),
    FOREIGN KEY (Order_Number) REFERENCES ORDER_TABLE(Order_Number),
    FOREIGN KEY (Product_ID) REFERENCES PRODUCT(Product_ID)
);

CREATE TABLE IF NOT EXISTS SUPPLIER (
    Supplier_ID INTEGER PRIMARY KEY NOT NULL,
    Company_Name TEXT NOT NULL,
    Contact_Name TEXT,
    Contact_Email TEXT,
    Contract_Status TEXT
);

CREATE TABLE IF NOT EXISTS SHIPMENT (
    Shipment_ID INTEGER PRIMARY KEY NOT NULL,
    Date_Shipped DATE,
    Estimated_Arrival DATE,
    Tracking_Number TEXT,
    Supplier_ID INTEGER NOT NULL,
    Customer_ID INTEGER NOT NULL,
    FOREIGN KEY (Supplier_ID) REFERENCES SUPPLIER(Supplier_ID),
    FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID)
);
