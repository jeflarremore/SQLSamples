-- Loan has aged at least 6 months
SELECT [L].[acctrefno], DATEDIFF(m, [L].[input_date], getdate()) AS [Loan_Month_Age]
FROM [Innovate_Loan_Servicing].[dbo].[loanacct] AS [L]
WHERE (DATEDIFF(m, [L].[input_date], getdate()) > 16)
--AND [L].[acctrefno] = 83