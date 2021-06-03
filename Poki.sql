--1. What grades are stored in the database?
select *
	from Grade;

--2. What emotions may be associated with a poem?
select *
	from Emotion;

--3.How many poems are in the database?
select MAX(id) NumberOfPoems
	from Poem;

--4. Sort authors alphabetically by name. What are the names of the top 76 authors?
select top 76 a.Name
	from Author a
	order by Name;

--5. Starting with the above query, add the grade of each of the authors.
select top 76 a.name,
	g.name
	from Author a
	left join grade g on a.GradeId = g.Id
	order by a.Name;

--6. Starting with the above query, add the recorded gender of each of the authors.
select top 76 a.name,
	g.name Grade,
	ge.name Gender
	from Author a
	left join Grade g on a.GradeId = g.Id
	left join Gender ge on a.GenderId = ge.Id
	order by a.name;

--7. What is the total number of words in all poems in the database?
select SUM(WordCount) TotalWords
	from Poem;

--8. Which poem has the fewest characters?
select p.title,
	p.charcount
	from Poem p
	where p.CharCount in
	(select MIN(CharCount)
	from Poem);

--9. How many authors are in the third grade?
select COUNT(g.Id) Authors
	from Author a
	left join Grade g on a.GradeId = g.Id
	where g.Id = 3;

--10. How many total authors are in the first through third grades?
select COUNT(g.Id) Authors
	from Author a
	left join Grade g on a.GradeId = g.Id
	where g.Id <= 3;

--11. What is the total number of poems written by fourth graders?
select COUNT(p.id) Poems
	from Poem p
	left join Author a on p.AuthorId = a.Id
	where a.GradeId = 4;

--12. How many poems are there per grade?
select COUNT(p.id) Poems, g.name
	from Poem p
	left join Author a on p.AuthorId = a.Id
	left join Grade g on a.GradeId = g.id
	where a.GradeId <= 5
	group by g.Name;

--13. How many authors are in each grade? (Order your results by grade starting with 1st Grade)
select COUNT(a.id) Authors, g.name Grade
	from Author a
	left join Grade g on a.GradeId = g.Id
	where a.GradeId <= 5
	group by g.Name
	order by 2 asc;

--14. What is the title of the poem that has the most words?
select top 1 p.title, p.wordcount
	from Poem p
	order by p.WordCount desc;

--15. Which author(s) have the most poems? (Remember authors can have the same name.)
select top 1 COUNT(p.title) NumberOfPoems, a.Name, a.Id
	from Author a
	left join Poem p on p.AuthorId = a.Id
	group by a.Name, a.Id
	order by 1 desc;

--16. How many poems have an emotion of sadness?
select COUNT(p.id) Poems
	from PoemEmotion pe
	left join Poem p on pe.PoemId = p.Id
	left join Emotion e on pe.EmotionId = e.Id
	where pe.EmotionId = 3;

--17. How many poems are not associated with any emotion?
select COUNT(p.id) Poems
	from Poem p
	left join PoemEmotion pe on pe.PoemId = p.Id
	where pe.EmotionId is null;

--18. Which emotion is associated with the least number of poems?
select top 1 COUNT(pe.poemId), e.name
	from PoemEmotion pe
	left join Emotion e on pe.EmotionId = e.Id
	group by e.Name
	order by count(pe.PoemId) asc;

--19. Which grade has the largest number of poems with an emotion of joy?
select top 1 COUNT(p.id) JoyPoemCount, g.name Grade
	from Poem p
	left join PoemEmotion pe on p.Id = pe.PoemId
	left join Emotion e on pe.EmotionId = e.Id
	left join Author a on p.AuthorId = a.Id
	left join Grade g on a.GradeId = g.Id
	group by e.Name, e.Id, g.Name
	having e.Name is not null and e.Id = 4
	order by COUNT(p.id) desc;

--20. Which gender has the least number of poems with an emotion of fear?
select top 1 COUNT(p.id) FearPoemCount, g.name Gender
	from Poem p
		left join PoemEmotion pe on p.Id = pe.PoemId
		left join Emotion e on pe.EmotionId = e.Id
		left join Author a on p.AuthorId = a.Id
		left join Gender g on a.GenderId = g.Id
		group by e.Name, e.Id, g.Name
		having e.Name is not null and e.id = 3
		order by COUNT(p.Id) asc;
