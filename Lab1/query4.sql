SELECT M.name AS movie_name, CONCAT(D.first_name, " ", D.last_name) AS director_name
FROM lab_1.movies M
JOIN lab_1.movies_directors MD ON M.id = MD.movie_id
JOIN lab_1.directors D ON MD.director_id = D.id 
WHERE M.id IN (
    SELECT MG.movie_id
    FROM lab_1.movies_genres MG
    WHERE MG.genre IN ('Action', 'Sci-Fi')
    GROUP BY MG.movie_id
    HAVING COUNT(DISTINCT MG.genre) = 2
) AND (M.rank BETWEEN 8 AND 9);

