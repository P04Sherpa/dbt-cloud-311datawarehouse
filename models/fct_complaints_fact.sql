{{
      config(
          materialized='table'
      )
  }}
  WITH agency_dimension_street_conditions AS 
  (
    SELECT * FROM {{ ref('agency_dimension_street_conditions') }}
  ),
  complaint_type_dimension_street_conditions AS 
  (
    SELECT * FROM {{ ref('complaint_type_dimension_street_conditions') }}
  ),
  location_dimension_street_conditions AS 
  (
    SELECT * FROM {{ ref('location_dimension_street_conditions') }}
  ),
  resolution_dimension_street_conditions AS 
  (
    SELECT * FROM {{ ref('resolution_dimension_street_conditions') }}
  ),
  date_dimension AS 
  (
    SELECT * FROM {{ ref('date_dimension') }}
  ),
  all_complaints AS
  (
     SELECT * FROM  {{ ref('street_conditions') }}
  )
  SELECT ad.agency_dim_id, ctd.complaint_dimension_id, ld.location_dim_id, rd.resolution_dimension_id, dd.date_dim_id, 1 AS complaint_count
  FROM   all_complaints ac 
         INNER JOIN agency_dimension_street_conditions ad 
           USING (agency, agency_name)
         INNER JOIN complaint_type_dimension_street_conditions ctd
           USING (complaint_type, descriptor)
         INNER JOIN location_dimension_street_conditions ld
           USING (borough, incident_address, incident_zip, latitude, longitude)
         INNER JOIN resolution_dimension_street_conditions rd
         USING (agency, resolution_description)
         INNER JOIN date_dimension dd ON DATE(ac.created_date) = dd.full_date