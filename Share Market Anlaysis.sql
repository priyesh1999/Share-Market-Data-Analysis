create schema capstone2 ;
use capstone2;
/* Find the marketer capitalization of the company(from NASDAQ 100) 
from the IT industry which has a max value of ‘Last sale’.*/

SELECT 
    Symbol, name, `Market Cap`, `Last Sale`
FROM
    nasdaq
WHERE
    `Last Sale` IN (SELECT 
            MAX(`Last Sale`) AS max_last_sale
        FROM
            (SELECT 
                n.*, m.company, m.sector, m.subsector
            FROM
                nasdaq n, metrics m
            WHERE
                n.Symbol = m.Symbol) d
        WHERE
            d.sector = 'Information Technology');

/* Find the number of companies from each industry in Nasdaq 100 Market cap.xlsx.*/

SELECT 
    sector, COUNT(DISTINCT symbol) AS count_data
FROM
    (SELECT 
        n.*, m.company, m.sector, m.subsector
    FROM
        nasdaq n, metrics m
    WHERE
        n.Symbol = m.Symbol) merged
GROUP BY sector
ORDER BY count_data desc;

/* Find the top 5 companies according to market capitalization */

SELECT 
    Symbol, Name, `Market Cap`
FROM
    nasdaq
ORDER BY `Market Cap` DESC
LIMIT 5;

/* Create a table with different sectors and count of sub-sectors in each sector.*/

SELECT 
    sector, COUNT(DISTINCT subsector)
FROM
    metrics
GROUP BY sector;
