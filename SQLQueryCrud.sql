

--Id,[Name],Country_Id,GlobalFirm_Id,IsSponosred,[Description],EntityStatus,Address_Id,Phone,Fax,Email,Web,FirmType,Editor_Id,Logo_Id,
--IconRecognition_Id,Advert_Id,IconRecognition2_Id,CreatedOn,LastUpdatedOn,CreatedBy_Id,LastUpdatedBy_Id,UpdatedForNextYear,EMLUpgrade,InsightUrl,InsightImage_Id
--ProfileType,SubmissionToolId,AsialawId

 --Id,EntityStatus,IsFeatured,Title,ShortDescription,Body,Period_Id,
--Sponsor_Id,Type_Id,CreateDate,Author,[Location],NumberOfVisits,Image_Id,ExpireDate,ExternalId,IsSponsored,IsTopFeatured,CreatedOn,
--LastUpdatedOn,CreatedBy_Id,Editor_Id,LastUpdatedBy_Id

select top 100 * from FirmForPracticeLuka 
select top 100 * from ArticleForPracticeLuka 

--1

select * INTO FirmTempLuka
from Firm 
where IsSponsored=1

--2

select Id,'Article' as type,title
into FirmArticle
from article
union all
select Id,'Firm' as type,name as title
from firm;

--4

select * INTO FirmForPracticeLuka 
from Firm

select* INTO ArticleForPracticeLuka 
from Article
 
 --5

begin tran

update FirmForPracticeLuka
	Set 
	email = nullif(email,''),
	Web=nullif(web,'')
	where
	email='' or web='';

rollback
commit

--6 1658 1772 1935
  
 --select top 2000 * from FirmForPracticeLuka
  

begin tran

Update FirmForPracticeLuka
Set 
Fax=nullif(Phone,Fax)
where fax=phone and phone is not null


rollback
commit

--7 5621

--select web from firmforpracticeluka
--where web like '%/'

begin tran

Update FirmForPracticeLuka
set web=left(web,len(web)-1)
where web like '%/' 

rollback
commit

--8 DATEADD(DAY,3,)
IF NOT EXISTS (
	SELECT 1 FROM ArticleForPracticeLuka
		WHERE Title = (select Title+' Copy' from ArticleForPracticeLuka) AND
		 ShortDescription = (select ShortDescription+' Copy' from ArticleForPracticeLuka) AND
		 Body = (select Body+' Copy' from ArticleForPracticeLuka) AND
		 Author = (select Author+' Copy' from ArticleForPracticeLuka) AND
		 [Location] = (select [Location]+' Copy' from ArticleForPracticeLuka)
)
BEGIN
insert into articleforpracticeluka 
select
EntityStatus,
IsFeatured,
Title + ' Copy',
ShortDescription + ' Copy',
Body + ' Copy',
Period_Id,
Sponsor_Id,
[Type_Id],
DATEADD(DAY,3,[CreateDate]),
Author + ' Copy',
[Location] + ' Copy',
NumberOfVisits,
Image_Id,
DATEADD(DAY,3,[ExpireDate]),
ExternalId,
IsSponsored,
IsTopFeatured,
DATEADD(DAY,3,[CreatedOn]),
DATEADD(DAY,3,[LastUpdatedOn]),
CreatedBy_Id,
Editor_Id,
LastUpdatedBy_Id
from articleforpracticeluka
where id=41
END
 
--9
select * from ArticleForPracticeLuka
where id = 59;


begin tran

Update ArticleForPracticeLuka
Set title=N'ŠĐČĆŽ šđčćž ШЂЧЋЖ шђчћж'
where id=59

rollback
commit

--10

Insert into FirmForPracticeLuka 
Select
[Name] + ' Copy',
Country_Id,
GlobalFirm_Id,
IsSponsored,
[Description] + ' Copy',
EntityStatus,
Address_Id,
Phone + ' Copy',
Fax + ' Copy',
Email + ' Copy',
Web,
FirmType,
Editor_Id,
Logo_Id,
IconRecognition_Id,
Advert_Id,
IconRecognition2_Id,
CreatedOn,
LastUpdatedOn,
CreatedBy_Id,
LastUpdatedBy_Id,
UpdatedForNextYear,
EMLUpgrade,
InsightUrl + ' Copy',
InsightImage_Id,
ProfileType,
SubmissionToolId,
AsialawId
from FirmForPracticeLuka
where id>=3 and id<=10

--select top 100 * from FirmForPracticeLuka
--order by id desc

--select top 100 * from FirmForPracticeLuka
--order by id asc

--11

select top 0 * 
into #TempFirm
from Firm
--select * from #TempFirm

--12

select * into #TempFirm2
from (select top (select count(*) from firm)
Id as Identifikator,
[Name] as NazivFirme
from Firm
order by [name] asc)
as OrderedFirms

Drop table #Tempfirm2
select * from #Tempfirm2

