
--1

Select l.* from [Lookup] l
left join Jurisdiction j ON l.Id=j.Id
where j.id is null

--2

Select l.* from Jurisdiction j
right join [Lookup] l on l.id=j.id
where j.id is null

--3 

Select l.* from [Lookup] l
left join PracticeArea pa on l.id=pa.id
where pa.id is null

--4

Select l.* from PracticeArea pa
right join [Lookup] l on l.id=pa.id
where pa.id is null

--5

select l.* from [Lookup] l
left join IndustrySector i on l.id=i.id
where i.id is null

--6 

select l.* from IndustrySector i
right join [Lookup] l on l.id=i.id
where i.id is null

--7

Select l.* from [Lookup] l
left join PracticeArea pa on l.id=pa.id
where pa.id is null

--8

Select l.* from PracticeArea pa
right join [Lookup] l on l.id=pa.id
where pa.id is null

--9 

select l.* from [Lookup] l
left join LawyerTier lt on lt.id=l.id
where lt.id is null

--10
select top 100* from firm
select l.* from LawyerTier lt
right join [Lookup] l on lt.id=l.id
where lt.id is null

--11 

select f.Id,f.[Name],
case 
	when g.name is not null then g.name
	when c.name is not null then c.name
	else 'N/A'
	end as [Country/GlobalFirm]
from firm f
left join Country c on f.Id=c.Id
left join Firm g on f.Id=g.GlobalFirm_Id

--12

select f.Id,f.[Name],CONCAT_WS(' ',a.Line1,a.Line2,a.Line3,a.POBox,c.name) as [Address]
from firm f
left join [Address] a on f.Address_Id=a.id
left join Country c on a.country_id=c.id

--13 
select f.Id,f.[Name],
ISNULL(fl.OriginalFileName,'') as Logo,
ISNULL(fi1.OriginalFileName,'') as IconRecognition,
ISNULL(a.ImageName,'') as Advert,
ISNULL(fi2.OriginalFileName,'') as IconRecognition2
from firm f
left join AdvertFirm af on f.Id=af.Firm_Id
left join Advert a on af.Advert_Id=a.Id
left join [File] fl on f.Logo_Id=fl.Id	
left join [File] fi1 on f.IconRecognition_Id=fi1.Id	
left join [File] fi2 on f.IconRecognition2_Id=fi2.Id	

--14

select distinct
f.Id,
f.[Name],
COALESCE(c.[name],'') as Country,
COALESCE(g.[name],'') as GlobalFirm,
f.IsSponsored,
f.[Description],
f.EntityStatus,
COALESCE(CONCAT_WS(a.Line1,' ',a.Line2,' ',a.Line3,' ',a.POBox),'') as [Address],
f.Phone,
f.Fax,
f.Email,
f.Web,
f.FirmType,
COALESCE(CONCAT_WS(ue.Forename,' ',ue.Surname),'') as [Editor],
COALESCE(fl.OriginalFileName,'') as Logo,
COALESCE(fi.OriginalFileName,'') as IconRecognition,
COALESCE(aa.ImageName,'') as Advert,
COALESCE(fi2.OriginalFileName,'') as IconRegocnition2,
f.CreatedOn,
f.LastUpdatedOn,
COALESCE(CONCAT_WS(ue.Forename,' ',ue.Surname),'') as [CreatedBy],
COALESCE(CONCAT_WS(ue.Forename,' ',ue.Surname),'') as [LastUpdatedBy],
f.UpdatedForNextYear,
f.EMLUpgrade,
f.InsightUrl,
COALESCE(fimg.OriginalFileName,'') as InsightImage,
f.SubmissionToolId as SubmissionTool,
f.AsialawId as Asialaw
from firm f
left join [Address] a on f.Address_Id=a.Id
left join country c on a.Country_Id=c.Id
left join Firm g on f.Id=g.GlobalFirm_Id
left join Advertfirm adf on f.id=adf.firm_id
left join Advert aa on adf.advert_Id=aa.id
left join [File] fl on f.Logo_Id=fl.Id	
left join [File] fi on f.IconRecognition_Id=fi.Id	
left join [File] fi2 on f.IconRecognition2_Id=fi2.Id	
left join [File] fimg on f.InsightImage_Id=fimg.Id
left join [User] ue on f.Editor_Id=ue.Id
left join [User] uc on f.CreatedBy_Id=ue.Id
left join [User] uu on f.LastUpdatedBy_Id=ue.Id

--15

select distinct
lr.id,
lr.entityStatus,
lr.overview,
COALESCE(lu.[name],'') as Jurisdiction,
COALESCE(CONCAT_WS(l.FirstName,' ',l.LastName),'') as Lawyer,
COALESCE(p.[Year],'') as [Period],
lr.CreatedOn,
lr.LastUpdatedOn,
COALESCE(CONCAT_WS(ue.Forename,' ',ue.Surname),'') as [Editor],
COALESCE(CONCAT_WS(ue.Forename,' ',ue.Surname),'') as [CreatedBy],
COALESCE(CONCAT_WS(ue.Forename,' ',ue.Surname),'') as [LastUpdatedBy]
from lawyerreview lr
left join Jurisdiction j on lr.Jurisdiction_id=j.id
left join [lookup] lu on lu.id=j.id
left join [User] ue on lr.Editor_Id=ue.Id
left join [User] uc on lr.CreatedBy_Id=ue.Id
left join [User] uu on lr.LastUpdatedBy_Id=ue.Id
left join Lawyer l on lr.lawyer_id=l.id
left join [Period] p on lr.Period_Id=p.id


-- 16

