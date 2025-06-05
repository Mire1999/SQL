--1

select f.id,f.[name], count(paf.practicearea_id) as PracticeAreaCount
from firm f
inner join PracticeAreaFirm paf on paf.firm_id=f.id
group by f.id,f.[name]

--2

select f.id,f.[name], count(paf.practicearea_id) as PracticeAreaCount
from firm f
inner join PracticeAreaFirm paf on paf.firm_id=f.id
group by f.id,f.[name]
having count(paf.practicearea_id)>5

--3

select f.id,f.[name], count(paf.practicearea_id) as PracticeAreaCount
from firm f
inner join PracticeAreaFirm paf on paf.firm_id=f.id
group by f.id,f.[name]
having count(paf.practicearea_id)<5

--4

select l.id,l.FirstName,L.LastName,count(pal.PracticeArea_Id) as PracticeAreaCount
from Lawyer l
inner join PracticeAreaLawyer pal on pal.lawyer_id=l.id
group by l.id,l.FirstName,L.LastName

--5

select top 10 practicearea_id,count(firm_id) as BrojFirmi
from practiceareafirm
group by practicearea_id
order by count(firm_id) desc

--6

select top 20 practicearea_id,count(lawyer_id) as BrojLawyera
from practicearealawyer
group by practicearea_id
order by count(lawyer_id) desc

--7

select top 15 practicearea_id,count(firm_id) as BrojFirmi
from practiceareafirm
group by practicearea_id
having count(firm_id)>0
order by count(firm_id) asc

--8

select c.[name], count(f.country_id) as BrojPovezanihFirmi
from firm f
inner join country c on c.id=f.country_id
group by c.[name]

--9

select c.[name], count(f.country_id) as BrojPovezanihFirmi, string_agg(cast(f.[name] as NVARCHAR(MAX)),', ') as ListaPovezanihFirmi
from firm f
inner join country c on c.id=f.country_id
group by c.[name]

--10

select a.Sponsor_id,f.[name] as NazivSponzora,count(a.sponsor_id) as BrojVezanihArtikala,string_agg(cast(a.id as VARCHAR(MAX)),', ') as ListaIDa
from article a
inner join firm f on a.sponsor_id=f.id
group by a.sponsor_id,f.[name]

--11

select deal.[Year],deal.[Month],count(*) as UkupanBrojDealova,sum(DollarValue) as UkupanIznos, avg(DollarValue) as ProsecanIznos,min(DollarValue) as MinimalnaVrednost,max(DollarValue) as MaksimalnaVrednost
from Deal
where EntityStatus=3
group by deal.[Year],deal.[Month]

--12

select d.id,d.title,
string_agg(Cast(pal.[name] as NVARCHAR(MAX)),', ') as SvePracticeArea ,
string_agg(CAST(l.FirstName || ' ' || l.lastname AS NVARCHAR(MAX)),', ') as SviLawyeri,
string_agg(CAST(jl.[name] AS NVARCHAR(MAX)),', ') as Jurisdikcija,
string_agg(CAST(gl.[title] AS NVARCHAR(MAX)),', ') as GoverningLaw
from deal d
inner join DealGoverningLaw dgl on dgl.deal_id=d.id
inner join governinglaw gl on dgl.governinglaw_id=gl.id
inner join dealjurisdiction dj on d.id=dj.deal_id
inner join jurisdiction j on dj.jurisdiction_id=j.id
inner join [lookup] jl on jl.id=j.id
inner join dealpracticearea dpa on d.id=dpa.deal_id
inner join practicearea pa on pa.id=dpa.practicearea_id
inner join [lookup] pal on pal.id=pa.id
inner join deallawyer dl on d.id=dl.deal_id
inner join lawyer l on dl.lawyer_id=l.id
group by d.id,d.title

--13 

select id,title
from deal d
where d.[value]>(
	select avg([value])
	from deal
	where [value]>0
)

--14

select CAST(CreatedOn as Date),Count(*) as CountDeals
from deal
group by CreatedOn
order by CountDeals desc

--15

select 
CONCAT_WS(' ',e.Forename,e.Surname) as Editor,
count(*) as CountDeals
from deal d
inner join [User] e on e.id=d.Editor_id
group by CONCAT_WS(' ',e.Forename,e.Surname)
order by CountDeals desc

--16

select 
TabelaGodina.Godina,
CONCAT_WS(' ',e.Forename,e.Surname) as Editor,
count(*) as CountReviews
from (
	select distinct Year(CreatedOn) as Godina
	from Deal
) as TabelaGodina
cross apply (
	select top 1 d.Editor_Id
	from deal d
	where Year(d.CreatedOn)=TabelaGodina.Godina
	group by d.Editor_Id
	order by count(*) desc
) as NajboljiEditor
inner join [user] e on e.id=NajboljiEditor.Editor_id
inner join deal d2 on d2.Editor_id=NajboljiEditor.Editor_id AND Year(d2.CreatedOn)=TabelaGodina.Godina
group by TabelaGodina.Godina,CONCAT_WS(' ',e.Forename,e.Surname)
order by TabelaGodina.Godina desc


--17

select c.Id as CurrencyId,l.[name] as CurrencyName, Count(*) as CountDeals,string_agg(cast(d.Title as NVARCHAR(MAX)),', ') as Deals
from Currency c
inner join Deal d on c.id=d.currency_id
inner join [lookup] l on c.id=l.id
group by c.id,l.[name]
order by CountDeals desc


--Not exists je efikasnija za velike kolicine podataka, join je sporiji jer pravi veliku temp tabelu  sa svim redovima, bez obzira da li se poklapaju ili ne, where not exists je sigurniji sa null vrednostima

select u.*
from [user] u 
where not exists (
	select 1 from deal d
	where d.editor_id=u.id
)

select u.*
from [user]	u
left join deal d on u.id=d.editor_id
where d.id is null

-- ovde oba imaju isti cost

