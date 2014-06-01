file = File.read '.gitmodules'

lines = file.split("\n")

plugins = []
plugin = {}
lines.each do |line|
  if line =~ /submodule/
    plugin = {}
    line =~ /bundle\/(.*)"/
    plugin[:name] = $1
  end

  if line =~ /url = (.*)$/
    url = $1
    if url =~ /git@/
      url.gsub!("@", "://")
      url.gsub!("github.com:", "github.com/")
    end
    plugin[:url] = url
    plugins << plugin
  end
end

plugins.each do |plugin|
  puts "plugin '#{plugin[:name]}', '#{plugin[:url]}'"
end
