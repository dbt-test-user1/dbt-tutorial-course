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