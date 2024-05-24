CREATE TABLE Hotel ( 
    HotelID INT PRIMARY KEY, 
    HotelName VARCHAR(255), 
    Location VARCHAR(255), 
    Address VARCHAR(255), 
    PhoneNumber VARCHAR(20), 
    Email VARCHAR(255), 
    Rating FLOAT, 
    Description TEXT, 
    NumberOfRooms INT 
);

CREATE TABLE FacilityCategory ( 
    CategoryID INT PRIMARY KEY, 
    Name VARCHAR(50), 
    Description TEXT 
);

CREATE TABLE EmployeeType ( 
    EmployeeTypeID INT PRIMARY KEY, 
    TypeName VARCHAR(50), 
    Description TEXT 
);

CREATE TABLE Customer ( 
    GuestID INT PRIMARY KEY, 
    FirstName VARCHAR(50), 
    LastName VARCHAR(50), 
    Address VARCHAR(255), 
    PhoneNumber VARCHAR(20), 
    Email VARCHAR(255), 
    Nationality VARCHAR(50), 
    PassportIDNumber VARCHAR(20) 
);

CREATE TABLE Restaurant ( 
    RestaurantID INT PRIMARY KEY, 
    RestaurantName VARCHAR(255), 
    Location VARCHAR(255), 
    Description TEXT, 
    HotelID INT,
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID)
);

CREATE TABLE MenuItem ( 
    ItemID INT PRIMARY KEY, 
    ItemName VARCHAR(255), 
    Description TEXT, 
    Price DECIMAL(10, 2), 
    RestaurantID INT, 
    HotelID INT, 
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID), 
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID) 
);

CREATE TABLE TransportationType ( 
    VehicleID INT PRIMARY KEY, 
    TypeName VARCHAR(50), 
    Number INT, 
    NumberOfSeating INT, 
    HotelID INT, 
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID) 
);

CREATE TABLE Facility ( 
    FacilityID INT PRIMARY KEY, 
    FacilityName VARCHAR(50), 
    Description TEXT, 
    AvailabilityStatus VARCHAR(20), 
    HotelID INT, 
    CategoryID INT, 
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID), 
    FOREIGN KEY (CategoryID) REFERENCES FacilityCategory(CategoryID) 
);

CREATE TABLE Supplier ( 
    SupplierID INT PRIMARY KEY, 
    SupplierName VARCHAR(255), 
    Address VARCHAR(255), 
    PhoneNumber VARCHAR(20), 
    Email VARCHAR(255) 
);

CREATE TABLE Inventory ( 
    ItemID INT PRIMARY KEY, 
    ItemName VARCHAR(255), 
    Description TEXT, 
    Quantity INT, 
    Location VARCHAR(255), 
    HotelID INT, 
    SupplierID INT, 
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID), 
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID) 
);

CREATE TABLE Room ( 
    RoomNumber INT PRIMARY KEY, 
    RoomType VARCHAR(50), 
    BedType VARCHAR(50), 
    RatePerNight DECIMAL(10, 2), 
    AvailabilityStatus VARCHAR(20), 
    Description TEXT, 
    HotelID INT, 
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID) 
);

CREATE TABLE Event ( 
    EventID INT PRIMARY KEY, 
    EventName VARCHAR(255), 
    EventDate DATE, 
    Location VARCHAR(255), 
    Description TEXT, 
    HotelID INT, 
    FacilityID INT, 
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID), 
    FOREIGN KEY (FacilityID) REFERENCES Facility(FacilityID) 
);

CREATE TABLE SecurityCamera ( 
    CameraID INT PRIMARY KEY, 
    Location VARCHAR(255), 
    CameraType VARCHAR(50), 
    Description TEXT, 
    HotelID INT,
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID)
);

CREATE TABLE Rating ( 
    RatingID INT PRIMARY KEY, 
    RatingValue INT, 
    Review TEXT, 
    HotelID INT, 
    GuestID INT, 
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID), 
    FOREIGN KEY (GuestID) REFERENCES Customer(GuestID) 
);

CREATE TABLE Billing ( 
    BillingID INT PRIMARY KEY, 
    BillingDate DATE, 
    TotalAmount DECIMAL(10, 2) 
);

CREATE TABLE Promotion ( 
    PromotionID INT PRIMARY KEY, 
    PromoCode VARCHAR(50), 
    ValidityDate DATE, 
    Description TEXT, 
    HotelID INT,
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID)
);

CREATE TABLE Reservation ( 
    ReservationID INT PRIMARY KEY, 
    CheckInDate DATE, 
    CheckOutDate DATE, 
    NumberOfAdults INT, 
    NumberOfChildren INT, 
    SpecialRequests TEXT, 
    Status VARCHAR(20), 
    RoomNumber INT, 
    GuestID INT, 
    BillingID INT, 
    PromotionID INT, 
    FOREIGN KEY (RoomNumber) REFERENCES Room(RoomNumber), 
    FOREIGN KEY (GuestID) REFERENCES Customer(GuestID), 
    FOREIGN KEY (BillingID) REFERENCES Billing(BillingID), 
    FOREIGN KEY (PromotionID) REFERENCES Promotion(PromotionID) 
);

CREATE TABLE Employee ( 
    EmployeeID INT PRIMARY KEY, 
    FirstName VARCHAR(50), 
    LastName VARCHAR(50), 
    Position VARCHAR(50), 
    Department VARCHAR(50), 
    PhoneNumber VARCHAR(20), 
    Email VARCHAR(255), 
    HireDate DATE, 
    Salary DECIMAL(10, 2), 
    HotelID INT, 
    EmployeeTypeID INT, 
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID), 
    FOREIGN KEY (EmployeeTypeID) REFERENCES EmployeeType(EmployeeTypeID) 
);

CREATE TABLE PaymentMethod ( 
    PaymentID INT PRIMARY KEY, 
    PaymentDate DATE, 
    PaymentMethod VARCHAR(50), 
    Status VARCHAR(20), 
    BillingID INT, 
    FOREIGN KEY (BillingID) REFERENCES Billing(BillingID) 
);

CREATE TABLE Invoice ( 
    InvoiceID INT PRIMARY KEY, 
    InvoiceDate DATE, 
    TaxInformation TEXT, 
    Discounts DECIMAL(10, 2), 
    TotalAmount DECIMAL(10, 2), 
    ReservationID INT, 
    FOREIGN KEY (ReservationID) REFERENCES Reservation(ReservationID) 
);

CREATE TABLE EmployeeShift ( 
    ShiftID INT PRIMARY KEY, 
    ShiftDate DATE, 
    ShiftStartTime TIME, 
    ShiftEndTime TIME, 
    EmployeeID INT, 
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID) 
);

CREATE TABLE EmployeePayroll ( 
    PayrollID INT PRIMARY KEY, 
    PayrollDate DATE, 
    SalaryAmount DECIMAL(10, 2), 
    EmployeeID INT, 
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID) 
);

CREATE TABLE LostAndFound ( 
    LostAndFoundID INT PRIMARY KEY, 
    ItemName VARCHAR(255), 
    Description TEXT, 
    LocationFound VARCHAR(255), 
    Status VARCHAR(20), 
    HotelID INT,
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID)
);

