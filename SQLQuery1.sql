--1

select top 10 * from article
where IsSponsored= 1
order by CreateDate desc

--2

select top 20 * from article
where Title like '%Legal%'
order by CreateDate desc

--3

select top 10 * from article
where Title like 'Legal%'
order by CreateDate desc

--4

select top 20 * from article
where Title like '%Legal'
order by CreateDate desc

--5

select top 10 * from article 
where year(ExpireDate)=2019
order by CreateDate asc

--6

select * from article 
where ExpireDate>'2018-09-01' and ExpireDate<'2018-12-31'

--7 

select id,title,author,
CASE
    WHEN IsSponsored=1 THEN 'yes'
    ELSE 'no'
END as IsSponsored
from article
where ExpireDate>'2019-01-01' and ExpireDate<'2020-12-31'


--8

select top 10 * from article
where  YEAR(CreateDate) in (2018,2019)
order by NumberOfVisits desc

--9

select top 100 * from article
where len(title)<31
order by CreateDate desc

--10 

Select top 200
id,
EntityStatus,
IsFeatured,
Title,
ShortDescription,
body,
Period_Id,
COALESCE(CAST(Sponsor_Id as varchar(10)),'N/A') as 'Sponsor_Id',
Type_Id,
CreateDate,
COALESCE(Author,'N/A') as 'Author',
COALESCE(Location,'N/A') as 'Location',
NumberOfVisits,
COALESCE(CAST(Image_Id as varchar(10)),'N/A') as 'Image_Id',
ExpireDate,
COALESCE(CAST(ExternalId as varchar(10)),'N/A') as 'ExternalId',
IsSponsored,
IsTopFeatured,
CreatedOn,
LastUpdatedOn,
COALESCE(CAST(CreatedBy_Id as varchar(10)),'N/A') as 'CreatedBy_Id',
COALESCE(CAST(Editor_Id as varchar(10)),'N/A') as 'Editor_Id',
COALESCE(CAST(LastUpdatedBy_Id as varchar(10)),'N/A') as 'LastUpdatedBy_Id'
from Article
order by CreateDate desc


--11

Select top 500 id,EntityStatus,IsFeatured,Title,ShortDescription,Period_Id,Sponsor_Id,Type_Id,CreateDate,author,location,
NumberOfVisits,Image_Id,ExpireDate,ExternalId,IsSponsored,IsTopFeatured,CreatedOn,LastUpdatedBy_Id,CreatedBy_Id,
CONCAT('Secret',' ',year(expireDate),' ', 'number of visits',' ', NumberOfVisits) as SecretYear
from article
where title like '%Panama%'
order by ExpireDate asc,NumberOfVisits desc

--12

select id,title,
CASE
    WHEN NumberOfVisits<1000 THEN 'Slabo posecen'
    WHEN NumberOfVisits>1000 and NumberOfVisits<2000 THEN 'Srednje posecen'
	ELSE 'Visoko posecen'
END as NumberOfVisitsDescriptive
from article
order by title asc

--13

select * from Firm
where Email IS NOT NULL and Email <>''

--14

select * from Firm
where (Email IS NOT NULL and Email <>'') and (Web IS NOT NULL and Web <>'')

--15

select *from Firm
where Email IS NULL or Email =''

--16

select * from Firm
where (Email IS  NULL or Email ='') and (Web IS NULL or Web ='')

--17

select * from Firm
where (Email IS NULL or Email ='') and (Web IS NOT NULL and Web <>'')

--18

select * from firm
where Logo_Id IS NOT NULL and Logo_Id<>''

--19

select * from firm
where Logo_Id ='' or Logo_Id IS NULL

--20

select * from firm
where (Logo_Id IS NOT NULL and Logo_Id<>'') and year(LastUpdatedOn)>2022

--21

select * from article
where ExpireDate>=DATEADD(month,-3,getdate()) and ExpireDate<=GETDATE()

--22

select * from article
where ExpireDate between DATEADD(day,-30,GETDATE()) and GETDATE()

--23

select * from article
where ExpireDate > GETDATE()

--24

select * from Article
where Location='Mexico' and NumberOfVisits>100

--25

Select Id,CONCAT(Title,' - ',Author,', ', 'number of visits',' ', NumberOfVisits) as TitleAuthorNumberOfVisits from Article
where ExpireDate>GETDATE()

--1

select distinct substring(email,charindex('@',email)+1,LEN(email)) as Domeni from Lawyer
where email like '%@%' and Email IS NOT NULL

--2

select distinct  substring(email,charindex('@',email)+1,LEN(email)) as Domeni from Lawyer
where (email like '%@%' and Email IS NOT NULL) and (LastUpdatedOn>='2023-10-01' and LastUpdatedOn<'2024-01-01') 
