CREATE TABLE users
(
	id int PRIMARY KEY,
	displayname varchar(50) NOT NULL,
	age int NOT NULL
);

CREATE TABLE posts
(
	id int PRIMARY KEY,
	creationDate date NOT NULL,
	ownerUserId int REFERENCES users(id)
);

CREATE TABLE comments
(
	id int PRIMARY KEY,
	postId int REFERENCES posts(id),
	Text text NOT NULL,
	creationDate date NOT NULL,
	userId int REFERENCES users(id)
);

CREATE TABLE votes
(
	id int PRIMARY KEY,
	postId int REFERENCES posts(id),
	creationDate date NOT NULL,
	userId int REFERENCES users(id)
);


INSERT INTO users
VALUES
(1, 'Roman', 26),
(2, 'Lina', 19),
(3, 'Ramzes', 33),
(4, 'Margo', 27),
(5, 'Asya', 20),
(6, 'Victoria', 18),
(7, 'Kristina', 29),
(8, 'Ksenia', 24),
(9, 'Angela', 19),
(10, 'Angelina', 23),
(11, 'Kirill', 26),
(12, 'Vlad', 26),
(13, 'Arsenii', 27),
(14, 'Dmitro', 45),
(15, 'Hazbic', 20),
(16, 'Nurlan', 31);

INSERT INTO posts
VALUES
(1, '2021-01-26', 1),
(2, '2023-06-08', 1),
(3, '2022-01-26', 5),
(4, '2023-01-26', 2),
(5, '2023-01-26', 2),
(6, '2022-01-26', 3),
(7, '2021-01-26', 4),
(8, '2022-01-26', 5),
(9, '2023-01-26', 7),
(10, '2023-01-26', 4),
(11, '2022-01-26', 10),
(12, '2021-01-26', 8),
(13, '2022-01-26', 8),
(14, '2022-01-26', 9),
(15, '2023-01-26', 13),
(16, '2021-01-26', 8),
(17, '2021-01-26', 1),
(18, '2023-01-26', 9),
(19, '2022-01-26', 5),
(20, '2023-01-26', 8),
(21, '2022-01-26', 2),
(22, '2023-01-26', 10),
(23, '2023-01-26', 13),
(24, '2021-01-26', 8),
(25, '2021-01-26', 1),
(26, '2023-01-26', 9),
(27, '2022-01-26', 5),
(28, '2023-01-26', 8),
(29, '2022-01-26', 2),
(30, '2023-01-26', 10);


INSERT INTO comments
VALUES
(1, 1, 'ПРИВЕТ', '2021-01-26', 1),
(2, 2, 'объективно', '2022-01-26', 1),
(3, 3, 'круть!', '2023-01-26', 5),
(4, 3, 'лайк', '2023-01-26', 2),
(5, 4, 'ужас', '2023-01-26', 2),
(6, 5, 'диздлайк', '2023-01-26', 3),
(7, 6, 'кринж', '2022-01-26', 4),
(8, 7, 'и что это', '2021-01-26', 5),
(9, 7, 'что я тут забыл', '2022-01-26', 7),
(10, 9, 'помогите я в бд', '2023-01-26', 4),
(11, 10, 'хелп', '2023-01-26', 10),
(12, 11, 'мне страшно', '2023-01-26', 8),
(13, 11, 'спасите', '2022-01-26', 8),
(14, 11, 'ар вици', '2022-01-26', 9),
(15, 13, 'я бот', '2023-01-26', 13),
(16, 16, '😡😡😡😡', '2023-01-26', 8),
(17, 18, 'Класс)))))', '2022-01-26', 1),
(18, 19, 'россия!!!', '2023-01-26', 9),
(19, 16, 'Я не согласен', '2023-01-26', 5),
(20, 8, 'люблю кошек', '2023-01-26', 8),
(21, 9, 'отписка', '2022-01-26', 2),
(22, 10, 'like', '2023-01-26', 10),
(23, 12, 'come to me', '2021-01-26', 13),
(24, 16, 'how are you', '2021-01-26', 8),
(25, 20, 'Твоя машина?', '2023-01-26', 1),
(26, 20, 'хороший пост лайк', '2022-01-26', 9),
(27, 19, '[jhjibq gjcn]', '2023-01-26', 5),
(28, 22, 'когда зп?', '2023-01-26', 8),
(29, 26, 'без труда...', '2023-01-26', 2),
(30, 30, 'выше быстрее сильнее', '2023-01-26', 10);

INSERT INTO votes
VALUES
(1, 1, '2023-03-03', 1),
(2, 2, '2022-03-03', 1),
(3, 3, '2022-03-03', 5),
(4, 3, '2022-03-03', 2),
(5, 4, '2023-03-03', 2),
(6, 5, '2023-03-03', 3),
(7, 6, '2021-03-03', 4),
(8, 7, '2021-03-03', 5),
(9, 7, '2023-03-03', 7),
(10, 9, '2023-03-03', 4),
(11, 10, '2023-03-03', 10);

-- Первое задание
-- первый вариант с Join

SELECT users.id, displayname, age
FROM users
LEFT JOIN posts ON users.id = posts.owneruserid
LEFT JOIN comments ON users.id = comments.userid
WHERE posts.id IS NULL AND comments.id IS NULL;

-- второй вариант с подзапросом

SELECT id, displayname, age
FROM users
WHERE id NOT IN (SELECT owneruserid FROM posts) 
	AND id NOT IN (SELECT userid FROM comments);

-- Второе задание

SELECT years, SUM(posts) AS posts, SUM(comments) AS comments
FROM (
    SELECT EXTRACT(YEAR FROM creationdate::timestamp) AS years,
        COUNT(*) AS posts,
        0 AS comments
    FROM posts
    GROUP BY EXTRACT(YEAR FROM creationdate::timestamp)

    UNION ALL

    SELECT EXTRACT(YEAR FROM creationdate::timestamp) AS years,
        0 AS posts,
        COUNT(*) AS comments
    FROM comments
    GROUP BY EXTRACT(YEAR FROM creationdate::timestamp)
) AS combined_data
GROUP BY years
ORDER BY years DESC;


-- Четвертое и третье задание

SELECT displayname, COUNT(*) AS comment_count, 
					((COUNT(*) * 100) / (SELECT COUNT(*)
					FROM comments))::numeric || '%' AS percentage_total
FROM users
JOIN comments ON users.id = comments.userid
GROUP BY displayname
ORDER BY comment_count DESC
LIMIT 3;
