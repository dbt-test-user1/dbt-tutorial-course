
  
    

    create or replace table `phonic-sunbeam-461012-g9`.`dbt_test`.`stg_ecommerce__events`
      
    partition by timestamp_trunc(created_at, day)
    

    OPTIONS(
      expiration_timestamp=TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 168 hour),
    
      description=""""""
    )
    as (
      

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
	
	dbt_test.get_brand_name(uri) AS brand_name


FROM source



    );
  