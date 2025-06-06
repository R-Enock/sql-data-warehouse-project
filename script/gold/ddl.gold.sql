/* 
================================================================================
DDL Script: Create Gold Views 
================================================================================
Script purpose:
  This script  creates views for the Gold layer in the data warehouse.
  The Gold layer represents the final dimension and facr tables (star Schema)

  Each view performs transformations and combines data from the silver layer to 
  produce a clean, enriced and business-ready dataset.

Usage:
  These views can be querried diectly for analytics and reporting.
================================================================================
*/


-- =============================================================================
-- Create Dimension:  gold.dim_customers
-- =============================================================================
CREATE OR ALTER VIEW  gold.dim_customers AS 
SELECT 
	ROW_NUMBER() OVER(ORDER BY cst_id) AS customer_key,
	ci.cst_id  AS customer_id,
	ci.cst_key AS customer_number,
	ci.cst_firstname AS first_name ,
	ci.cst_last AS last_name,
	lo.cntry AS country,
	ci.cst_material_status AS marital_status,
	CASE
  	WHEN ci.cst_gndr != 'unkown' then ci.cst_gndr
  	ELSE COALESCE ( ca.gen,'unkown')
	END gender,
	ca.bdate AS birth_date,
	ci.cst_create_date AS create_date
FROM Silver.crm_cust_info_2 ci 
LEFT JOIN silver.erp_cust_a212 ca
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101_2 lo
ON ci.cst_key = lo.cid

-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================
CREATE OR ALTER VIEW gold.dim_products  AS 
SELECT 
  	ROW_NUMBER() OVER(ORDER BY pn.prd_start_dt) AS product_key,
  	pn.prd_id AS product_id,
  	pn.prd_key AS product_number,
  	pn.prd_nm AS product_name,
  	pn.cat_id AS category_id,
  	pc.cat AS category,
  	pc.subcat AS subcategory,
  	pn.prd_cost AS cost,
  	pn.prd_line AS product_line,
  	pc.maintence AS maintenance ,
  	pn.prd_start_dt AS start_date
FROM Silver.crm_prd_info AS pn
LEFT JOIN silver.epr_pxt_cat_g1v2 AS pc
ON pn.cat_id = pc.id
WHERE pn.prd_end_dt IS NULL -- Filter historical data

-- =============================================================================
-- Create fact: gold.fact_sales
-- =============================================================================
CREATE OR ALTER VIEW gold.fact_sales AS 
SELECT
	sd.sls_ord_num AS order_number,
	pr.product_key,
	cu.customer_key,
	sd.sls_order_dt AS order_date,
	sd.sls_ship_dt AS shipping_date,
	sd.sls_due_dt AS due_date,
	sd.sls_sales AS sales_amount,
	sd.sls_quantity AS quantity,
	sd.sls_price AS price
FROM Silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
ON  sd.sls_cust_id = cu.customer_id



