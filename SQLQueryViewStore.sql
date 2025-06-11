
--1
create view vFirmPracticeAreasStats_LukaMirkovic as

select f.id,f.[name], count(paf.practicearea_id) as PracticeAreaCount
from firm f
inner join PracticeAreaFirm paf on paf.firm_id=f.id
group by f.id,f.[name]
 
 select * from vFirmPracticeAreasStats_LukaMirkovic
 select * into #TempTabela from vFirmPracticeAreasStats_LukaMirkovic
 select * from #TempTabela
 drop table #TempTabela

 --2

 create  view vCountryRelatedFirms_LukaMirkovic as

 select c.[name], count(f.country_id) as BrojPovezanihFirmi, string_agg(cast(f.[name] as NVARCHAR(MAX)),', ') as ListaPovezanihFirmi
from firm f
inner join country c on c.id=f.country_id
group by c.[name]


select * from vCountryRelatedFirms_LukaMirkovic

select * into #TempTable
from vCountryRelatedFirms_LukaMirkovic 
where BrojPovezanihFirmi>1000

select * from #TempTable
drop table #TempTable

--3

CREATE VIEW vFirmPracticeAreasStats_LukaMirkovic_COPY as
select * from vFirmPracticeAreasStats_LukaMirkovic


select * from vFirmPracticeAreasStats_LukaMirkovic_COPY

--4

ALTER VIEW vFirmPracticeAreasStats_LukaMirkovic_COPY as
select f.id,f.[name], count(paf.practicearea_id) as PracticeAreaCount,'test' as NovaKolona
from firm f
inner join PracticeAreaFirm paf on paf.firm_id=f.id
group by f.id,f.[name]

--5

create view vDealWithValueGreaterThanAverage_LukaMirkovic as

select id,title
from deal d
where d.[value]>(
	select avg([value])
	from deal
	where [value]>0
)

select 
v.id,
v.title,
string_agg(CAST(l.FirstName || ' ' || l.lastname AS NVARCHAR(MAX)),', ') as Lawyeri
from vDealWithValueGreaterThanAverage_LukaMirkovic v
left join DealLawyer dl on dl.deal_id=v.id
left join Lawyer l on dl.lawyer_id=l.id
group by v.id,v.title

--6

select [dbo].SpajanjeStringa('String1','STring2')

--7

select [dbo].DodajDane(GETDATE(),12)

--8

select  id,[dbo].SpajanjeStringa(FirstName,LastName) as Lawyer
from lawyer

--9

select  * from article
where ExpireDate=dbo.DodajDane(GETDATE(),-7)

--10

select * from dbo.VratiPracticeArea()

--11

select
pa.*,
string_agg(Cast(f.[name] as NVARCHAR(MAX)),' | ') as firme
from dbo.VratiPracticeArea() pa
left join practiceareafirm paf on paf.practicearea_id=pa.id
left join firm f on f.id=paf.firm_id
group by pa.id,pa.[name]


--STORE

--1

exec dbo.spFirmPracticeAreas_LukaMirkovic

--2

exec dbo.NapraviIzvestaj
select * from dbo.ReportFirmPracticeAreas_LukaMirkovic

--3

exec dbo.spDealsGreaterThanAverage_LukaMirkovic 
SELECT * FROM ReportDealsGreaterThanAverage_LukaMirkovic

--4

select * from deal
where id in (1,2,3,81,80,81,90,100,104)
exec dbo.spDealByIdsAndValueRange_LukaMirkovic @DealIds='1,2,3',@DealValueFrom = 0, @DealValueTo= 10000000
exec dbo.spDealByIdsAndValueRange_LukaMirkovic @DealIds='1,2,3,81,80,81,90,100,104',@DealValueFrom = 0, @DealValueTo= 3600000000.00

--5

select * from article
exec dbo.spReportNotExpiredArticles_LukaMirkovic
SELECT * FROM ReportNotExpiredArticles_LukaMirkovic

--6

exec dbo.spVratiFirme @tierName='Tier 1',@jurisdictionName='Barbados',@year=2014
exec dbo.spVratiFirme @tierName='Tier 3',@jurisdictionName='China',@year=2014
exec dbo.spVratiFirme @tierName='Tier 1',@jurisdictionName='Australia',@year=2014














