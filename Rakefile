task :default => :spec
begin
  require 'spec/rake/spectask'
  Spec::Rake::SpecTask.new {|t| t.spec_opts = ['--color']}
rescue LoadError
  puts "Neeed rspec to run tests (#{$!})"
end