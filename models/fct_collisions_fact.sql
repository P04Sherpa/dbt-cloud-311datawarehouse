{{
      config(
          materialized='table'
      )
  }}
  WITH location_dimension_motor_vehicle_collisions AS 
  (
    SELECT * FROM {{ ref('location_dimension_motor_vehicle_collisions') }}
  ),
  vehicle_type_dimension_motor_vehicle_collision AS 
  (
    SELECT * FROM {{ ref('vehicle_type_dimension_motor_vehicle_collision') }}
  ),
  contributing_factor_motor_vehicle_collisions AS 
  (
    SELECT * FROM {{ ref('contributing_factor_motor_vehicle_collisions') }}
  ),
  date_dimension AS 
  (
    SELECT * FROM {{ ref('date_dimension') }}
  ),
  all_collisions AS
  (
     SELECT * FROM  {{ ref('motor_vehicle_collisions') }}
  )
  SELECT cld.location_dimension_id, vd.vehicle_type_dimension_id , cfd.contributing_factor_dimension_id, dd.date_dim_id, 1 AS collisions_count
  FROM   all_collisions acl
         INNER JOIN location_dimension_motor_vehicle_collisions cld
           USING (zip_code,borough,longitude,latitude)
         INNER JOIN  vehicle_type_dimension_motor_vehicle_collision vd
           USING (vehicle_type_code1,vehicle_type_code2,vehicle_type_code_3,vehicle_type_code_4,vehicle_type_code_5)
         INNER JOIN contributing_factor_motor_vehicle_collisions cfd
           USING (contributing_factor_vehicle_1,contributing_factor_vehicle_2,contributing_factor_vehicle_3,contributing_factor_vehicle_4,contributing_factor_vehicle_5)
         INNER JOIN date_dimension dd  on date(acl.crash_date) = dd.full_date