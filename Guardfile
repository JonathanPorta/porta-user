# More info at https://github.com/guard/guard#readme

# Blocked until guard-foodcritic maintainer cuts a new release.
# https://github.com/cgriego/guard-foodcritic/pull/8
# guard 'foodcritic', cmd: 'chef exec foodcritic -f any .' do
#   watch(/attributes\/.+\.rb$/)
#   watch(/providers\/.+\.rb$/)
#   watch(/recipes\/.+\.rb$/)
#   watch(/resources\/.+\.rb$/)
#   watch(/libraries\/.+\.rb$/)
#   watch('metadata.rb')
# end

guard 'rubocop', cmd: 'chef exec rubocop' do
  watch(/attributes\/.+\.rb$/)
  watch(/providers\/.+\.rb$/)
  watch(/recipes\/.+\.rb$/)
  watch(/resources\/.+\.rb$/)
  watch(/libraries\/.+\.rb$/)
  watch(/test\/.+\.rb$/)
  watch('metadata.rb')
end

guard :rspec, cmd: 'chef exec rspec', all_on_start: true, notification: true, spec_paths: ['test/unit/']do
  watch(/^libraries\/(.+)\.rb$/)
  watch(/^test\/unit\/spec\/(.+)_spec\.rb$/)
  watch(/^(recipes)\/(.+)\.rb$/)             { |m| "spec/#{m[1]}_spec.rb" }
  watch('test/unit/spec/spec_helper.rb')     { 'test/unit/spec' }
  watch('metadata.rb')                       { 'test/unit/spec' }
  watch('Berksfile')                         { 'test/unit/spec' }
end
