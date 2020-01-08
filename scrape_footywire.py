from bs4 import BeautifulSoup
import requests
import pandas as pd

url = "https://www.footywire.com/afl/footy/ft_match_list?year=2019"
res = res = requests.get(url)
soup = BeautifulSoup(res.text, features='lxml')
tables = soup.select(".data")

dates = []
teams = []
venues = []
crowds = []
results = []
disposals = []
goals = []

counter = 0

for cell in tables:
    if counter == 0:
        dates.append(cell.text)
    elif counter == 1:
        teams.append(cell.text)
    elif counter == 2:
        venues.append(cell.text)
    elif counter == 3:
        crowds.append(cell.text)
    elif counter == 4:
        results.append(cell.text)
    elif counter == 5:
        disposals.append(cell.text)
    elif counter == 6:
        goals.append(cell.text)
    counter += 1
    if counter == 7:
        counter = 0

df = pd.DataFrame(
    list(
        zip(
            dates,
            teams,
            venues,
            crowds,
            results,
            disposals,
            goals,
        )
    ),
    columns=[
        'date',
        'teams',
        'venue',
        'crowd',
        'results',
        'disposals',
        'goals'
    ])

split_teams = df["teams"].str.split("\nv", n = 1, expand = True)
df["home_team"]= split_teams[0]
df["away_team"]= split_teams[1]
split_results = df["results"].str.split("-", n = 1, expand = True)
df["home_team_score"]= split_results[0]
df["away_team_score"]= split_results[1]
df.drop(columns =["teams", "results", "disposals", "goals"], inplace = True)

df['home_team'] = df['home_team'].str.replace('\n', '')
df['away_team'] = df['away_team'].str.replace('\n', '')
print(df)

