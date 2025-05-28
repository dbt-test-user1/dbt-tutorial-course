
  
    

    create or replace table `phonic-sunbeam-461012-g9`.`dbt_test`.`stg_ecommerce__order_items`
        
  (
    order_item_id INT64 not null,
    order_id INT64,
    user_id INT64,
    product_id INT64,
    item_sale_price FLOAT64
    
    )

      
    
    

    OPTIONS(
      expiration_timestamp=TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 168 hour),
    
      description="""Line items from orders"""
    )
    as (
      
    select order_item_id, order_id, user_id, product_id, item_sale_price
    from (
        WITH source AS (
	SELECT *

	FROM `bigquery-public-data`.`thelook_ecommerce`.`order_items`
)

SELECT
	-- IDs
	id AS order_item_id,
	order_id,
	user_id,
	product_id,

	-- Other columns
	sale_price AS item_sale_price

FROM source
    ) as model_subq
    );
  