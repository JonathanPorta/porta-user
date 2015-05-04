if defined?(ChefSpec)
  def create_porta_user(username)
    ChefSpec::Matchers::ResourceMatcher.new(:porta_user, :create, username)
  end

  def remove_porta_user(username)
    ChefSpec::Matchers::ResourceMatcher.new(:porta_user, :remove, username)
  end
end
