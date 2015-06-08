porta_user 'portaj' do
  action :create
  sudo true
  github_username 'jonathanporta'
  ssh_keys %w(dummykey1 dummykey2 dummykey3)
end
