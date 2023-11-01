SELECT * FROM brewies;


SELECT COUNT(*) FROM classic.brewies


SELECT * FROM classic.brewies;


QUESTION 1 - What is the brewery with the most ratings?

       SELECT * FROM brewies
       ORDER BY number_of_ratings DESC
       LIMIT 1;



QUESTION 2 - What is the average rating by brewery type?

    SELECT AVG(number_of_ratings) AS 'AVERAGE RATING',brewery_type FROM brewies
	GROUP BY brewery_type;


QUESTION 3 - What is the highest-rated brewery in a state?

	SELECT name, MAX(number_of_ratings) AS highest_rating
    FROM brewies
    WHERE state = 'oregon'
    GROUP BY name
    ORDER BY highest_rating DESC;
		
        

	
QUESTION 4 - I am thirsty, which brewery is the closest to me?
		
        SELECT country, latitude, longitude,
        SQRT(POW(latitude - 12.996,2) + POW(longitude - 7.6049,2)) AS 'Closest Brewery Distance'
        FROM brewies;
        GROUP BY country;