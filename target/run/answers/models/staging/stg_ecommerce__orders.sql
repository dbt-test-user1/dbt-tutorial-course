
  
    

    create or replace table `phonic-sunbeam-461012-g9`.`dbt_test`.`stg_ecommerce__orders`
      
    
    

    OPTIONS(
      expiration_timestamp=TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 168 hour),
    
      description=""""""
    )
    as (
      WITH source AS (
	SELECT *

	FROM `bigquery-public-data`.`thelook_ecommerce`.`orders`
)

SELECT
	-- IDs
	order_id,
	user_id,

	-- Timestamps
	created_at,
	returned_at,
	delivered_at,
	shipped_at,

	-- Other columns
	status,
	num_of_item AS num_items_ordered

FROM source
    );
  