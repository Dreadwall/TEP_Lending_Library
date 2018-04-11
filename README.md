# README

### Populate the sqlite3 database with csv files

### csv files path
```
/app/csvs/<table name>.csv
```

i.e. users, schools

### commands to run rails/rake tasks
```
bundle install
```

dev_setup drops existing database, which requires authorization. *only use for local development*

```
rails lendinglibrary:dev_setup
```

setup assumes database already initialized beforehand, only import fake data
```
rails lendinglibrary:setup
```

to check if the tables are correctly populated

```
rails c
> School.limit(5).order('id desc')
```
