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

