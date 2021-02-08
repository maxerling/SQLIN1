-- Lista antalet produkter per kategori. Listningen ska innehålla kategori-namn och antalet produkter.  
-- Category.name | amount in each cateogry Sneakers,2 Running,2 Dress,2 Boots,1 Sandals,1 
SELECT category.name Category_Name, COUNT(shoeid) Amount_Of_Shoes FROM category
LEFT JOIN shoecategory ON category.id = shoecategory.categoryid
GROUP BY category.name
ORDER BY Amount_Of_Shoes DESC;

-- • Skapa en kundlista med den totala summan pengar som varje kund har handlat för. Kundens för- och efternamn, samt det totala värdet som varje person har shoppats för, skall visas.

 
SELECT customer.first_name, customer.last_name, sum(shoe.price) sum_price FROM customer
JOIN invoice ON customer.id = invoice.customerid
JOIN shoeinvoice ON invoice.id = shoeinvoice.invoiceid
JOIN shoe ON shoeinvoice.shoeid = shoe.id
GROUP BY invoice.customerid
ORDER BY sum_price DESC;


-- Vilka kunder har köpt lila sneakers i storlek 45 av märket Nike? Lista deras namn. (Vilka kunder har köpt svarta sandaler i storlek 38 av märket Ecco? Lista deras namn.)
-- name Loutitia Middas, Clara Ellingsworth -- cateogry
SELECT DISTINCT first_name, last_name FROM customer
JOIN invoice ON customer.id = invoice.customerid
JOIN shoeinvoice ON invoice.id = shoeinvoice.invoiceid
JOIN shoe ON shoeinvoice.shoeid = shoe.id
JOIN shoecategory ON shoe.id = shoecategory.shoeid
JOIN category ON shoecategory.categoryid = category.id
JOIN brand ON shoe.brandid = brandid
WHERE category.name = 'Sneakers' and shoe.color = 'Purple' and shoe.size = 45 and brand.name = 'Nike';


/*Skriv ut en lista på det totala beställningsvärdet per ort där beställningsvärdet är större än 1000 kr. Ortnamn och värde ska visas. 
(det måste finnas orter i databasen där det har handlats för mindre än 1000 kr för att visa att frågan är korrekt formulerad)*/
-- city|price > 1000
SELECT customer.city, sum(shoe.price) SUM_PRICE FROM customer
JOIN invoice ON customer.id = invoice.customerid
JOIN shoeinvoice ON invoice.id = shoeinvoice.invoiceid
JOIN shoe ON shoeinvoice.shoeid = shoe.id
GROUP BY customer.city
HAVING SUM_PRICE  > 1000
ORDER BY SUM_PRICE DESC;


-- Skapa en topp-5 lista av de mest sålda produkterna. 
SELECT shoe.name, count(shoe.id) sales FROM shoe
JOIN shoeinvoice ON shoe.id = shoeinvoice.shoeid
GROUP BY shoe.id
ORDER BY sales DESC
LIMIT 5;




-- Vilken månad hade du den största försäljningen? (det måste finnas data som anger försäljning för mer än en månad i databasen för att visa att frågan är korrekt formulerad)
SELECT  YEAR(invoice.date) YEAR,MONTH(invoice.date) MONTH, sum(shoe.price) SUM FROM invoice
JOIN shoeinvoice ON invoice.id = shoeinvoice.invoiceid
JOIN shoe ON shoeinvoice.shoeid = shoe.id
GROUP BY YEAR,MONTH
ORDER BY SUM DESC;
-- LIMIT 1