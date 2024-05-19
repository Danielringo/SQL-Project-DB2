-- Tugas dan Langkah
-- Sebagai seorang data analyst, kamu dimintai untuk menyediakan data dan analisa mengenai kondisi perusahaan bulan terakhir untuk dipresentasikan di townhall tersebut. (Asumsikan tahun yang sedang berjalan adalah tahun 2004).

-- Adapun hal yang akan direview adalah :

-- Bagaimana pertumbuhan penjualan saat ini?
-- Apakah jumlah customers xyz.com semakin bertambah ?
-- Dan seberapa banyak customers tersebut yang sudah melakukan transaksi?
-- Category produk apa saja yang paling banyak dibeli oleh customers?
-- Seberapa banyak customers yang tetap aktif bertransaksi?
-- Langkah yang akan dilakukan :

-- Menggunakan klausa “Select … From …” untuk mengambil data di database
-- Menggunakan klausa Where dan Operator untuk menfilter data
-- Menggunakan “group by”dan fungsi aggregat untuk aggregasi penjualan dan revenue
-- Menggunakan “order by” untuk mengurutkan data
-- Menggunakan “union” untuk menggabungkan tabel data penjualan
-- Menggunakan “date and time function” dan fungsi text untuk data manipulation
-- Menggunakan subquery untuk menyimpan hasil sementara untuk digunakan kembali dalam query.

 CREATE TABLE `orders_1` (
`orderNumber` int(11) DEFAULT NULL,
`orderDate` date DEFAULT NULL,
`requiredDate` date DEFAULT NULL,
`shippedDate` date DEFAULT NULL,
`status` varchar(50) DEFAULT NULL,
`customerID` int(11) DEFAULT NULL,
`productCode` varchar(50) DEFAULT NULL,
`quantity` int(11) DEFAULT NULL,
`priceeach` decimal(10,0) DEFAULT NULL
) ENGINE=InnoDB ;

INSERT INTO orders_1 (orderNumber, orderDate, requiredDate, shippedDate, status, customerID, productCode, quantity, priceeach)
VALUES
(1, '2021-01-01', '2021-01-07', '2021-01-05', 'Shipped', 1, 'PROD1', 10, 100),
(2, '2021-01-02', '2021-01-09', '2021-01-06', 'Shipped', 2, 'PROD2', 15, 200),
(3, '2021-01-03', '2021-01-10', '2021-01-07', 'Shipped', 3, 'PROD3', 20, 300),
(4, '2021-01-04', '2021-01-11', '2021-01-08', 'Shipped', 4, 'PROD4', 25, 400),
(5, '2021-01-05', '2021-01-12', '2021-01-09', 'Shipped', 5, 'PROD5', 30, 500),
(6, '2021-01-06', '2021-01-13', '2021-01-10', 'Shipped', 6, 'PROD6', 35, 600),
(7, '2021-01-07', '2021-01-14', '2021-01-11', 'Shipped', 7, 'PROD7', 40, 700),
(8, '2021-01-08', '2021-01-15', '2021-01-12', 'Shipped', 8, 'PROD8', 45, 800),
(9, '2021-01-09', '2021-01-16', '2021-01-13', 'Shipped', 9, 'PROD9', 50, 900),
(10, '2021-01-10', '2021-01-17', '2021-01-14', 'Shipped', 10, 'PROD10', 55, 1000),
(11, '2021-01-11', '2021-01-18', '2021-01-15', 'Shipped', 11, 'PROD11', 60, 1100),
(12, '2021-01-12', '2021-01-19', '2021-01-16', 'Shipped', 12, 'PROD12', 65, 1200),
(13, '2021-01-13', '2021-01-20', '2021-01-17', 'Shipped', 13, 'PROD13', 70, 1300),
(14, '2021-01-14', '2021-01-21', '2021-01-18', 'Shipped', 14, 'PROD14', 75, 1400),
(15, '2021-01-15', '2021-01-22', '2021-01-19', 'Shipped', 15, 'PROD15', 80, 1500),
(16, '2021-01-16', '2021-01-23', '2021-01-20', 'Shipped', 16, 'PROD16', 85, 1600),
(17, '2021-01-17', '2021-01-24', '2021-01-21', 'Shipped', 17, 'PROD17', 90, 1700),
(18, '2021-01-18', '2021-01-25', '2021-01-22', 'Shipped', 18, 'PROD18', 95, 1800),
(19, '2021-01-19', '2021-01-26', '2021-01-23', 'Shipped', 19, 'PROD19', 100, 1900),
(20, '2021-01-20', '2021-01-27', '2021-01-24', 'Shipped', 20, 'PROD20', 105, 2000);

