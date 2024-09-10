select sum(s.volumesold::decimal),ca.categoryname
from public.sales s join public.items i on i.itemid=s.itemnumber
join city ci on ci.zipcode=s.zipcode join 
public.county c1 on c1.countyid=ci.countynumber join category ca on ca.id=i.categoryid 
group by ca.categoryname
order by sum(s.volumesold::decimal) desc limit 10;

select sum(s.volumesold::decimal),ca.categoryname
from public.sales s join public.items i on i.itemid=s.itemnumber
join city ci on ci.zipcode=s.zipcode join 
public.county c1 on c1.countyid=ci.countynumber join category ca on ca.id=i.categoryid 
where c1.countyname='Polk' and s.date::text like '%2012%'
group by ca.categoryname, c1.countyname
order by sum(s.volumesold::decimal) desc limit 20;

select sum(s.statebottleretail::decimal),s.date
from public.sales s where s.date::text like '%-07-04%'
group by s.date
order by sum(s.statebottleretail::decimal) desc;

select sum(sel.bottlesold) , sel.black_friday from
(select sum(s.bottlesold) as bottlesold,s.date as black_friday
from public.sales s where s.date::text like '%-11-2%'
group by s.date
order by sum(s.bottlesold) desc) as sel group by sel.black_friday having sel.black_friday::text like '%201%' 

select sum(s.bottlesold) as bottlesold,s.date as black_friday
from public.sales s where s.date::text like '%-12-2%'
group by s.date
order by sum(s.bottlesold) desc;


select distinct(v.vendorname), c.categoryname from items i 
join sales si on i.itemid=si.itemnumber join 
vendor  v on v.vendorid=si.vendornumber join category c on c.id=i.categoryid 
group by v.vendorname,c.categoryname order by v.vendorname;

select s.storename, a.addressword from store s , address a where a.storenumber=s.id;

SELECT si.storename,  sum(s.volumesold::decimal)
FROM SALES s ,store si
WHERE  si.id=s.storenumber group by storename order by sum(s.volumesold::decimal) desc ;

select i.itemdescription , c.categoryname from items i join 
category c on i.categoryid=c.id order by c.categoryname 

select v.vendorname,s.zipcode from vendor v , sales s;

select c.countyname, count(s.storename) from store s , county c where c.countyid=s.countynumber group by c.countyname
order by count(s.storename) desc;


select * from
(select sum(s.volumesold::decimal) as volume,ca.categoryname as category, c1.countyname as countyname,
ROW_NUMBER() OVER (PARTITION BY c1.countyname Order by sum(s.volumesold::decimal) DESC) AS Sno from public.sales s join public.items i on i.itemid=s.itemnumber
join city ci on ci.zipcode=s.zipcode join 
public.county c1 on c1.countyid=ci.countynumber join category ca on ca.id=i.categoryid 
group by ca.categoryname,c1.countyname
order by countyname asc ,sum(s.volumesold::decimal) desc) a1 WHERE Sno <=1

 


