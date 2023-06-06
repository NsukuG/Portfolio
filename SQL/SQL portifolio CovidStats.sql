/* Data source: https://ourworldindata.org/covid-deaths */

/* Confirm that tables were importeed correctly */
	Select *
	from CovidStats.dbo.CovidDeaths

	Select *
	from CovidStats.dbo.CovidVaccinations 

/* Total cases per country */
	Select location,date,total_cases, total_deaths, (total_deaths/total_cases)*100 as 'Death rate'
	from CovidDeaths
	order by location,date 

/* Highest infection rate */
	Select location,population, MAX(total_cases) as 'Total cases', MAX((total_cases/population)*100) as 'Infectionrate'
	from CovidDeaths
	where continent is not null
	group by location,population
	order by Infectionrate desc 

/* Highest death rate */
	Select location,population, MAX((total_deaths/population)*100) as 'Death rate'
	from CovidDeaths
	where continent is not null
	group by location,population
	order by [Death rate] desc 

/* Total deaths per country */
	select location, max(cast(total_deaths as int)) as 'Deaths' /*COnvert cause death was not*/
	from CovidDeaths
	where continent is not null
	group by location
	order by Deaths desc 

/* Deaths per continent */
	select location, max(cast(total_deaths as int)) as 'Deaths' /*Convert cause death was not*/
	from CovidDeaths
	where continent is null 
	group by location
	order by Deaths desc 

/* Total deaths for the globe vs dates */
	select date, sum(new_cases) as 'New cases', sum(cast(new_deaths as int)) as 'New deaths', sum(cast(new_deaths as int))/sum(new_cases)*100 as 'Global death rate'
	from CovidDeaths
	where continent is not null 
	group by date
	order by 1,2


/*Total population vaccinated */
	select dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations
	from CovidStats.dbo.CovidDeaths dea
	join CovidStats.dbo.CovidVaccinations vac
	on dea.location = vac.location and dea.date = vac.date
	where  dea.continent is not null
	order by dea.location, dea.date

/* CTE to Create cummulative vaccinated people which will then be used to calculate the rate vaccinated by country*/
   With PopulationVaccines (continent, location,Population,Date,New_Vaccinations, CummulativeNumberVaxxed )
   as
	(
	/*World vaccnnations by country and date as of 2021 */
	select dea.continent,dea.location, dea.population, dea.date, vac.new_vaccinations,
	sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,vac.date) as 'CummulativeNumberVaxxed'
	from CovidStats.dbo.CovidDeaths dea
	join CovidStats.dbo.CovidVaccinations vac
	on dea.location = vac.location and dea.date = vac.date
	where dea.continent is not null
	 )

/* Cummulative vaccination rate using the CTE above  */
    select  continent, location, Date,Population,New_Vaccinations, CummulativeNumberVaxxed, Round(((CummulativeNumberVaxxed/Population)*100),2)
    from PopulationVaccines

/* Using a temp table instaed of CTE*/
    Drop table if exists #PeopleVaccinated
    Create table #PeopleVaccinated
    (
    Continent nvarchar(255),Location  nvarchar(255), Date datetime,Population numeric, New_vaccinations numeric,CummulativeNumberVaxxed numeric
    )

/* Inserting the data into the temp table */
   insert into #PeopleVaccinated
   select dea.continent,dea.location,dea.date, dea.population, vac.new_vaccinations,
   sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,vac.date) as 'CummulativeNumberVaxxed'
   from CovidStats.dbo.CovidDeaths dea
   join CovidStats.dbo.CovidVaccinations vac
   on dea.location = vac.location and dea.date = vac.date
   where dea.continent is not null

   select  continent, location, Date,Population,New_Vaccinations, CummulativeNumberVaxxed,  Round(((CummulativeNumberVaxxed/Population)*100),2) as 'PercentVaxxed'
   from #PeopleVaccinated

/* Creating a view to store data for later usage */
   Create View WorldVaxxed as 
   select dea.continent,dea.location,dea.date, dea.population, vac.new_vaccinations,
   sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,vac.date) as 'CummulativeNumberVaxxed'
   from CovidStats.dbo.CovidDeaths dea
   join CovidStats.dbo.CovidVaccinations vac
   on dea.location = vac.location and dea.date = vac.date
   where dea.continent is not null



/* End of project  */