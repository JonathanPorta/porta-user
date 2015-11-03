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
        home_directory = "/home/#{ new_resource.username }"

        u = Chef::Resource::User.new new_resource.username, run_context do
          action :nothing
          home home_directory
          manage_home true
          ssh_keygen false
          shell '/bin/bash'
        end

        Chef::Log.debug 'CREATE'
        Chef::Log.debug u

        u.run_action(:create)

        authorized_keys_resource home_directory
        u
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

      def home_ssh_dir_resource(home_directory)
        ssh_directory = "#{ home_directory }/.ssh"

        r = Chef::Resource::Directory.new ssh_directory, run_context do
          path ssh_directory
          owner new_resource.username
          group Etc.getpwnam(new_resource.username).gid
          mode '0700'
          recursive true
          action :nothing
        end
        r.run_action(:create)
        new_resource.updated_by_last_action(true) if r.updated_by_last_action?
      end

      def authorized_keys_resource(home_directory)
        ssh_keys = Array(new_resource._ssh_keys)
        return if ssh_keys.empty?

        home_ssh_dir_resource(home_directory)
        authorized_keys_path = "#{ home_directory }/.ssh/authorized_keys"

        # Append the keys if the file exists, and the key isn't in the file.
        # Otherwise, create and write over the file.
        if ::File.exist? authorized_keys_path
          fe = Chef::Util::FileEdit.new(authorized_keys_path)
          ssh_keys.each do |key|
            fe.insert_line_if_no_match(/#{key}/, key)
          end
          fe.write_file
        else
          ::File.open(authorized_keys_path, 'w') do |fp|
            ssh_keys.each do |key|
              fp.puts key
            end
          end
        end

        # Make sure the authorized keys file has the correct permissions.
        f = Chef::Resource::File.new authorized_keys_path, run_context do
          mode '0600'
          action :nothing
        end
        f.run_action(:touch)

        # We assume we always got handsy
        new_resource.updated_by_last_action(true)
      end
    end
  end
end
