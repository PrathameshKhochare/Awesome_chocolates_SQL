show tables;
desc sales
# 1. Print details of shipments (sales) where amounts are > 2,000 and boxes are <100?
select * from sales
where amount > 2000 and boxes <100

# 2. How many shipments (sales) each of the sales persons had in the month of January 2022?
select p.salesperson , count(*) from sales s
join people p on s.spid = p.spid
where s.saledate in ('2022-01-01' , '2022-01-31')
group by p.salesperson
order by salesperson

#3. Which product sells more boxes? Milk Bars or Eclairs?
select distinct Product, sum(boxes) as 'max-sum' from sales s
join products pr on s.pid = pr.pid 
where pr.product in ('Milk','Eclairs')
group by pr.product

# 4. Which product sold more boxes in the first 7 days of February 2022? Milk Bars or Eclairs?
select distinct product, sum(boxes) as 'max-sum' from sales s
join products pr on s.pid = pr.pid
where s.saledate in ('2022-01-01' ,'2022-01-07') and pr.product in ('Milk','Eclairs')
group by pr.product;

# 5. Which shipments had under 100 customers & under 100 boxes? Did any of them occur on Wednesday?
select *,
case when weekday(saledate) = 2 then 'Wednesday-shipment'
else ''
end as 'W shipment'
 from sales 
where customers <100 and Boxes < 100 ;
 
 # What are the names of salespersons who had at least one shipment (sale) in the first 7 days of January 2022?
select distinct p.Salesperson from sales s
 join people p on s.spid = p.SPID
 where s.SaleDate between '2022-01-01' and '2022-01-07';


 
# 2. Which salespersons did not make any shipments in the first 7 days of January 2022?
select distinct p.salesperson from people p
where p.SPID not in 
                ( select s.spid from sales s where s.SaleDate between '2022-01-01' and '2022-01-07');
                
                
# 3.How many times we shipped more than 1,000 boxes in each month?
select year(saledate) as 'Year' , month(SaleDate) as 'Month' , count(*) from sales 
where boxes > 1000 
group by year(SaleDate),month(saledate)  
order by year(SaleDate),month(saledate)   

# 4. Did we ship at least one box of ‘After Nines’ to ‘New Zealand’ on all the months?
select * from geo       
 select * from products    
 
set @product_name = 'After Nines';
set @country_name = 'New Zealand';

 select year(s.saledate) as'Year', month(s.saledate) as 'Month',
 if (sum(s.boxes)>1 ,'yes','no') as 'Status' from sales s 
 join products pr on s.pid = pr.pid
 join geo g on s.geoid = g.geoid
 where pr.Product = @product_name and g.geo = @country_name
 group by Year(s.saledate), Month(s.saledate)
 order by Year(s.saledate), Month(s.saledate) 
       
# 5. India or Australia? Who buys more chocolate boxes on a monthly basis?

select year(saledate) 'Year', month(saledate) 'Month',
sum(CASE WHEN g.geo='India' = 1 THEN boxes ELSE 0 END) 'India Boxes',
sum(CASE WHEN g.geo='Australia' = 1 THEN boxes ELSE 0 END) 'Australia Boxes'
from sales s
join geo g on g.GeoID=s.GeoID
group by year(saledate), month(saledate)
order by year(saledate), month(saledate);
