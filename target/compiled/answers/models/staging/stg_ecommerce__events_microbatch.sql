

WITH source AS (
	SELECT *

	FROM `bigquery-public-data`.`thelook_ecommerce`.`events`
)

SELECT
	id AS event_id,
	user_id,
	sequence_number,
	session_id,
	created_at,
	ip_address,
	city,
	state,
	postal_code,
	browser,
	traffic_source,
	uri AS web_link,
	event_type,
	
	dbt_choki.get_brand_name(uri) AS brand_name


FROM source