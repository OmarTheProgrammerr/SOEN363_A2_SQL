CREATE VIEW movie_summary AS
SELECT
    m.tmdb_id AS "TMDB Key",
    m.imdb_id AS "IMDB Key",
    m.title,
    m.description,
    (SELECT COUNT(*) FROM MovieGenres mg WHERE mg.movie_id = m.movie_id) AS "Number of Genres",
    (SELECT COUNT(DISTINCT country_id) FROM Movies) AS "Number of Countries"
FROM
    Movies m;
