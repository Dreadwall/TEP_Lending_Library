namespace :lendinglibrary do
  desc "setup database and import fake csvs for development"
  task :dev_setup do
    Rake::Task["db:exists"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:setup"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["import_incidents_csv:create_incidents"].invoke

    # drop test database
    system("RAILS_ENV=test rake db:drop")
    # create test database
    system("RAILS_ENV=test rake db:create")
    end

  desc "import fake csv"
  task :setup do
    Rake::Task["import_incidents_csv:create_incidents"].invoke
    end

end
