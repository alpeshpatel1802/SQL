Create Procedure [dbo].[CalculateEMI]
@BasicAmountOfLoan decimal(18,2),   
@RateOfInterest decimal(18,2),   
@DurationOfLoan Int,   
@LoanStartDate DATETIME  
AS  
BEGIN  
SET NOCOUNT ON  
  
DECLARE   
  
@Payment decimal(12,2),   
@Period FLOAT,   
@Payment2 decimal(12,2),  
@TotalPayment decimal(12,2),  
@FinanceCharges FLOAT,  
@CompoundingPeriod FLOAT,  
@CompoundingInterest FLOAT,  
@CurrentBalance decimal(12,2),  
@Principal FLOAT,  
@Interest FLOAT,  
@LoanPaymentEndDate DATETIME,  
@LoanPayDate DATETIME,  
@LoanDueDate DATETIME   
  
  
  
SET @RateOfInterest = @RateOfInterest/100   
  
SET @CompoundingPeriod = 12   
  
  
/*** END USER VARIABLES ***/   
  
SET @CompoundingInterest = @RateOfInterest/@CompoundingPeriod   
  
SET @Payment = ROUND((((@RateOfInterest/12) * @BasicAmountOfLoan)/(1- ( POWER( (1 + (@RateOfInterest/12)),(-1 * @DurationOfLoan) )))),2)   
  
SET @TotalPayment = @Payment * @DurationOfLoan   
  
SET @FinanceCharges = @TotalPayment - @BasicAmountOfLoan   
  
IF EXISTS(SELECT object_id FROM tempdb.sys.objects WHERE name LIKE '#EMI%')   
  
BEGIN   
  
DROP TABLE #EMI   
  
END   
    
CREATE TABLE #EMI(   
  
 PERIOD INT   
  
,PAYDATE SMALLDATETIME   
  
,PAYMENT decimal(12,2)   
  
,CURRENT_BALANCE decimal(12,2)   
  
,INTEREST decimal(12,2)   
  
,PRINCIPAL decimal(12,2)   
  
)   
  
SET @Period = 1   
  
SET @LoanPaymentEndDate = DATEADD(month,@DurationOfLoan,@LoanStartDate)   
  
SET @LoanPayDate = @LoanStartDate  
  
BEGIN   
  
WHILE (@Period < = @DurationOfLoan)   
  
BEGIN   
  
SET @CurrentBalance = ROUND (@BasicAmountOfLoan * POWER( (1+ @CompoundingInterest) , @Period ) - ( (ROUND(@Payment,2)/@CompoundingInterest) * (POWER((1 + @CompoundingInterest),@Period ) - 1)),0)   
  
SET @Principal =   
CASE   
WHEN @Period = 1   
THEN   
ROUND((ROUND(@BasicAmountOfLoan,0) - ROUND(@CurrentBalance,0)),0)   
ELSE   
ROUND ((SELECT ABS(ROUND(CURRENT_BALANCE,0) - ROUND(@CurrentBalance,0))   
FROM #EMI   
WHERE PERIOD = @Period -1),2)   
END   
  
SET @Interest = ROUND(ABS(ROUND(@Payment,2) - ROUND(@Principal,2)),2)   
  
SET @LoanDueDate = @LoanPayDate   
  
INSERT   
#EMI  
  
SELECT   
  
@Period,   
@LoanDueDate,   
@Payment,   
@CurrentBalance,   
@Interest,   
@Principal   
  
SET @Period = @Period + 1   
  
SET @LoanPayDate = DATEADD(MM,1,@LoanPayDate)   
  
END   
  
END   
  
SELECT * FROM #EMI  
END  