CREATE DATABASE inventory;
USE inventory;
CREATE TABLE Products (
    P_CODE VARCHAR(10) PRIMARY KEY,
    P_DESCRIPT VARCHAR(35) NOT NULL,
    P_INDATE DATE NOT NULL,
    P_ONHAND INT NOT NULL,
    P_MIN INT NOT NULL,
    P_PRICE DECIMAL(8,2) NOT NULL,
    P_DISCOUNT DECIMAL(5,2) NOT NULL,
    V_CODE INT
);

CREATE TABLE vendorsACode (
    V_AREACODE INT PRIMARY KEY,
    V_AREACODENAME VARCHAR(15) NOT NULL
);

CREATE TABLE vendors (
    V_CODE INT PRIMARY KEY,
    V_NAME VARCHAR(30) NOT NULL,
    V_CONTACT VARCHAR(30) NOT NULL,
    V_AREACODE INT, 
    V_PHONE VARCHAR(12) NOT NULL,
    V_STATE VARCHAR(3)  NOT NULL,
    V_ORDER VARCHAR(1)
);

ALTER TABLE Products
ADD CONSTRAINT FK_VCode
FOREIGN KEY (V_CODE) REFERENCES vendors(V_CODE)
ON UPDATE CASCADE
ON DELETE NO ACTION;

ALTER TABLE vendors
ADD CONSTRAINT FK_VAreaCode
FOREIGN KEY (V_AREACODE) REFERENCES vendorsACode(V_AREACODE)
ON UPDATE CASCADE
ON DELETE NO ACTION;

ALTER TABLE vendors
ADD CONSTRAINT CHK_VORDER CHECK (V_ORDER in ('Y', 'N'));

ALTER TABLE vendorsACode
ADD CONSTRAINT UC_AREACODENAME UNIQUE (V_AREACODENAME);

INSERT INTO vendorsACode VALUES (615, 'AC'), 
(904, 'SF'), 
(901, 'MAG');

INSERT INTO vendors VALUES
(21225, 'Bryson,Inc.', 'Smithson', 615, '223-3234', 'TN', 'Y'),
(21226, 'SuperLoo,Inc.', 'Flushing', 904, '215-8995', 'FL', 'N'),
(21227, 'Bryson,Inc.', 'RASEL', 615, '223-3235', 'TN', 'Y'),
(21231, 'D&E Supply', 'Singh', 615, '228-3245', 'TN', 'Y'),
(21344, 'Gomez Bros.', 'Ortega', 615, '889-2546', 'KY', 'N'),
(22567, 'Dome Supply', 'Smith', 901, '678-1419', 'GA', 'N'),
(23119, 'Randsets Ltd.', 'Anderson', 901, '678-3998', 'GA', 'Y'),
(24004, 'Brackman', 'Browning', 615, '228-1410', 'TN', 'N'),
(24288, 'ORDVA,Inc.', 'Hakford', 615, '898-1234', 'TN', 'Y'),
(25443, 'B&K Inc.', 'Smith', 904, '227-0093', 'FL', 'N'),
(25501, 'Damal Supplies', 'Smythe', 615, '890-3529', 'TN', 'N'),
(25595, 'Rubicon Sis.', 'Orton', 904, '456-0092', 'FL', 'Y');

INSERT INTO Products VALUES
('111111', 'PAKO', '2002-01-17', 10, 2, '100.00', '0.00', 21227),
('11QER/31', 'SHAMOO', '2001-12-03', 8, 5, '109.99', '0.00', 25595),
('13-Q2/P2', '7.25-in pwr,saw blade', '2002-01-13', 32, 15, '14.99', '0.05', 21344),
('14-Q1/L3', '9.00-in pwr, saw blade', '2002-01-13', 18, 12, '17.49', '0.00', 21344),
('1546-qq2', 'Hrd. cloth,1/4-in.2x50', '2001-12-15', 15, 8, '39.95', '0.00', 23119),
('1558-QW1', 'Hrd. cloth, 1/2-in., 3x50', '2002-01-15', 23, 5, '43.99', '0.00', 23119),
('2232/QTY', 'B&D Jigsaw, 12-in. blade', '2001-12-30', 8, 5, '109.92', '0.05', 24288),
('2232/QWE', 'B&D Jigsaw, 8-in. blade', '2002-01-24', 6, 5, '99.87', '0.05', 24288),
('2238/QPD', 'B&D Cordless Drill,12-in. blade', '2001-11-20', 12, 5, '38.95', '0.05', 25595),
('23109-HB', 'Claw Hammer', '2002-01-20', 23, 10, '5.95', '0.10', 21225),
('54778-2T', 'Rat tail-file, 1/8-in fine', '2002-01-15', 43, 20, '4.99', '0.00', 21344),
('89-WRE-Q', 'Hitcut chain saw, 16in.', '2001-12-07', 11, 5, '256.99', '0.05', 24288),
('SM-18277', '1.25-in. metal screw, 50', '2001-12-29', 172, 75, '6.99', '0.00', 21225),
('SW-23116', '2.5-in. wd.screw, 50', '2001-12-24', 237, 100, '8.45', '0.00', 21231),
('WR3/TT3', 'Steel Matting', '2001-01-17', 18, 5, '119.95', '0.10', 25595);

CREATE VIEW View_Products_From_2002 AS
SELECT 
    v.v_code AS vendor_code,
    v.v_name AS vendor_name,
    p.p_descript,
    p.p_indate
FROM 
    vendors v
JOIN 
    products p ON v.v_code = p.v_code
WHERE 
    YEAR(p.p_indate) >= 2002;
    
CREATE VIEW View_Products_Price_Range AS
SELECT 
    p_code,
    p_descript,
    p_price
FROM 
    products
WHERE 
    p_price BETWEEN 100 AND 150;

CREATE VIEW View_Total_Price_By_Vendor AS
SELECT 
    p.p_code,
    p.p_descript,
    p.p_onhand,
    p.p_price,
    (p.p_onhand * p.p_price) AS total_price,
    p.v_code
FROM 
    products p
WHERE 
    p.v_code IN (21344, 23119, 24288);
    
DELIMITER //

CREATE PROCEDURE UpdateVendorName()
BEGIN
    UPDATE vendors
    SET v_name = 'Bryson and Co'
    WHERE v_name = 'Bryson,Inc.';
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION GetProductInfoString (
    v_code INT,
    v_state VARCHAR(50)
) 
RETURNS TEXT
DETERMINISTIC
BEGIN
    DECLARE product_info TEXT DEFAULT '';
    
    SELECT GROUP_CONCAT(CONCAT(p.p_descript, ' ($', p.p_price, ')') SEPARATOR ', ')
    INTO product_info
    FROM products p
    JOIN vendors v ON p.v_code = v.v_code
    WHERE v.v_code = v_code AND v.v_state = v_state;

    RETURN product_info;
END //

DELIMITER ;

SELECT * FROM View_Products_From_2002;
SELECT * FROM View_Products_Price_Range;
SELECT * FROM View_Total_Price_By_Vendor;
SELECT * FROM vendors WHERE v_name = 'Bryson and Co.';
SELECT GetProductInfoString(21344, 'CA');
