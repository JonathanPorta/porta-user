# From https://github.com/balanced-cookbooks/balanced-user/blob/master/libraries/balanced_user.rb
class Chef
  class Resource
    class PortaUser < Resource
      attr_accessor :exists

      def initialize(name, run_context = nil)
        super(name, run_context)

        @resource_name = :porta_user
        @provider = Chef::Provider::PortaUser

        @action = :create
        @allowed_actions = [:create, :remove]
        @exists = false

        # Default values
        @username = name # Use the name of the resource as the username
        @github_username = false
        @sudo = false
        @ssh_keys = []
      end

      def username(arg = nil)
        set_or_return :username, arg, kind_of: [String]
      end

      def github_username(arg = nil)
        set_or_return :github_username, arg, kind_of: [String, FalseClass]
      end

      def sudo(arg = nil)
        set_or_return :sudo, arg, equal_to: [true, false]
      end

      def ssh_keys(arg = nil)
        set_or_return :github_username, arg, kind_of: [Array, String]
      end

      # Massage all SSH keys
      def _ssh_keys
        keys = Array(ssh_keys)
        if @github_username
          @github_keys = begin
            Chef::HTTP.new('https://github.com').get("#{github_username}.keys")
          # Use a really big hammer, github being down shouldn't break things.
          # The downside is that if github is down, it will yank your key, possibly
          # leaving login unavailable. Not sure what to do about this right now.
          rescue
            Chef::Log.fatal "There was an issue getting keys for user #{ github_username } from https://github.com/#{github_username}.keys."
          end
          keys += @github_keys.split("\n")
        end
        keys
      end
    end
  end
end
