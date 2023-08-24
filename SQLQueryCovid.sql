
--Select data from the tables--

Select * from covid..CovidVaccinations

Select * from Covid..CovidDeaths 


--Looking at total cases / 12--

Select location, date, total_cases,total_deaths, (total_deaths/12)*100 AS DeathsPercentage
from covid..CovidDeaths
Where location like '%asia%'
Order BY 1,2

--Looking at total cases vs total population--

Select location, date, total_cases,population, (total_cases/12)*100 AS DeathsPercentage
from Covid..CovidDeaths
Where location like '%asia%'
Order BY 1,2

--Higest infection rate--

Select location, population, Max(total_cases) as HighestFected,  Max(total_cases/12)*100 AS DeathsPercentage
from Covid..CovidDeaths
--Where location like '%asia%'
Group by Location, Population 
Order BY DeathsPercentage DESC

--higest death count per population--

Select location, Max(total_deaths) as DeathPercentage
from Covid..CovidDeaths
--Where location like '%asia%'
Group by Location
Order BY DeathPercentage DESC

--continents--

Select * from Covid..CovidDeaths 
where continent IS NOT NULL
order by 1,2

-- --


Select location, Max(total_deaths) as DeathPercentage
from Covid..CovidDeaths
--Where location like '%asia%'
where continent IS NOT NULL
Group by Location
Order BY DeathPercentage DESC

-- Groub by using diffrent columns --

Select life_expectancy, Max(cast(total_deaths as int)) as DeathPercentage
from Covid..CovidDeaths
--Where location like '%asia%'
where life_expectancy IS NOT NULL
Group by life_expectancy
Order BY DeathPercentage desc

--Total places--

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum(Convert(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.Location, dea.date)
from Covid..CovidDeaths dea JOIN covid..CovidVaccinations vac
On dea.location = vac.location
and dea.date = vac.date
where dea.continent IS NOT NULL
Order by 2,3

--total pop vs--

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
Sum(Convert(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.Location, dea.date) as rollingpeople
from Covid..CovidDeaths dea JOIN covid..CovidVaccinations vac
On dea.location = vac.location
and dea.date = vac.date
where dea.continent IS NOT NULL
Order by 2,3

---tabluea--

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From covid..CovidDeaths
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2

---

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From covid..CovidDeaths
--Where location like '%states%'
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc

--

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From covid..CovidDeaths
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc

--

Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From covid..CovidDeaths
--Where location like '%states%'
Group by Location, Population, date
order by PercentPopulationInfected desc
