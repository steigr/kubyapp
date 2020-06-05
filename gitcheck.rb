(Dir.glob('lib/*') - ['lib/assets', 'lib/tasks']).each { |dir| Dir.chdir(dir) { puts "========= #{dir} ========="; system('git status') } }
