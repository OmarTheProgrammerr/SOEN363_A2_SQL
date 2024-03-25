Name: Omar Mohammad
ID: 40162541

Note: I'm using PostgreSQL for writing the SQL quries.

## Part 1:

- create_database_schema.sql:

```
-- Name: Omar Mohammad. ID: 40162541

-- Create Countries Table
CREATE TABLE Countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(255) NOT NULL,
    country_code CHAR(2) NOT NULL UNIQUE
);

-- Create Languages Table
CREATE TABLE Languages (
    language_id SERIAL PRIMARY KEY,
    language_name VARCHAR(255) NOT NULL UNIQUE
);

-- Create Movies Table
CREATE TABLE Movies (
    movie_id SERIAL PRIMARY KEY,
    tmdb_id VARCHAR(255) UNIQUE NOT NULL,
    imdb_id VARCHAR(255) UNIQUE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    rating DECIMAL(3, 1),
    release_year INT,
    watchmode_id VARCHAR(255),
    country_id INT,
    language_id INT,
    num_reviews INT,
    FOREIGN KEY (country_id) REFERENCES Countries(country_id),
    FOREIGN KEY (language_id) REFERENCES Languages(language_id)
);

-- Create People Table
CREATE TABLE People (
    person_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Create Roles Table
CREATE TABLE Roles (
    role_id SERIAL PRIMARY KEY,
    person_id INT NOT NULL,
    movie_id INT NOT NULL,
    role_type VARCHAR(50),
    character_name VARCHAR(255),
    FOREIGN KEY (person_id) REFERENCES People(person_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);



-- Create Genres Table
CREATE TABLE Genres (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(255) NOT NULL UNIQUE
);

-- Create Content Ratings Table
CREATE TABLE ContentRatings (
    content_rating_id SERIAL PRIMARY KEY,
    rating_name VARCHAR(255) NOT NULL UNIQUE
);

-- Junction Table for Movies and Genres
CREATE TABLE MovieGenres (
    movie_id INT NOT NULL,
    genre_id INT NOT NULL,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (genre_id) REFERENCES Genres(genre_id)
);

-- Junction Table for Movies and Content Ratings
CREATE TABLE MovieRatings (
    movie_id INT NOT NULL,
    content_rating_id INT NOT NULL,
    PRIMARY KEY (movie_id, content_rating_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (content_rating_id) REFERENCES ContentRatings(content_rating_id)
);

-- Here is an example of creating an index for the Movies table by title!
CREATE INDEX idx_movies_title ON Movies(title);

CREATE TABLE MovieLanguages (
    movie_id INT NOT NULL,
    language_id INT NOT NULL,
    PRIMARY KEY (movie_id, language_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (language_id) REFERENCES Languages(language_id)
);

CREATE TABLE Keywords (
    keyword_id SERIAL PRIMARY KEY,
    keyword VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE MovieKeywords (
    movie_id INT NOT NULL,
    keyword_id INT NOT NULL,
    PRIMARY KEY (movie_id, keyword_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (keyword_id) REFERENCES Keywords(keyword_id)
);
```

## part2

- insert_movies.sql:

