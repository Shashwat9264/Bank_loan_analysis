use bank_loan;

Select * from finance_1 ;
select * from finance_2 ;

-- KPI 1 - Year wise Loan amount

select year(issue_d) as Year, concat(format(round(sum(loan_amnt)/1000000,2),2),"M") as Total_Loan_Amnt from finance_1
group by Year
order by Year ;

-- KPI 2 - Grade and sub grade wise revol_bal

select	grade, sub_grade, sum(revol_bal) as Total_revol_bal from finance_1
inner join finance_2 on (finance_1.id = finance_2.id)
group by grade, sub_grade 
order by grade, sub_grade;

-- KPI 3 - Total Payment for Verified Status Vs Total Payment for Non Verified Status

select verification_status, concat(format(round(sum(total_pymnt)/100000,2),2),"M") as Total_payment
from finance_1
inner join finance_2 on (finance_1.id = finance_2.id)
where verification_status in ('Verified', 'Not Verified')
group by verification_status;

select * from finance_1;
select * from finance_2;

-- KPI 4 - State wise and month wise loan status

select addr_state, monthname(last_credit_pull_d) as Month, loan_status
from finance_1 inner join finance_2
on finance_1.id = finance_2.id
group by addr_state, Month, loan_status
order by Month;

-- KPI 5 - Home ownership Vs last payment date stats

select home_ownership, last_pymnt_d, concat(format(round(sum(last_pymnt_amnt)/10000,2),2),"K") as last_payment_amnt
from finance_1 inner join finance_2
on finance_1.id = finance_2.id
group by home_ownership, last_pymnt_d
order by last_pymnt_d desc, home_ownership desc;
