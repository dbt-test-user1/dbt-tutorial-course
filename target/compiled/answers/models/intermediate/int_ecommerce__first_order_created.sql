



SELECT
	user_id,
	MIN(created_at) AS first_order_created_at

FROM `phonic-sunbeam-461012-g9`.`dbt_test`.`stg_ecommerce__orders`
GROUP BY 1