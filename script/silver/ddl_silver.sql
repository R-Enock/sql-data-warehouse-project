/*
=====================================================================================================================
DDL Script: Create Bronze Tables
=====================================================================================================================
Script Purpose:
	This scirpt creates tables in the 'bronze' schema, dropping existing tables if any.
	Run this script to redefine the DDL structure of 'bronze' Tables
========================================================================================================================
*/


IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL 
	DROP TABLE bronze.crm_cust_info;
CREATE TABLE Bronze.crm_cust_info (
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_last NVARCHAR(50),
	cst_material_status NVARCHAR(50),
	cst_gndr NVARCHAR (50),
	cst_create_date DATE,
  dwh_create_date DATETIME DEFAULT GETDATE()
);
IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL 
	DROP TABLE bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info(
	prd_id		INT, 
	prd_key		NVARCHAR(50),
	prd_nm		NVARCHAR(50),
	prd_cost	INT, 
	prd_line	NVARCHAR(50), 
	prd_start_dt DATETIME,
	prd_end_dt	DATETIME,
  dwh_create_date DATETIME DEFAULT GETDATE()
);
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL 
	DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details (
	sls_ord_num NVARCHAR (50),
	sls_prd_key NVARCHAR (50),
	sls_cust_id INT,
	sls_order_dt INT,
	sls_ship_dt INT,
	sls_due_dt INT,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT,
  dwh_create_date DATETIME DEFAULT GETDATE()
); 
IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL 
	DROP TABLE bronze.erp_loc_a101;
CREATE TABLE bronze.erp_loc_a101(
	cid   NVARCHAR(50),
	cntry NVARCHAR(50),
  dwh_create_date DATETIME DEFAULT GETDATE()
);
IF OBJECT_ID('bronze.erp_cust_a212', 'U') IS NOT NULL 
	DROP TABLE bronze.erp_cust_a212;
CREATE TABLE bronze.erp_cust_a212(
	cid NVARCHAR(50),
	bdate DATE,
	gen NVARCHAR (50),
  dwh_create_date DATETIME DEFAULT GETDATE()
);
IF OBJECT_ID('bronze.epr_pxt_cat_g1v2', 'U') IS NOT NULL 
	DROP TABLE bronze.epr_pxt_cat_g1v2;
CREATE TABLE bronze.epr_pxt_cat_g1v2(
	id			NVARCHAR(50),
	cat			NVARCHAR(50),
	subcat		NVARCHAR(50),
	maintence	NVARCHAR(50),
  dwh_create_date DATETIME DEFAULT GETDATE()
);
