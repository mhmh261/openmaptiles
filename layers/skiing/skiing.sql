CREATE OR REPLACE FUNCTION layer_skiing(bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, name text, class text) AS $$
SELECT geometry, name, class
FROM(
    SELECT geometry, class, name
    FROM osm_skiing_linestring
    WHERE zoom_level >= 10 AND geometry && bbox
    UNION ALL
    
    SELECT geometry, name, class
    FROM osm_skiing_polygon
    WHERE zoom_level >= 10 AND geometry && bbox 
    ) AS zoom_levels   
WHERE geometry && bbox;
$$ LANGUAGE SQL STABLE
                -- STRICT
                PARALLEL SAFE;
