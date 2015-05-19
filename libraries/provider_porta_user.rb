class Chef
  class Provider
    class PortaUser < Provider
      def load_current_resource
        current_resource = Chef::Resource::PortaUser.new(@new_resource.name)
        current_resource.exists = false # TODO: Intelligently check this
        current_resource
      end

      def action_create
        converge_by("create user #{new_resource.username}") do
          create_user
          if new_resource.sudo
            grant_sudo
          else
            revoke_sudo
          end
        end
      end

      def action_remove
        converge_by("remove user #{new_resource.username}") do
          revoke_sudo
          remove_user
        end
      end

      private

      def create_user
        Chef::Resource::UserAccount.new new_resource.username, run_context do
          action :create
          home "/home/#{ new_resource.username }"
          manage_home false
          ssh_keygen false
        end
        Chef::Resource::UserAccount.new new_resource.username, run_context do
          action :modify
          home "/home/#{ new_resource.username }"
          manage_home false
          ssh_keys new_resource._ssh_keys
        end
      end

      def grant_sudo
        Chef::Resource::Sudo.new new_resource.username, run_context do
          user new_resource.username
          nopasswd true
        end
      end

      def revoke_sudo
        r = grant_sudo
        r.action :remove
        r
      end

      def remove_user
        r = create_user
        r.action :remove
        r
      end
    end
  end
end