select 
l.[name] as Jurisdiction
from jurisdiction j
left join [lookup] l on j.id=l.id
left join lawyerreview lr on lr.jurisdiction_id=j.id
where lr.id is null

--17

select l.*
from lawyer l
left join  lawyerreview lr on lr.lawyer_id=l.id
where lr.id is null

--18

select lr.id,l.FirstName,l.LastName,lu.[name] as JurisdictionName
from lawyerreview lr
left join Lawyer l on lr.lawyer_id=l.id
left join Jurisdiction j on lr.Jurisdiction_id=j.id
left join [lookup] lu on lu.id=j.id
left join [Period] p on lr.Period_id=p.id
where p.[year] in (2018,2020)

--19 practicearea

select l.FirstName,l.LastName, l.Email, CONCAT_WS(' ',a.Line1,a.Line2,a.Line3,a.POBox) as [Address], l.JobPosition,lu.[Name]
from PracticeAreaLawyer par
left join lawyer l on par.lawyer_id=l.id
left join [address] a on l.address_id=a.id
left join practicearea pa on par.PracticeArea_id=pa.id
left join [lookup] lu on pa.id=lu.id

--20

select distinct l.FirstName,l.LastName
from LawyerRanking lr
left join lawyer l on lr.tier_id=l.tier_id
left join lawyertier lt on lt.id=lr.tier_id
where l.jobPosition like '%Expert Consultant%'



--select   * from lawyerranking
--where lawyer_id = 80947
--select* from lawyer
--where jobposition like '%Rising star partner%'
--select * from lawyerranking where lawyer_id in(select id from lawyer where jobposition like '%Expert Consultant%')


--21

select distinct l.FirstName,l.LastName
from LawyerRanking lr
left join lawyer l on lr.lawyer_id=l.id
left join lawyertier lt on lt.id=lr.tier_id
where l.jobPosition like '%Rising star partner%'

--22 

select distinct l.FirstName,l.LastName
from LawyerRanking lr
left join lawyer l on lr.tier_id=l.tier_id
left join lawyertier lt on lt.id=lr.tier_id
where l.jobPosition like '%Women Leaders%'

--23

SELECT *
FROM Lawyer l
WHERE NOT EXISTS(
	SELECT *
	FROM LawyerRanking lr
	WHERE l.Id = lr.Lawyer_Id
)

--select firstname,lastname from lawyer
--where jobposition is null

--24

select f.id,f.[name] as FirmName,jlu.[name] as Jurisdiction,p.[year] as [Period],palu.name as PracticeArea,tlu.name as Tier
from rankingtierfirm rtf
left join firm f on f.id=rtf.firm_id
left join firmranking fr on rtf.firmranking_id=fr.id
left join [period] p on fr.period_id=p.id
left join practicearea pa on fr.practicearea_id=pa.id
left join [lookup] palu on pa.id=palu.id
left join firmtier ft on rtf.tier_id=ft.id
left join [lookup] tlu on tlu.id=ft.id
left join jurisdictionfirm jf on jf.firm_id=f.id
left join jurisdiction j on jf.jurisdiction_id=j.id
left join [lookup] jlu on jlu.id=j.id

--25

select f.id,f.[name] as FirmName,jlu.[name] as Jurisdiction,tlu.name as Tier
from rankingtierfirm rtf
left join firm f on f.id=rtf.firm_id
left join firmranking fr on rtf.firmranking_id=fr.id
left join firmtier ft on rtf.tier_id=ft.id
left join [lookup] tlu on tlu.id=ft.id
left join jurisdictionfirm jf on jf.firm_id=f.id
left join jurisdiction j on jf.jurisdiction_id=j.id
left join [lookup] jlu on jlu.id=j.id
where tlu.[name]='Tier 1' and jlu.[name]='Australia'

--26

select f.id,f.[name] as FirmName,jlu.[name] as Jurisdiction,tlu.name as Tier
from rankingtierfirm rtf
left join firm f on f.id=rtf.firm_id
left join firmranking fr on rtf.firmranking_id=fr.id
left join firmtier ft on rtf.tier_id=ft.id
left join [lookup] tlu on tlu.id=ft.id
left join jurisdictionfirm jf on jf.firm_id=f.id
left join jurisdiction j on jf.jurisdiction_id=j.id
left join [lookup] jlu on jlu.id=j.id
where tlu.[name]='Tier 3' and jlu.[name]='China'

--27  

select f.id,f.[name] as FirmName,jlu.[name] as Jurisdiction,tlu.name as Tier
from rankingtierfirm rtf
left join firm f on f.id=rtf.firm_id
left join firmranking fr on rtf.firmranking_id=fr.id
left join firmtier ft on rtf.tier_id=ft.id
left join [lookup] tlu on tlu.id=ft.id
left join jurisdictionfirm jf on jf.firm_id=f.id
left join jurisdiction j on jf.jurisdiction_id=j.id
left join [lookup] jlu on jlu.id=j.id
where tlu.[name]='Tier 3' and jlu.[name]='China'

--28

select f.id,f.[name] as FirmName,jlu.[name] as Jurisdiction,tlu.name as Tier,p.[year] as [Period]
from rankingtierfirm rtf
left join firm f on f.id=rtf.firm_id
left join firmranking fr on rtf.firmranking_id=fr.id
left join firmtier ft on rtf.tier_id=ft.id
left join [lookup] tlu on tlu.id=ft.id
left join jurisdictionfirm jf on jf.firm_id=f.id
left join jurisdiction j on jf.jurisdiction_id=j.id
left join [lookup] jlu on jlu.id=j.id
left join [period] p on fr.period_id=p.id
where tlu.[name]='Tier 1' and jlu.[name]='Barbados' and p.[year]=2014
