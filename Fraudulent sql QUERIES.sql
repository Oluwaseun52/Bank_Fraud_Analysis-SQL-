CREATE TABLE fraudulent (
step INTEGER,
type VARCHAR(50),
amount FLOAT,	
nameorig VARCHAR(50),	
oldbalanceorg FLOAT,	
newbalanceorig FLOAT,
namedest VARCHAR(50),	
oldbalancedest FLOAT,
newbalancedest FLOAT,	
isfraud INTEGER,
isflaggedfraud INTEGER
);

copy public.fraudulent
from 'C:\Users\seunt\OneDrive\SQL Folder\Fraudulent Transaction SQL\Fraudulent Transactions csv.csv'
delimiter ',' csv header

select *
from fraudulent;

--Questions and Answers

--How many transactions occurred per transaction type?

select type, count (*) as total_transactions_per_type
from fraudulent
group by type
order by total_transactions_per_type;


--Which Transaction Type has the highest number of Fraudulent Transactions?

select type, count(type) as most_fraudulent_transaction_type
from fraudulent
where isfraud = 1
group by type2
order by most_fraudulent_transaction_type desc
limit 1;


--What is the average fraudulent transaction amount?

select round(avg(amount)) as avg_fraudulent_transaction_amount
from fraudulent
where isfraud = 1;


--What is the Maximum fraudulent transaction amount?

select max(amount) as max_fraudulent_amount
from fraudulent
where isfraud = 1;


--What is the Minimum fraudulent transaction amount?

select min(amount) as min_fraudulent_amount
from fraudulent
where isfraud = 1;


--Who are the Top 10 customers with the highest amount defrauded?

select nameorig as top10_defrauded_customers, (oldbalanceorg - amount) as amount_defrauded
from fraudulent
where isfraud = 1
group by top10_defrauded_customers, amount_defrauded
order by amount_defrauded desc
limit 10;


--Who are the Top 20 Fraudster

select namedest as top20_fraudsters, (newbalancedest - oldbalancedest) as frauded_amount
from fraudulent
where isfraud = 1
group by top20_fraudsters, frauded_amount
order by frauded_amount desc
limit 20;


--How effective is the bank in flagging fraud?

select isflaggedfraud, count(isflaggedfraud) as flagged_attempts
from fraudulent
where isfraud = 1
group by isflaggedfraud;

--comment
/*
The bank's ability to flag fraudulent transactions was quite poor,
as it successfully identified only 32 transactions as fraudulent
while failing to flag 16,394 transactions that were, indeed, fraudulent.
*/