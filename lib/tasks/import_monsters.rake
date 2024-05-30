namespace :import do
  desc 'Import monsters'
  task monsters: :environment do
    ImportMonsterService.import
  end
end