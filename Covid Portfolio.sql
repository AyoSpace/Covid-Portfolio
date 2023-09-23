
Select *
From PortfolioProject.dbo.[Covid death]
where continent is not null
order by 3,4


--Select *
--From PortfolioProject.dbo.[Covid vaccination]
--order by 3,4

Select Location, date, new_cases, total_cases, total_deaths, population
From PortfolioProject.dbo.[Covid death]
where continent is not null
order by 1,2

Select Location, date, total_cases, total_deaths, (cast(total_deaths as numeric))/(cast(total_cases as numeric))*100 as DeathPercentage
From PortfolioProject.dbo.[Covid death]
where continent is not null
order by 1,2

Select Location, date, total_cases, total_deaths, (cast(total_deaths as numeric))/(cast(total_cases as numeric))*100 as DeathPercentage
From PortfolioProject.dbo.[Covid death]
where location like '%states%'
and continent is not null
order by 1,2

Select Location, date, total_cases, total_deaths, (cast(total_deaths as numeric))/(cast(total_cases as numeric))*100 as DeathPercentage
From PortfolioProject.dbo.[Covid death]
where location like '%Europe%'
and continent is not null
order by 1,2

Select Location, date, total_cases, total_deaths, (cast(total_deaths as numeric))/(cast(total_cases as numeric))*100 as DeathPercentage
From PortfolioProject.dbo.[Covid death]
where location like '%Africa%'
and continent is not null
order by 1,2

Select Location, date, total_cases, total_deaths, (cast(total_deaths as numeric))/(cast(total_cases as numeric))*100 as DeathPercentage
From PortfolioProject.dbo.[Covid death]
where location like '%Nigeria%'
and continent is not null
order by 1,2

Select Location, date, total_cases, total_deaths, (cast(total_deaths as numeric))/(cast(total_cases as numeric))*100 as DeathPercentage
From PortfolioProject.dbo.[Covid death]
where location like '%Asia%'
--and continent is not null
order by 1,2

Select Location, date, Population, total_cases,  (total_cases/Population)*100 as PercentPopuationInfected
From PortfolioProject.dbo.[Covid death]
where location like '%Europe%'
and continent is not null
order by 1,2

Select Location, date, Population, total_cases,  (total_cases/Population)*100 as PercentPopuationInfected
From PortfolioProject.dbo.[Covid death]
where location like '%Africa%'
and continent is not null
order by 1,2

Select Location, date, Population, total_cases,  (total_cases/Population)*100 as PercentPopuationInfected
From PortfolioProject.dbo.[Covid death]
where location like '%Asia%'
and continent is not null
order by 1,2




Select Location, date, Population, total_cases,  (total_cases/Population)*100 as PercentPopuationInfected
From PortfolioProject.dbo.[Covid death]
where location like '%States%'
and continent is not null
order by 1,2


Select Location, date, Population, total_cases,  (total_cases/Population)*100 as PercentPopuationInfected
From PortfolioProject.dbo.[Covid death]
where continent is not null
order by 1,2




Select Location, Population, MAX(total_cases) as HighestInfectionCount,  MAX((total_cases/Population))*100 as PercentPopuationInfected
From PortfolioProject.dbo.[Covid death]
where continent is not null
Group by location, population
order by PercentPopuationInfected desc


Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject.dbo.[Covid death]
where continent is not null
Group by location
order by TotalDeathCount desc



Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject.dbo.[Covid death]
where continent is null
Group by location
order by TotalDeathCount desc


Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject.dbo.[Covid death]
where continent is not null
Group by continent
order by TotalDeathCount desc




SELECT
  date,
  SUM(new_cases) as total_cases,
  SUM(cast(new_deaths as int)) as total_deaths,
  CASE WHEN SUM(new_cases) <> 0 THEN SUM(cast(new_deaths as int)) / ISNULL(SUM(new_cases), 0) * 100 ELSE 0 END AS deathpercentagebyday
FROM PortfolioProject.dbo.[Covid death]
WHERE continent IS NULL
GROUP BY date
ORDER BY 1, 2;


Select dea.continent, dea.location, dea.date, dea.population, vac.total_vaccinations, 
 Sum(cast(vac.total_vaccinations as numeric)) OVER (partition by dea.location order by  dea.location,
 dea.date) as RollingPeoplevaccinated
From PortfolioProject.dbo.[Covid death] dea
join PortfolioProject.dbo.[Covid vaccination] vac
   on dea.location = vac.location
   and dea.date = vac.date
   where dea.continent is not null
   ORDER BY 1, 2, 3


   with PopVac(Continent, location, date, population, total_vaccinations, RollingPeopleVaccinated)
   as
   (
   Select dea.continent, dea.location, dea.date, dea.population, vac.total_vaccinations, 
 Sum(cast(vac.total_vaccinations as numeric)) OVER (partition by dea.location order by  dea.location,
 dea.date) as RollingPeoplevaccinated
From PortfolioProject.dbo.[Covid death] dea
join PortfolioProject.dbo.[Covid vaccination] vac
   on dea.location = vac.location
   and dea.date = vac.date
   where dea.continent is not null
   --ORDER BY 1, 2, 3
   )

   Select * , (RollingPeopleVaccinated/population)* 100
   from PopVac


   create view PercentagePopulationVaccinated as
    Select dea.continent, dea.location, dea.date, dea.population, vac.total_vaccinations, 
 Sum(cast(vac.total_vaccinations as numeric)) OVER (partition by dea.location order by  dea.location,
 dea.date) as RollingPeoplevaccinated
From PortfolioProject.dbo.[Covid death] dea
join PortfolioProject.dbo.[Covid vaccination] vac
   on dea.location = vac.location
   and dea.date = vac.date
   where dea.continent is not null
   --ORDER BY 1, 2, 3

   Create view GlobalCovidDeathByDay as
SELECT
  date,
  SUM(new_cases) as total_cases,
  SUM(cast(new_deaths as int)) as total_deaths,
  CASE WHEN SUM(new_cases) <> 0 THEN SUM(cast(new_deaths as int)) / ISNULL(SUM(new_cases), 0) * 100 ELSE 0 END AS deathpercentagebyday
FROM PortfolioProject.dbo.[Covid death]
WHERE continent IS NULL
GROUP BY date
--ORDER BY 1, 2;

