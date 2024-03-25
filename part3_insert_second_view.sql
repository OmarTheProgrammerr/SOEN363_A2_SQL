CREATE VIEW people_summary AS
SELECT
    p.person_id,
    p.name,
    MAX(CASE WHEN r.role_type = 'actor' THEN 'Yes' ELSE 'No' END) AS "Is-Actor",
    MAX(CASE WHEN r.role_type = 'director' THEN 'Yes' ELSE 'No' END) AS "Is-Director",
    COUNT(DISTINCT r.movie_id) AS "Total Number of Movies"
FROM
    People p
LEFT JOIN Roles r ON p.person_id = r.person_id
GROUP BY
    p.person_id;
