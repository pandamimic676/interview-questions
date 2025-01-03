SELECT score.name, class.class
FROM score 
JOIN class ON score.name = class.name
WHERE score.score = (
    SELECT DISTINCT score.score
    FROM score 
    ORDER BY score.score DESC 
    LIMIT 1 OFFSET 1
);