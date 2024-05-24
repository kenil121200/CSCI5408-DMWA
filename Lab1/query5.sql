SELECT M.name FROM lab_1.movies M
WHERE M.id IN 
(SELECT R.movie_id
FROM lab_1.roles R
WHERE R.role LIKE '%Doctor%'
GROUP BY R.movie_id
ORDER BY COUNT(*) DESC
)
LIMIT 1;


