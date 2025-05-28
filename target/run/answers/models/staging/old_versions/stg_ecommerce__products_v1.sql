
  
    

    create or replace table `phonic-sunbeam-461012-g9`.`dbt_test`.`stg_ecommerce__products_v1`
      
    
    

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
	department

FROM source
    );
  