SELECT *
FROM artist;

SELECT *
FROM favorite_song;

-- NOTE: FROM clause = Left Table, JOIN clause = Right Table

-- INNER JOIN: Returns records that have matching values in both tables
SELECT *
FROM artist
INNER JOIN favorite_song
ON artist.artist_id = favorite_song.artist_id;

-- LEFT JOIN: Returns all records from the left table, and the matched records from the right table
SELECT *
FROM artist
LEFT JOIN favorite_song
ON artist.artist_id = favorite_song.artist_id;

-- RIGHT JOIN: Returns all records from the right table, and the matched records from the left table
SELECT artist_name, song_name, artist.artist_id
FROM artist
RIGHT JOIN favorite_song
ON artist.artist_id = favorite_song.artist_id;

-- FULL JOIN: Returns all records
SELECT *
FROM artist
FULL JOIN favorite_song
ON artist.artist_id = favorite_song.artist_id;