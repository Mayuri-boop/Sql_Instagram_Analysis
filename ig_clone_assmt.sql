use ig_clone
 /*1. We want to reward the user who has been around the longest, Find the 5 oldest users. */

select * from users where Year(created_at) =2016
Order by created_at asc
Limit 5

 /*2 To target inactive users in an email ad campaign, find the users who have never posted a photo. */;
 
select * from users as u
inner join photos as p
on u.id =p.id

/*3  Suppose you are running a contest to find out who got the most likes on a photo. Find out who won? */

select user_id,count(photo_id) from likes
group by user_id
Order by count(photo_id) Desc

/*4  The investors want to know how many times does the average user post. */

SELECT ROUND((SELECT COUNT(*)FROM photos)/(SELECT COUNT(*) FROM users),2) as avg_post;

 /*5  A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags. */

SELECT tag_name, COUNT(tag_name) AS total
FROM tags
JOIN photo_tags ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY total DESC
limit 5

/*6 Find users who have never commented on a photo */
select id ,username from users where id NOT IN (select user_id from comments)
    
/*7 Find users who have liked every single photo on the site*/

SELECT users.id,username, COUNT(users.id) As total_likes_by_user
FROM users
JOIN likes ON users.id = likes.user_id
GROUP BY users.id
HAVING total_likes_by_user = (SELECT COUNT(*) FROM photos);

/* 8 Find the users who have created instagramid in may and select top 5 newest joinees from it? */
select * from users where month(created_at) = '05'
order by created_at Desc
Limit 5



/* 9 Can you help me find the users whose name starts with c and ends with any number and
 have posted the photos as well as liked the photos? */

select * from users u 
join photos p on p.id=u.id
join likes l on l.user_id=p.user_id
where u.username regexp '^(C)' and u.username regexp '[0-9]$'

/* 10 Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5. */

with 
user_photo as(select user_id,count(*) as no_of_posts from photos group by user_id having no_of_posts between 3 and 5 ),
user_details as (select * from users where id in (select user_id from user_photo))
select * from user_details limit 30