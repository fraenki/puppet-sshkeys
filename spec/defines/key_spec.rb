# rubocop:disable Metrics/LineLength
require 'spec_helper'

describe 'sshkeys::key' do
  let(:title) { 'some-uniq-name' }
  let(:node) { 'some.fqdn' }

  context 'all parameters without hiera' do
    let(:params) do
      { key_name: 'first_test_key',
        user: 'sometestuser',
        type: 'ssh-rsa',
        key: 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzdGydf2tdZYCkBRGx/SnlVKW+9q3Mqtf9vCrs0SaSkwDK4Q36hS40IVgmri2mjKeWFr5p92OgYY1hjZk4LLUAbVV8ItmPLqvmfrkOEwDCzmkbrUVa4BTKePWG0hOGAVYSQkS+1vhsTFhtznJMxsjRVwj8tO3s0fSnaXcovs9d4LwXhRbcDjzrAVRkk2d5/lSbjc/T4ZJ6oMKcGCxq02etJMoSBBQsEfRP/vULqKjoxJ96kb3Y43tU7gRzcVkXAyNqpXie8fD/FopoVi/uHIqkzotkOwztUYNt6C5LwV/W4ds5x3Zl7Jo4kqup2FOCs4oXSC3WxJI5FJ9WuPMtK1r' }
    end

    it do
      should contain_ssh_authorized_key('first_test_key_at_sometestuser@some.fqdn')
        .with(
          ensure: 'present',
          user: 'sometestuser',
          key: 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzdGydf2tdZYCkBRGx/SnlVKW+9q3Mqtf9vCrs0SaSkwDK4Q36hS40IVgmri2mjKeWFr5p92OgYY1hjZk4LLUAbVV8ItmPLqvmfrkOEwDCzmkbrUVa4BTKePWG0hOGAVYSQkS+1vhsTFhtznJMxsjRVwj8tO3s0fSnaXcovs9d4LwXhRbcDjzrAVRkk2d5/lSbjc/T4ZJ6oMKcGCxq02etJMoSBBQsEfRP/vULqKjoxJ96kb3Y43tU7gRzcVkXAyNqpXie8fD/FopoVi/uHIqkzotkOwztUYNt6C5LwV/W4ds5x3Zl7Jo4kqup2FOCs4oXSC3WxJI5FJ9WuPMtK1r',
          type: 'ssh-rsa'
        )
    end
  end

  context 'no parameters are defined' do
    it do
      raise_error(Puppet::Error, /user and key_name should be defined/)
    end
  end

  context 'key_name, user defined, hiera lookup sucessfully' do
    let(:params) do
      { key_name: 'first_test_key',
        user: 'sometestuser' }
    end

    it do
      should contain_ssh_authorized_key('first_test_key_at_sometestuser@some.fqdn')
        .with(
          ensure: 'present',
          user: 'sometestuser',
          key: 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzdGydf2tdZYCkBRGx/SnlVKW+9q3Mqtf9vCrs0SaSkwDK4Q36hS40IVgmri2mjKeWFr5p92OgYY1hjZk4LLUAbVV8ItmPLqvmfrkOEwDCzmkbrUVa4BTKePWG0hOGAVYSQkS+1vhsTFhtznJMxsjRVwj8tO3s0fSnaXcovs9d4LwXhRbcDjzrAVRkk2d5/lSbjc/T4ZJ6oMKcGCxq02etJMoSBBQsEfRP/vULqKjoxJ96kb3Y43tU7gRzcVkXAyNqpXie8fD/FopoVi/uHIqkzotkOwztUYNt6C5LwV/W4ds5x3Zl7Jo4kqup2FOCs4oXSC3WxJI5FJ9WuPMtK1r',
          type: 'ssh-rsa'
        )
    end
  end

  context 'key_name, user defined, hiera without sshkeys::keys structure' do
    let(:node) { 'some.fqdn.without-hiera-data' }

    let(:params) do
      { key_name: 'non-existing-key',
        user: 'sometestuser' }
    end

    it do
      raise_error(Puppet::Error, /cannot find the key non-existing-key for sometestuser@some.fqdn.without-hiera-data via hiera in the sshkeys::keys namespace/)
    end
  end

  context 'key_name, user defined, hiera lookup failed' do
    let(:params) do
      { key_name: 'non-existing-key',
        user: 'sometestuser' }
    end

    it do
      raise_error(Puppet::Error, /cannot find the key non-existing-key for sometestuser@some.fqdn via hiera in the sshkeys::keys namespace/)
    end
  end

  context 'key_name, user defined, only key defined' do
    let(:params) do
      { key_name: 'first_test_key',
        user: 'sometestuser',
        key: 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzdGydf2tdZYCkBRGx/SnlVKW+9q3Mqtf9vCrs0SaSkwDK4Q36hS40IVgmri2mjKeWFr5p92OgYY1hjZk4LLUAbVV8ItmPLqvmfrkOEwDCzmkbrUVa4BTKePWG0hOGAVYSQkS+1vhsTFhtznJMxsjRVwj8tO3s0fSnaXcovs9d4LwXhRbcDjzrAVRkk2d5/lSbjc/T4ZJ6oMKcGCxq02etJMoSBBQsEfRP/vULqKjoxJ96kb3Y43tU7gRzcVkXAyNqpXie8fD/FopoVi/uHIqkzotkOwztUYNt6C5LwV/W4ds5x3Zl7Jo4kqup2FOCs4oXSC3WxJI5FJ9WuPMtK1r' }
    end

    it do
      raise_error(Puppet::Error, /either key and type both should be defined or both should be absent/)
    end
  end

  context 'key_name, user defined, only type defined' do
    let(:params) do
      { key_name: 'first_test_key',
        user: 'sometestuser',
        type: 'ssh-rsa' }
    end
    it do
      raise_error(Puppet::Error, /either key and type both should be defined or both should be absent/)
    end
  end
end