CREATE TABLE `orders_2` (
`orderNumber` int(11) DEFAULT NULL,
`orderDate` date DEFAULT NULL,
`requiredDate` date DEFAULT NULL,
`shippedDate` date DEFAULT NULL,
`status` varchar(50) DEFAULT NULL,
`customerID` int(11) DEFAULT NULL,
`productCode` varchar(50) DEFAULT NULL,
 `quantity` int(11) DEFAULT NULL,
 `priceeach` decimal(10,0) DEFAULT NULL
) ENGINE=InnoDB;

INSERT INTO orders_2 (orderNumber, orderDate, requiredDate, shippedDate, status, customerID, productCode, quantity, priceeach)
VALUES
(21, '2021-02-01', '2021-02-08', '2021-02-04', 'Shipped', 21, 'PROD21', 10, 100),
(22, '2021-02-02', '2021-02-09', '2021-02-05', 'Shipped', 22, 'PROD22', 15, 200),
(23, '2021-02-03', '2021-02-10', '2021-02-06', 'Shipped', 23, 'PROD23', 20, 300),
(24, '2021-02-04', '2021-02-11', '2021-02-07', 'Shipped', 24, 'PROD24', 25, 400),
(25, '2021-02-05', '2021-02-12', '2021-02-08', 'Shipped', 25, 'PROD25', 30, 500),
(26, '2021-02-06', '2021-02-13', '2021-02-09', 'Shipped', 26, 'PROD26', 35, 600),
(27, '2021-02-07', '2021-02-14', '2021-02-10', 'Shipped', 27, 'PROD27', 40, 700),
(28, '2021-02-08', '2021-02-15', '2021-02-11', 'Shipped', 28, 'PROD28', 45, 800),
(29, '2021-02-09', '2021-02-16', '2021-02-12', 'Shipped', 29, 'PROD29', 50, 900),
(30, '2021-02-10', '2021-02-17', '2021-02-13', 'Shipped', 30, 'PROD30', 55, 1000),
(31, '2021-02-11', '2021-02-18', '2021-02-14', 'Shipped', 31, 'PROD31', 60, 1100),
(32, '2021-02-12', '2021-02-19', '2021-02-15', 'Shipped', 32, 'PROD32', 65, 1200),
(33, '2021-02-13', '2021-02-20', '2021-02-16', 'Shipped', 33, 'PROD33', 70, 1300),
(34, '2021-02-14', '2021-02-21', '2021-02-17', 'Shipped', 34, 'PROD34', 75, 1400),
(35, '2021-02-15', '2021-02-22', '2021-02-18', 'Shipped', 35, 'PROD35', 80, 1500),
(36, '2021-02-16', '2021-02-23', '2021-02-19', 'Shipped', 36, 'PROD36', 85, 1600),
(37, '2021-02-17', '2021-02-24', '2021-02-20', 'Shipped', 37, 'PROD37', 90, 1700),
(38, '2021-02-18', '2021-02-25', '2021-02-21', 'Shipped', 38, 'PROD38', 95, 1800),
(39, '2021-02-19', '2021-02-26', '2021-02-22', 'Shipped', 39, 'PROD39', 100, 1900),
(40, '2021-02-20', '2021-02-27', '2021-02-23', 'Shipped', 40, 'PROD40', 105, 2000);

CREATE TABLE `customer` (
`customerID` int(11) DEFAULT NULL,
`customerName` varchar(50) DEFAULT NULL,
`contactLastName` varchar(50) DEFAULT NULL,
`contactFirstName` varchar(50) DEFAULT NULL,
`city` varchar(50) DEFAULT NULL,
`country` varchar(50) DEFAULT NULL,
`createDate` date DEFAULT NULL
) ENGINE=InnoDB;