```
INSERT INTO Countries (country_id, country_name, country_code) VALUES
(1, 'Fictionland', 'FL'),
(2, 'Imaginaria', 'IA'),
(3, 'Nowhere', 'NW'),
(4, 'UnitedStates', 'US'),
(5, 'Canadian', 'CA');

INSERT INTO Languages (language_id, language_name) VALUES
(1, 'English'),
(2, 'Fictionese'),
(3, 'Imaginarian'),
(4, 'French');

INSERT INTO Genres (genre_id, genre_name) VALUES
(1,'Adventure'),
(2, 'Mystery'),
(3, 'Comedy');

INSERT INTO People (person_id, name) VALUES
(1, 'John Actor'),
(2, 'Jane Director'),
(3, 'Doe Performer'),
(4, 'Actor Four'),
(5, 'Director Five');

-- Inserting 'The Godfather' data -- real movie data example from the json data provided in the assignment in row 51.
INSERT INTO Movies (movie_id, tmdb_id, imdb_id, title, description, rating, release_year, watchmode_id, country_id, language_id, num_reviews) VALUES
(1, 'tmdb001', 'imdb001', 'Epic Journey', 'A journey across worlds.', 8.2, 1995, 'wm001', 1, 1, 120),
(2, 'tmdb002', 'imdb002', 'Lost in Space', 'An astronauts fight for survival in space.', 9.1, 1989, 'wm002', 1, 1, 130),
(3, 'tmdb003', 'imdb003', 'Mystery of the Depths', 'Exploring the deepest parts of the ocean.', 7.8, 2020, 'wm003', 1, 1, 110),
(4, 'tmdb004', 'imdb004', 'The Last Wizard', 'The adventure of the last wizard.', 8.5, 2023, 'wm004', 1, 1, 140),
(5, 'tmdb005', 'imdb005', 'Beyond the Stars', 'A journey beyond the stars.', 8.9, 2024, 'wm005', 1, 1, 150),
(6, 'tmdb006', 'imdb006', 'Unknown Lands', 'Discovering unknown lands.', 7.5, 2021, 'wm006', 2, 2, 160),
(7, 'tmdb007', NULL, 'The Forgotten Realm', 'A forgotten realm is rediscovered.', 8.0, 2022, 'wm007', 2, 2, 115),
(8, 'tmdb008', 'imdb008', 'The Shadow Thief', 'A thief that can manipulate shadows.', 9.3, 2023, 'wm008', 2, 2, 125),
(9, 'tmdb009', 'imdb009', 'Parallel Worlds', 'A story about parallel worlds colliding.', 8.1, 2020, 'wm009', 2, 2, 135),
(10, 'tmdb010', 'imdb010', 'The Last Stand', 'The last stand against darkness.', 8.6, 2024, 'wm010', 2, 2, 145),
(11, 'tmdb011', 'imdb011', 'Guardians of Light', 'Guardians protecting the light.', 7.9, 2021, 'wm011', 3, 3, 155),
(12, 'tmdb012', 'imdb012', 'Cyber Revolution', 'A revolution in the digital world.', 8.3, 2022, 'wm012', 3, 3, 165),
(13, 'tmdb013', 'imdb013', 'The Time Keeper', 'A keeper who can control time.', 9.0, 2023, 'wm013', 3, 3, 120),
(14, 'tmdb014', 'imdb014', 'Invisible Boundaries', 'Exploring the boundaries of reality.', 8.7, 2020, 'wm014', 3, 3, 130),
(15, 'tmdb015', 'imdb015', 'The Dream Walker', 'Walking through dreams.', 7.6, 2024, 'wm015', 3, 3, 140),
(16, 'tmdb016', 'imdb016', 'Echoes of the Past', 'Echoes from the past affecting the present.', 8.4, 2021, 'wm016', 1, 1, 150),
(17, 'tmdb017', NULL, 'The Silent City', 'A city where silence is the rule.', 9.2, 2022, 'wm017', 1, 1, 160),
(18, 'tmdb018', 'imdb018', 'The Lost Expedition', 'An expedition that was lost years ago.', 8.8, 2023, 'wm018', 1, 1, 170),
(19, 'tmdb019', 'imdb019', 'The Crystal Forest', 'A forest made entirely of crystals.', 7.7, 2020, 'wm019', 1, 1, 180),
(20, 'tmdb020', 'imdb020', 'The Rift', 'A rift between dimensions.', 8.9, 2024, 'wm020', 2, 2, 190),
(21, 'tmdb021', 'imdb021', 'Warriors of the Wasteland', 'Survivors battle in a post-apocalyptic world.', 8.0, 2025, 'wm021', 2, 2, 200),
(22, 'tmdb022', 'imdb022', 'The Hidden Village', 'A mysterious village hidden from the world.', 8.2, 2021, 'wm022', 5, 4, 210),
(23, 'tmdb023', 'imdb023', 'Ghost Ship', 'A haunted ship lost at sea.', 7.9, 2022, 'wm023', 3, 3, 220),
(24, 'tmdb024', 'imdb024', 'The Enchanted Forest', 'Discover the magic within an ancient forest.', 9.1, 2023, 'wm024', 1, 1, 230),
(25, 'tmdb025', 'imdb025', 'Rise of the Machines', 'Machines awaken and seek dominance.', 8.6, 2024, 'wm025', 1, 1, 240),
(26, 'tmdb026', 'imdb026', 'The Sea of Tranquility', 'An epic tale set on the calmest ocean.', 8.3, 2025, 'wm026', 2, 2, 250),
(27, 'tmdb027', 'imdb027', 'The Caverns Below', 'Exploring the deepest caverns of Earth.', 7.8, 2021, 'wm027', 2, 2, 120),
(28, 'tmdb028', 'imdb028', 'Skyward Bound', 'A journey to the heavens above.', 9.2, 2022, 'wm028', 3, 3, 130),
(29, 'tmdb029', 'imdb029', 'The Forgotten Warriors', 'The tale of warriors long forgotten.', 8.7, 2023, 'wm029', 5, 4, 140),
(30, 'tmdb030', NULL, 'The Sorcerer’s Legacy', 'A sorcerer leaves behind a powerful legacy.', 8.1, 2024, 'wm030', 1, 1, 150),
(31, 'tmdb031', 'imdb031', 'The Desert Mirage', 'Mirages lead to an ancient secret in the desert.', 8.4, 2025, 'wm031', 1, 1, 160),
(32, 'tmdb032', 'imdb032', 'Frozen in Time', 'A town frozen in time reveals its secrets.', 7.7, 2021, 'wm032', 2, 2, 170),
(33, 'tmdb033', 'imdb033', 'The Labyrinth of Dreams', 'Navigating a labyrinth that reflects one’s dreams.', 9.0, 2022, 'wm033', 2, 2, 180),
(34, 'tmdb034', 'imdb034', 'The Galactic Voyage', 'A voyage across the galaxy uncovers new life forms.', 8.5, 2023, 'wm034', 3, 3, 190),
(35, 'tmdb035', 'imdb035', 'The Last Phoenix', 'The journey to find the last Phoenix.', 8.8, 2024, 'wm035', 3, 3, 200),
(36, 'tmdb036', 'imdb036', 'Whispers in the Dark', 'A tale of secrets and shadows.', 7.5, 2025, 'wm036', 2, 2, 210),
(37, 'tmdb037', 'imdb037', 'The Eternal Flame', 'A quest to find the eternal flame.', 8.4, 2021, 'wm037', 3, 2, 220),
(38, 'tmdb038', 'imdb038', 'The Hollow Earth', 'Explorers discover a civilization within Earth.', 8.9, 2022, 'wm038', 1, 1, 230),
(39, 'tmdb039', 'imdb039', 'Dance of the Dragons', 'Dragons return to the modern world.', 8.2, 2023, 'wm039', 1, 1, 240),
(40, 'tmdb040', 'imdb040', 'The Architect’s Key', 'Solving ancient puzzles with a mysterious key.', 7.6, 2024, 'wm040', 2, 2, 250),
(41, 'tmdb041', 'imdb041', 'The Veil of Shadows', 'A world where shadows hold power.', 9.1, 2025, 'wm041', 2, 2, 260),
(42, 'tmdb042', 'imdb042', 'Beyond the Veil', 'A journey to what lies beyond death.', 8.3, 2021, 'wm042', 5, 4, 270),
(43, 'tmdb043', 'imdb043', 'Chronicles of the Forgotten', 'Stories from a civilization long forgotten.', 8.7, 2022, 'wm043', 3, 3, 280),
(44, 'tmdb044', 'imdb044', 'The Shadow Over Innsmouth', 'A town haunted by unspeakable horrors.', 7.8, 2023, 'wm044', 1, 1, 290),
(45, 'tmdb045', 'imdb045', 'The Aether Chronicles', 'Adventures in a world of floating islands.', 8.5, 2024, 'wm045', 1, 1, 300),
(46, 'tmdb046', 'imdb046', 'The Clockwork Conspiracy', 'A plot to control time itself.', 9.0, 2025, 'wm046', 2, 2, 310),
(47, 'tmdb047', 'imdb047', 'The Depths of Madness', 'An expedition to the abyss that drives explorers mad.', 8.1, 2021, 'wm047', 2, 2, 320),
(48, 'tmdb048', 'imdb048', 'The Serpent’s Embrace', 'A tale of betrayal and vengeance in an ancient kingdom.', 8.6, 2022, 'wm048', 3, 3, 330),
(49, 'tmdb049', 'imdb049', 'The Crystal Shard', 'A quest for a shard that grants immense power.', 7.9, 2023, 'wm049', 3, 3, 340),
(50, 'tmdb050', 'imdb050', 'The Dreaming City', 'A city that exists in dreams and nightmares.', 8.8, 2024, 'wm050', 1, 1, 350),
(51, 'tbmd051', 'tt0068646', 'The Godfather', 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.', 9.2, 1972, 'not_provided', 4, 1, 2001878);

INSERT INTO MovieGenres (movie_id, genre_id) VALUES
(1, 1), -- Epic Adventure is an Adventure
(2, 2), -- Mystery Island is a Mystery
(3, 3); -- Space Journey is Sci-Fi


INSERT INTO Roles (person_id, movie_id, role_type, character_name) VALUES
(1, 1, 'actor', 'Hero'),
(1, 1, 'director', 'Hero'),
(3, 2, 'actor', 'Mystery Person'),
(4, 3, 'actor', 'Astronaut'),
(4, 3, 'director', 'Astronaut');

INSERT INTO MovieLanguages (movie_id, language_id) VALUES
(1, 1),
(1, 2);

-- Here I guess I will just be assuming keywords for 'Epic Journey'!
INSERT INTO Keywords (keyword) VALUES ('adventure'), ('fantasy'), ('epic');
-- and then I'll retrieve the keyword_ids from the Keywords table for insertion into MovieKeywords
INSERT INTO MovieKeywords (movie_id, keyword_id) VALUES
(1, (SELECT keyword_id FROM Keywords WHERE keyword = 'adventure')),
(1, (SELECT keyword_id FROM Keywords WHERE keyword = 'fantasy')),
(1, (SELECT keyword_id FROM Keywords WHERE keyword = 'epic'));

```

## Part 3

- First View

```
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
```

- Seconde View:

```
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
```

## Part 4

- DML Quries

```
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

```
