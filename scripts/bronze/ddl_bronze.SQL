-- ==========================================
-- Create or replace procedure to load bronze layer tables
-- Captures start time, end time, and duration
-- ==========================================

CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS
$$
DECLARE
    v_start_time timestamp;
    v_end_time timestamp;
    v_duration interval;
BEGIN
    -- Capture start time
    v_start_time := clock_timestamp();
    RAISE NOTICE 'Load started at: %', v_start_time;

    -- Truncate tables first to avoid duplicate loads
    TRUNCATE TABLE bronze.crm_cust_info;
    TRUNCATE TABLE bronze.crm_prd_info;
    TRUNCATE TABLE bronze.crm_sales_detail;
    TRUNCATE TABLE bronze.erp_cust_a212;
    TRUNCATE TABLE bronze.erp_loc_a101;
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;

    -- Load customer info
    COPY bronze.crm_cust_info
    FROM 'D:/SQL/sql-data-warehouse-project/datasets/source_crm/crm_cust_info.csv'
    WITH (FORMAT csv, HEADER true);

    -- Load product info
    COPY bronze.crm_prd_info
    FROM 'D:/SQL/sql-data-warehouse-project/datasets/source_crm/crm_prd_info.csv'
    WITH (FORMAT csv, HEADER true);

    -- Load sales detail
    COPY bronze.crm_sales_detail
    FROM 'D:/SQL/sql-data-warehouse-project/datasets/source_crm/crm_sales_detail.csv'
    WITH (FORMAT csv, HEADER true);

    -- Load ERP customer A212 data
    COPY bronze.erp_cust_a212
    FROM 'D:/SQL/sql-data-warehouse-project/datasets/source_erp/erp_cust_a212.csv'
    WITH (FORMAT csv, HEADER true);

    -- Load ERP location A101 data
    COPY bronze.erp_loc_a101
    FROM 'D:/SQL/sql-data-warehouse-project/datasets/source_erp/erp_loc_a101.csv'
    WITH (FORMAT csv, HEADER true);

    -- Load ERP product category G1V2 data
    COPY bronze.erp_px_cat_g1v2
    FROM 'D:/SQL/sql-data-warehouse-project/datasets/source_erp/erp_px_cat_g1v2.csv'
    WITH (FORMAT csv, HEADER true);

    -- Capture end time
    v_end_time := clock_timestamp();

    -- Calculate duration
    v_duration := v_end_time - v_start_time;

    -- Print summary
    RAISE NOTICE 'Load ended at: %', v_end_time;
    RAISE NOTICE 'Total duration: %', v_duration;

END;
$$;

-- ==========================================
-- To run the procedure:
-- CALL bronze.load_bronze();
-- ==========================================
