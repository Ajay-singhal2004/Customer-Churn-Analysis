use churndb;

show tables;

-- Total Customer
select count(*)
from customer_churn;

 
 -- Total Churn Customers
 select count(*)
 from customer_churn
 where churn="yes";
 
 -- payment method wise customer
 select payment_method,
 count(*) 
 from customer_churn
 group by payment_method;
 
 -- payment method wise monthly charges
 select payment_method,
 sum(monthly_charges)
 from customer_churn
 group by payment_method;
 
 -- subscription type wise customer
 select subscription_type,
 count(*)
 from customer_churn
 group by subscription_type;
 
 -- highest revenue states
 select state,
 sum(Total_Charges) as state_charges
 from customer_churn
 group by state
 order by 2 desc;
 
 -- average charges by contract
 select Contract_Type,
 avg(Monthly_Charges) as avg_charge
 from customer_churn
 group by contract_type
 order by 2 desc;
 
 -- senier citizen churn
 select senior_citizen,
 count(*)
 from customer_churn
 where churn='yes'
 group by senior_citizen;
 
 -- top 10 high value customer
 select customer_id,customer_name,
 customer_value
 from customer_churn
 order by customer_value desc
 limit 10;
 
 -- customer without tech support
 select tech_support,
 count(*)
 from customer_churn
 where tech_support='no';
 
 
 
 --


-- Churn Rate
select round(
sum(case when churn='yes' then 1 else 0 end)*100/
count(*),2)
as churn_rate
from customer_churn;


-- Average Monthly Charges
select avg( Monthly_Charges)
from customer_churn;

-- churn by contract type
select contract_type, count(*) as custmors
from customer_churn
group by contract_type;

--  churn by internet sercive
select Internet_Service,
count(*)
from customer_churn
group by Internet_Service;

-- churn by state
select state,
count(*)
from customer_churn
where churn='yes'
group by state
order by 2 desc;





