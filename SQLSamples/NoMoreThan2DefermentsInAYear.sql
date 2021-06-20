 -- No More Than 2 deferments in the year
SELECT *
--[L].[acctrefno], deferred_this_year
  FROM loanacct AS [L],(
		SELECT [Core].[acctrefno] , COUNT(*) AS [deferred_this_year]
		  FROM (
					SELECT *
					  FROM (
								SELECT [nls_refno] AS [acctrefno]
									 , [task_refno]
									 , [completion_date]
									 , [subdate] AS [defDate]
								  FROM (
								SELECT [nls_refno]
									 , [task_refno]
									 , [completion_date]
									 , [userdef]
									 , [subdate]
								  FROM (
											SELECT [nls_refno]
												 , [T].[task_refno]
												 , [completion_date]
												 , CONVERT(varchar(50), [userdef10]) AS [userdef10]
												 , [userdef11]
												 , [userdef12]
												 , [userdef13]
												 , [userdef14]
												 , [userdef15]
											  FROM [Innovate_Loan_Servicing].[dbo].[task] AS [T] 
											  INNER JOIN [Innovate_Loan_Servicing].[dbo].[task_detail] AS [TD] ON [T].[task_refno] = [TD].[task_refno]
											  WHERE [T].[task_template_no] = 12
												AND [T].[status_code_id] = 2
										) AS [P]
								  UNPIVOT (
											[subdate] FOR [userdef] IN ([userdef10], [userdef11], [userdef12], [userdef13], [userdef14], [userdef15])
										) as U
							) as [a]
								  WHERE [subdate] IS NOT NULL
									AND ISDATE([subdate]) = 1 
							) AS [Base]
					  WHERE DATEADD(YEAR, -1, GETDATE()) < [defDate]
					  ) AS [Core]
		 GROUP BY [Core].[acctrefno]
	) AS [SUB4] 
	WHERE [SUB4].[acctrefno] = [L].[acctrefno]
--	ORDER BY [L].[acctrefno] ASC
	--AND [L].[acctrefno] = 30871


