WITH

 __dbt__cte__int_ecommerce__first_order_created as (




SELECT
	user_id,
	MIN(created_at) AS first_order_created_at

FROM `phonic-sunbeam-461012-g9`.`dbt_test`.`stg_ecommerce__orders`
GROUP BY 1
), -- Aggregate measures
order_item_measures AS (
	SELECT
		order_id,
		SUM(item_sale_price) AS total_sale_price,
		SUM(product_cost) AS total_product_cost,
		SUM(item_profit) AS total_profit,
		SUM(item_discount) AS total_discount,

		
		SUM(IF(product_department = 'Men', item_sale_price, 0)) AS total_sold_menswear,
		SUM(IF(product_department = 'Women', item_sale_price, 0)) AS total_sold_womenswear

	FROM `phonic-sunbeam-461012-g9`.`dbt_test`.`int_ecommerce__order_items_products`
	GROUP BY 1
)

SELECT
	od.order_id,
	od.created_at AS order_created_at,
	EXTRACT(DAYOFWEEK FROM DATE(od.created_at)) IN (1, 7) AS order_was_created_on_weekend, -- Macro defined in macros/macro_is_weekend.sql
	od.shipped_at AS order_shipped_at,
	od.delivered_at AS order_delivered_at,
	od.returned_at AS order_returned_at,
	od.status AS order_status,
	od.num_items_ordered,
	om.total_sale_price,
	om.total_product_cost,
	om.total_profit,
	om.total_discount,

	-- Columns from our templated Jinja statement
	-- We could just hard code these if we wanted, e.g.: total_sold_menswear, total_sold_womenswear
	om.total_sold_menswear,
	om.total_sold_womenswear,

	-- In practise we'd calculate this column in the model itself, but it's
	-- a good way to demonstrate how to use an ephemeral materialisation
	TIMESTAMP_DIFF(od.created_at, user_data.first_order_created_at, DAY) AS days_since_first_order

FROM `phonic-sunbeam-461012-g9`.`dbt_test`.`stg_ecommerce__orders` AS od
LEFT JOIN order_item_measures AS om
	ON od.order_id = om.order_id
LEFT JOIN __dbt__cte__int_ecommerce__first_order_created AS user_data
	ON od.user_id = user_data.user_id