INSERT INTO customer (customerID, customerName, contactLastName, contactFirstName, city, country, createDate)
VALUES
(103, 'Atelier graphique', 'Schmitt', 'Carine', 'Nantes', 'France', '2004-02-05'),
(112, 'Signal Gift Stores', 'King', 'Jean', 'Las Vegas', 'USA', '2004-02-05'),
(114, 'Australian Collectors, Co.', 'Ferguson', 'Peter', 'Melbourne', 'Australia', '2004-02-20'),
(119, 'La Rochelle Gifts', 'Labrune', 'Janine', 'Nantes', 'France', '2004-02-05'),
(121, 'Baane Mini Imports', 'Bergulfsen', 'Jonas', 'Stavern', 'Norway', '2004-02-05'),
(124, 'Mini Gifts Distributors Ltd.', 'Nelson', 'Susan', 'San Rafael', 'USA', '2004-03-11'),
(125, 'Havel & Zbyszek Co', 'Piestrzeniewicz', 'Zbyszek', 'Warszawa', 'Poland', '2004-02-05'),
(128, 'Blauer See Auto, Co.', 'Keitel', 'Roland', 'Frankfurt', 'Germany', '2004-03-15'),
(129, 'Mini Wheels Co.', 'Murphy', 'Julie', 'San Francisco', 'USA', '2004-02-05'),
(131, 'Land of Toys Inc.', 'Lee', 'Kwai', 'NYC', 'USA', '2004-05-07'),
(141, 'Euro+ Shopping Channel', 'Freyre', 'Diego', 'Madrid', 'Spain', '2004-01-16'),
(144, 'Volvo Model Replicas, Co.', 'Berglund', 'Christina', 'Lulea', 'Sweden', '2004-02-05'),
(145, 'Danish Wholesale Imports', 'Petersen', 'Jytte', 'Kobenhavn', 'Denmark', '2004-04-09'),
(146, 'Saveley & Henriot, Co.', 'Saveley', 'Mary', 'Lyon', 'France', '2004-01-02'),
(148, 'Dragon Souveniers, Ltd.', 'Natividad', 'Eric', 'Singapore', 'Singapore', '2004-02-05'),
(151, 'Muscle Machine Inc.', 'Young', 'Jeff', 'NYC', 'USA', '2004-02-05'),
(157, 'Diecast Classics Inc.', 'Leong', 'Kelvin', 'Allentown', 'USA', '2004-02-05'),
(161, 'Technics Stores Inc.', 'Hashimoto', 'Juri', 'Burlingame', 'USA', '2004-02-05'),
(166, 'Handji Gifts& Co.', 'Victorino', 'Wendy', 'Singapore', 'Singapore', '2004-02-04'),
(167, 'Herkku Gifts', 'Oeztan', 'Veysel', 'Bergen', 'Norway', '2004-02-05'),
(168, 'American Souvenirs Inc.', 'Franco', 'Keith', 'New Haven', 'USA', '2004-02-05'),
(169, 'Porto Imports Co.', 'de Castro', 'Isabel', 'Lisboa', 'Portugal', '2004-02-05'),
(170, 'Canadian Souvenirs, Ltd.', 'Peralta', 'Dorian', 'Toronto', 'Canada', '2004-02-05'),
(171, 'Rouen Gifts Inc.', 'Selim', 'Erol', 'Rouen', 'France', '2004-02-05'),
(172, 'Artist Import Inc.', 'Leong', 'Samuel', 'Sydney', 'Australia', '2004-02-05'),
(174, 'Exotic Mini Co.', 'Perham', 'Steven', 'Fremont', 'USA', '2004-02-05'),
(176, 'Vitac Corp.', 'Dinh', 'Ky', 'Pittsburgh', 'USA', '2004-02-05');


-- Mengecek tabel orders_1 :SELECT * FROM orders_1 limit 5;
-- Mengecek tabel orders_2 :SELECT * FROM orders_2 limit 5;
-- Mengecek tabel customer :SELECT * FROM customer limit 5;

