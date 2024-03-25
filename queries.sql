SELECT * FROM Movies WHERE release_year < 2010;
SELECT Movies.title, People.name FROM Movies
JOIN Roles ON Movies.movie_id = Roles.movie_id
JOIN People ON Roles.person_id = People.person_id
WHERE Roles.role_type = 'director' AND Movies.title LIKE '%action%';
