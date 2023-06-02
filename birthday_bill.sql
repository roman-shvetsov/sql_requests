SELECT * FROM users
ORDER BY user_id;

SELECT * FROM departaments

UPDATE users
SET date_of_birth = '1975-06-19'
WHERE user_id = 3;

ALTER TABLE users
ADD CONSTRAINT date_of_birth_notnull CHECK(date_of_birth IS NOT NULL);

SELECT u.name, role, salary, d.name, date_of_birth
FROM users u
LEFT JOIN departaments d
ON d.departament_id = u.departament_id
ORDER BY salary DESC;

WITH birthdays AS(SELECT name, date_of_birth, 
		CASE
			WHEN EXTRACT(MONTH FROM date_of_birth) > EXTRACT(MONTH FROM current_date)
			OR EXTRACT(DAY FROM date_of_birth) > EXTRACT(DAY FROM current_date) THEN 'Не прошло'
			ELSE 'Прошло'
		END as status,
		DATE_TRUNC('year', CURRENT_DATE) AT TIME ZONE 'UTC' + (date_of_birth - DATE_TRUNC('year', date_of_birth)AT TIME ZONE 'UTC') AS modified_date
FROM users)
SELECT name, date_of_birth,
		CASE
			WHEN status = 'Не прошло' THEN (modified_date - CURRENT_DATE)::interval
			ELSE '365 days' + (modified_date - CURRENT_DATE)
		END AS days_before_birth
FROM birthdays;