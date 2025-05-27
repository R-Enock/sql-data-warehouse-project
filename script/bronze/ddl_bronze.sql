/* 
================================================================================================================================
Stored precedure: Load Bronze Layer (source -> Bronze)
================================================================================================================================
Script purpose:
	This stored procedure loads data into 'bronze' schema from external CSV files. 
	it performs the following actions:
	-Truncated the bronze tables before loading the data.
	- Uses the 'BULK insert' command to load from csv files to bronze tables.

Paramenters:
	none
	This stored proceedure does not accept any parameter or return any values.
Usage example:
	EXEC bronze.load_bronze;
================================================================================================================================
*/



CREATE OR ALTER  PROCEDURE bronze.load_bronze AS
BEGIN 
DECLARE @start_time DATETIME,@end_time DATETIME,@batch_start_time DATETIME,@batch_end_time DATETIME 
BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '=========================================================================================================';
		PRINT 'loading Bronze layer';
		PRINT'==========================================================================================================';

		PRINT '---------------------------------------------------------------------------------------------------------';
		PRINT 'Loading CRM tables';
		PRINT '---------------------------------------------------------------------------------------------------------';

		SET @start_time  = GETDATE();
		PRINT '>> Trunketing table:bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>> Inserting data: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\USER\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration:'+ CAST(DATEDIFF (second,@start_time,@end_time) AS NVARCHAR) + ' Second';
		PRINT '-----------------------------------------------------------------------------------------------------';

		SET @start_time  = GETDATE();
		PRINT '>> Trunketing table:bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>> Inserting data: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info 
		FROM 'C:\Users\USER\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration:'+ CAST(DATEDIFF (second,@start_time,@end_time) AS NVARCHAR) + ' Second';
		PRINT '---------------------------------------------------------------------------------------------------------';

		SET @start_time  = GETDATE();
		PRINT '>> Trunketing table:bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> Inserting data: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\USER\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration:'+ CAST(DATEDIFF (second,@start_time,@end_time) AS NVARCHAR) + ' Second';
		PRINT '---------------------------------------------------------------------------------------------------------';


		PRINT '---------------------------------------------------------------------------------------------------------';
		PRINT 'Loading EPR tables';
		PRINT '---------------------------------------------------------------------------------------------------------';
		SET @end_time = GETDATE();
		PRINT '>> Trunketing table:bronze.epr_pxt_cat_g1v2';
		TRUNCATE TABLE bronze.epr_pxt_cat_g1v2;
		PRINT '>> Inserting data: bronze.epr_pxt_cat_g1v2';
		BULK INSERT bronze.epr_pxt_cat_g1v2
		FROM 'C:\Users\USER\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration:'+ CAST(DATEDIFF (second,@start_time,@end_time) AS NVARCHAR) + ' Second';
		PRINT '---------------------------------------------------------------------------------------------------------';

		SET @start_time  = GETDATE();
		PRINT '>> Trunketing table:bronze.erp_cust_a212';
		TRUNCATE TABLE bronze.erp_cust_a212;
		PRINT '>> Inserting data: bronze.erp_cust_a212';
		BULK INSERT bronze.erp_cust_a212
		FROM 'C:\Users\USER\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration:'+ CAST(DATEDIFF (second,@start_time,@end_time) AS NVARCHAR) + ' Second';
		PRINT '---------------------------------------------------------------------------------------------------------';

		SET @start_time  = GETDATE();
		PRINT '>> Trunketing table:bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>> Inserting data: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\USER\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration:'+ CAST(DATEDIFF (second,@start_time,@end_time) AS NVARCHAR) + ' Second';
		PRINT '---------------------------------------------------------------------------------------------------------';
		SET @batch_end_time = GETDATE();
		PRINT '======================================================';
		PRINT 'Load bronze layer is completed';
		PRINT 'Total load duration:'+ CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '======================================================';
		END TRY
		BEGIN CATCH 
			PRINT '============================================================';
			PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
			PRINT 'ERROR Message'+ ERROR_MESSAGE() ;
			PRINT 'ERROR message' + CAST(ERROR_NUMBER() AS NVARCHAR);
			PRINT 'ERROR message' + CAST(ERROR_STATE() AS NVARCHAR);
			PRINT '============================================================';
	END CATCH
END

EXEC bronze.load_bronze