SELECT * FROM orders_1 LIMIT 5;
SELECT * FROM orders_2 LIMIT 5;
SELECT * FROM customer LIMIT 5;

-- 1. Total Penjualan dan Revenue pada Quarter-1 (Jan, Feb, Mar) dan Quarter-2 (Apr,Mei,Jun)
-- Dari tabel orders_1 lakukan penjumlahan pada kolom quantity dengan fungsi aggregate sum() dan beri nama “total_penjualan”, kalikan kolom quantity dengan kolom priceEach kemudian jumlahkan hasil perkalian kedua kolom tersebut dan beri nama “revenue”
-- Perusahaan hanya ingin menghitung penjualan dari produk yang terkirim saja, jadi kita perlu mem-filter kolom ‘status’ sehingga hanya menampilkan order dengan status “Shipped”.
-- Lakukan Langkah 1 & 2, untuk tabel orders_2.
SELECT  SUM(quantity) AS total_penjualan, 
SUM(priceEach * quantity) as revenue FROM orders_1 WHERE status = "Shipped";
SELECT SUM(quantity) AS total_penjualan, SUM(priceEach * quantity) as revenue
FROM orders_2 WHERE status = "Shipped";

-- 2.Menghitung persentasi keseluruhan penjualan Pilihlah kolom “orderNumber”, “status”, “quantity”, “priceEach” pada tabel orders_1, dan tambahkan kolom baru dengan nama “quarter” dan isi dengan value “1”. Lakukan yang sama dengan tabel orders_2, dan isi dengan value “2”, kemudian gabungkan kedua tabel tersebut.
-- Gunakan statement dari Langkah 1 sebagai subquery dan beri alias “tabel_a”.
-- Dari “tabel_a”, lakukan penjumlahan pada kolom “quantity” dengan fungsi aggregate sum() dan beri nama “total_penjualan”, dan kalikan kolom quantity dengan kolom priceEach kemudian jumlahkan hasil perkalian kedua kolom tersebut dan beri nama “revenue”
-- Filter kolom ‘status’ sehingga hanya menampilkan order dengan status “Shipped”.
-- Kelompokkan total_penjualan berdasarkan kolom “quarter”, dan jangan lupa menambahkan kolom ini pada bagian select.

SELECT quarter, SUM(quantity) AS total_penjualan, SUM(priceEach * quantity) as revenue
FROM (SELECT orderNumber, status, quantity, priceEach, '1' as quarter
FROM orders_1
UNION
SELECT orderNumber, status, quantity,priceEach, '2' as quarter
FROM orders_2) AS tabel_a
WHERE status = 'Shipped'
GROUP BY quarter;

-- Perhitungan Growth Penjualan dan Revenue
-- Untuk project ini, perhitungan pertumbuhan penjualan akan dilakukan secara manual menggunakan formula yang disediakan di bawah. 
-- Adapun perhitungan pertumbuhan penjualan dengan SQL dapat dilakukan menggunakan “window function” yang akan dibahas di materi DQLab berikutnya.
-- %Growth Penjualan = (6717 – 8694)/8694 = -22%
-- %Growth Revenue = (607548320 – 799579310)/ 799579310 = -24%

-- 3. Apakah jumlah customers semakin bertambah?
-- Penambahan jumlah customers dapat diukur dengan membandingkan total jumlah customers yang registrasi di periode saat ini dengan total jumlah customers yang registrasi diakhir periode sebelumnya.
-- Dari tabel customer, pilihlah kolom customerID, createDate dan tambahkan kolom baru dengan menggunakan fungsi QUARTER(…) untuk mengekstrak nilai quarter dari CreateDate dan beri nama “quarter”
-- Filter kolom “createDate” sehingga hanya menampilkan baris dengan createDate antara 1 Januari 2004 dan 30Juni 2004
-- Gunakan statement Langkah 1 & 2 sebagai subquery dengan alias tabel_b
-- Hitunglah jumlah unik customers à tidak ada duplikasi customers dan beri nama “total_customers”
-- Kelompokkan total_customer berdasarkan kolom “quarter”, dan jangan lupa menambahkan kolom ini pada bagian select.

