
	CREATE OR REPLACE FUNCTION dbt_choki.get_brand_name(web_link STRING)
	RETURNS STRING
	AS (
		REGEXP_EXTRACT(web_link, r'.+/brand/(.+)')
	)
