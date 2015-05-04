#
# Cookbook Name:: porta_user
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require_relative '../spec_helper'

describe 'porta_user-test::create' do
  context 'When all attributes are default, on an unspecified platform' do
    let :chef_run do
      runner = ChefSpec::ServerRunner.new step_into: ['porta_user']
      runner.converge described_recipe
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'creates a porta_user resource with username portaj' do
      expect(chef_run).to create_porta_user('portaj')
    end
  end
end

describe 'porta_user-test::remove' do
  context 'When all attributes are default, on an unspecified platform' do
    let :chef_run do
      runner = ChefSpec::ServerRunner.new step_into: ['porta_user']
      runner.converge described_recipe
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'creates a porta_user resource with username portaj' do
      expect(chef_run).to remove_porta_user('portaj')
    end
  end
end
