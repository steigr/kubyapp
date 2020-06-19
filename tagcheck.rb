(Dir.glob('lib/*') - ['lib/assets', 'lib/tasks']).each do |dir|
  Dir.chdir(dir) do
    puts "========= #{dir} ========="
    tags = `git tag --list`.strip.split("\n")
    version_file = Dir.glob('lib/**/version.rb').first
    version_contents = File.read(version_file)
    version = version_contents.match(/VERSION = '(\d+\.\d+\.\d+)'/).captures.first
    
    if tags.include?("v#{version}")
      puts "Current version exists as a tag"
    else
      puts "Current version #{version} has not been tagged. Tags are: #{tags.join(', ')}"
    end
  end
end