SELECT quarter, COUNT(DISTINCT customerID) AS total_customers
FROM (SELECT customerID, createDate, quarter(createDate) AS quarter
     FROM customer
    WHERE createDate BETWEEN '2004-01-01' AND '2004-06-30') as tabel_b
    GROUP BY quarter;
    
    
-- 4.Seberapa banyak customers tersebut yang sudah melakukan transaksi?
-- Problem ini merupakan kelanjutan dari problem sebelumnya yaitu dari sejumlah customer yang registrasi di periode quarter-1 
-- dan quarter-2, berapa banyak yang sudah melakukan transaksi 
-- 1. Dari tabel customer, pilihlah kolom customerID, createDate dan tambahkan kolom baru dengan menggunakan fungsi QUARTER(…) 
-- untuk mengekstrak nilai quarter dari CreateDate dan beri nama “quarter”
-- 2. Filter kolom “createDate” sehingga hanya menampilkan baris dengan createDate antara 1 Januari 2004 dan 30 Juni 2004
-- 3. Gunakan statement Langkah A&B sebagai subquery dengan alias tabel_b
-- 4. Dari tabel orders_1 dan orders_2, pilihlah kolom customerID, gunakan DISTINCT untuk menghilangkan duplikasi, 
-- kemudian gabungkan dengan kedua tabel tersebut dengan UNION.
-- 5. Filter tabel_b dengan operator IN() menggunakan 'Select statement langkah 4' , 
-- sehingga hanya customerID yang pernah bertransaksi (customerID tercatat di tabel orders) yang diperhitungkan.
-- 6. Hitunglah jumlah unik customers (tidak ada duplikasi customers) di statement SELECT dan beri nama “total_customers”
-- 7. Kelompokkan total_customer berdasarkan kolom “quarter”, dan jangan lupa menambahkan kolom ini pada bagian select.

SELECT quarter, COUNT(DISTINCT customerID) AS total_customers
FROM (SELECT customerID, createDate, quarter(createDate) AS quarter
FROM customer
WHERE createDate BETWEEN '2004-01-01' AND '2004-06-30') AS tabel_b
	WHERE customerID IN (SELECT DISTINCT customerID FROM orders_1
				  UNION
  SELECT DISTINCT customerID FROM orders_2)
	GROUP BY quarter;
    
    
-- 5. Category produk apa saja yang paling banyak di-order oleh customers di Quarter-2?
-- Untuk mengetahui kategori produk yang paling banyak dibeli, 
-- maka dapat dilakukan dengan menghitung total order dan jumlah penjualan dari setiap kategori produk.

SELECT * FROM (SELECT categoryID, COUNT(DISTINCT orderNumber) AS total_order, SUM(quantity) AS total_penjualan
FROM ( SELECT productCode, orderNumber, quantity, status, LEFT(productCode,3) AS categoryID
FROM orders_2
WHERE status = "Shipped")
tabel_c
GROUP BY categoryID ) a ORDER BY total_order DESC; 

-- 6. Seberapa banyak customers yang tetap aktif bertransaksi setelah transaksi pertamanya?
-- Mengetahui seberapa banyak customers yang tetap aktif menunjukkan apakah xyz.com tetap digemari oleh customers untuk memesan kebutuhan bisnis mereka. 
-- Hal ini juga dapat menjadi dasar bagi tim product dan business untuk pengembangan product dan business kedepannya. 
-- Adapun metrik yang digunakan disebut retention cohort. Untuk project ini, kita akan menghitung retention dengan query SQL sederhana, 
-- sedangkan cara lain yaitu JOIN dan SELF JOIN akan dibahas dimateri selanjutnya :

#Menghitung total unik customers yang transaksi di quarter_1
SELECT COUNT(DISTINCT customerID) as total_customers FROM orders_1;
#output = 20
SELECT 1 AS quarter, (COUNT(DISTINCT customerID)*100 )/25 AS Q2 
FROM orders_1 WHERE customerID  IN (SELECT DISTINCT customerID FROM orders_2);

   