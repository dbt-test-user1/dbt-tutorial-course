
  
    

    create or replace table `phonic-sunbeam-461012-g9`.`dbt_test`.`stg_ecommerce__products`
      
    
    

    OPTIONS(
      expiration_timestamp=TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 168 hour),
    
      description="""Table of products on the online store"""
    )
    as (
      WITH source AS (
	SELECT *

	FROM `bigquery-public-data`.`thelook_ecommerce`.`products`
)

SELECT
	-- IDs
	id AS product_id,

	-- Other columns
	cost,
	retail_price,
	department,
	brand -- new column added in v2

FROM source
    );
  