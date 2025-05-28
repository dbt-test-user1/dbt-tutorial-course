
  
    

    create or replace table `phonic-sunbeam-461012-g9`.`dbt_test`.`int_ecommerce__order_items_products`
      
    
    

    OPTIONS(
      expiration_timestamp=TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 168 hour),
    
      description="""Order item data joined to product data"""
    )
    as (
      WITH products AS (
	SELECT
		product_id,
		department AS product_department,
		cost AS product_cost,
		retail_price AS product_retail_price

	FROM `phonic-sunbeam-461012-g9`.`dbt_test`.`stg_ecommerce__products`
)

SELECT

	-- IDs
	order_items.order_item_id,
	order_items.order_id,
	order_items.user_id,
	order_items.product_id,

	-- Order item data
	order_items.item_sale_price,

	-- Product data
	products.product_department,
	products.product_cost,
	products.product_retail_price,

	-- Calculated fields
	order_items.item_sale_price - products.product_cost AS item_profit,
	products.product_retail_price - order_items.item_sale_price AS item_discount

FROM `phonic-sunbeam-461012-g9`.`dbt_test`.`stg_ecommerce__order_items` AS order_items
LEFT JOIN products ON order_items.product_id = products.product_id
    );
  