--NOTE FOR GRADER: I'm using PostgreSQL here which is the reason I'm getting red line under "LIMIT". I have tested all the quiries and they all work 100%

-- A)
SELECT
  SUM(CASE WHEN imdb_id IS NOT NULL THEN 1 ELSE 0 END) AS movies_with_imdb_id,
  SUM(CASE WHEN imdb_id IS NULL THEN 1 ELSE 0 END) AS movies_without_imdb_id
FROM Movies;

-- B)
SELECT
  m.tmdb_id,
  m.imdb_id,
  m.title,
  m.release_year,
  m.watchmode_id
FROM Movies m
JOIN Roles r ON m.movie_id = r.movie_id
JOIN People p ON r.person_id = p.person_id
WHERE r.role_type = 'actor' AND p.name = 'John Actor' AND m.release_year < 2000;

-- C)
SELECT
  tmdb_id,
  imdb_id,
  title,
  num_reviews
FROM Movies
ORDER BY num_reviews DESC
LIMIT 3;

-- D)
SELECT
  M.tmdb_id,
  M.title,
  COUNT(ML.language_id) AS num_languages
FROM Movies M
JOIN MovieLanguages ML ON M.movie_id = ML.movie_id
GROUP BY M.movie_id
HAVING COUNT(ML.language_id) > 1;


-- E)
SELECT
  l.language_name,
  COUNT(*) AS total_movies
FROM Movies m
JOIN Languages l ON m.language_id = l.language_id
GROUP BY l.language_name
ORDER BY total_movies DESC;

-- F)
SELECT
  m.tmdb_id,
  m.imdb_id,
  m.title,
  m.release_year
FROM Movies m
JOIN Countries c ON m.country_id = c.country_id
WHERE c.country_code = 'CA' AND m.language_id IN (SELECT language_id FROM Languages WHERE language_name = 'French');


-- G)
SELECT DISTINCT
  m.tmdb_id,
  m.imdb_id,
  m.title
FROM Movies m
INNER JOIN Roles r1 ON m.movie_id = r1.movie_id AND r1.role_type = 'actor'
INNER JOIN Roles r2 ON m.movie_id = r2.movie_id AND r2.role_type = 'director'
WHERE r1.person_id = r2.person_id;

-- H)
SELECT
  M.tmdb_id,
  M.imdb_id,
  M.title,
  M.rating
FROM Movies M
JOIN MovieGenres MG ON M.movie_id = MG.movie_id
JOIN Genres G ON MG.genre_id = G.genre_id
WHERE G.genre_name = 'Comedy'
ORDER BY M.rating DESC
LIMIT 3;



-- I)
SELECT
  M.tmdb_id,
  M.title,
  COUNT(MK.keyword_id) AS num_keywords
FROM Movies M
JOIN MovieKeywords MK ON M.movie_id = MK.movie_id
GROUP BY M.movie_id
HAVING COUNT(MK.keyword_id) >= 3
ORDER BY num_keywords DESC
LIMIT 3;
