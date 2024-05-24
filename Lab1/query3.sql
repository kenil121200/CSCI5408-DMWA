SELECT DISTINCT lab_1.directors_genres.genre FROM lab_1.directors 
RIGHT JOIN lab_1.directors_genres
ON lab_1.directors.id = lab_1.directors_genres.director_id
WHERE CONCAT(lab_1.directors.first_name, ' ', lab_1.directors.last_name) = "Christopher Nolan";
