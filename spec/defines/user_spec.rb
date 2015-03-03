require 'spec_helper'

describe 'sshkeys::user' do
  let(:title) { 'sometestuser' }
  let(:node) { 'some.fqdn' }

  context 'home undefined' do
    it do
      raise_error(Puppet::Error, /home should be defined to allow ssh key management/)
    end
  end

  context 'keys defined as array, hiera lookup sucessfully' do
    let(:params) {{
      :keys => ['first-test-key','second-test-key'],
      :home => '/home/sometestuser',
    }}
    it do
      should contain_user('sometestuser').with({
        'ensure'         => 'present',
        'home'           => '/home/sometestuser',
        'purge_ssh_keys' => true,
      })
      should contain_sshkeys__key('first-test-key_at_sometestuser@some.fqdn').with({
        'key_name' => 'first-test-key',
        'user'     => 'sometestuser',
      })
      should contain_sshkeys__key('second-test-key_at_sometestuser@some.fqdn').with({
        'key_name' => 'second-test-key',
        'user'     => 'sometestuser',
      })
    end
  end

  context 'keys defined as hash with key data, no hiera lookup' do
    let(:params) {{
      :home => '/home/sometestuser',
      :keys => {
        'first-test-key' => {
          'key'  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzdGydf2tdZYCkBRGx/SnlVKW+9q3Mqtf9vCrs0SaSkwDK4Q36hS40IVgmri2mjKeWFr5p92OgYY1hjZk4LLUAbVV8ItmPLqvmfrkOEwDCzmkbrUVa4BTKePWG0hOGAVYSQkS+1vhsTFhtznJMxsjRVwj8tO3s0fSnaXcovs9d4LwXhRbcDjzrAVRkk2d5/lSbjc/T4ZJ6oMKcGCxq02etJMoSBBQsEfRP/vULqKjoxJ96kb3Y43tU7gRzcVkXAyNqpXie8fD/FopoVi/uHIqkzotkOwztUYNt6C5LwV/W4ds5x3Zl7Jo4kqup2FOCs4oXSC3WxJI5FJ9WuPMtK1r',
          'type' => 'ssh-rsa',
        },
        'second-test-key' => {
          'key'  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCqlo0PPGZ2XW1qBFuFgYmsGlT24I+v51tb7cRSAJeBouDPvfqBMBOX84ye4DsW3uRmFNXt/wdAr/QnEAlua5bSagVRC2t9X4lkcrFJSSfEA2J29Lh16pPzOK/HReo8R89wbEKfqrqZG/FNrjMB6YaAxBRJE0O9T6BDsMBCg6b8wb6DRPIKzuEkKkI9ywExVrVFOEANTsdS0oQq8exIlWHmnKwOf1R2Jl1FRgIHnJAfG29EoeY7Q+DlPZOBXqB+xamYj56h6FMb0ZLBOAirXm76bHbqJhzY5RbcW8HrxzvLBY1xfOlP4NMKWIxBNG1j2Je0WPU9gVDnq7/LoS0OuCtR',
          'type' => 'ssh-rsa',
        },
      },
    }}

    it do
      should contain_user('sometestuser').with({
        'ensure'         => 'present',
        'home'           => '/home/sometestuser',
        'purge_ssh_keys' => true,
      })
      should contain_sshkeys__key('first-test-key_at_sometestuser@some.fqdn').with({
        'key_name' => 'first-test-key',
        'user'     => 'sometestuser',
        'type'     => 'ssh-rsa',
        'key'      => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzdGydf2tdZYCkBRGx/SnlVKW+9q3Mqtf9vCrs0SaSkwDK4Q36hS40IVgmri2mjKeWFr5p92OgYY1hjZk4LLUAbVV8ItmPLqvmfrkOEwDCzmkbrUVa4BTKePWG0hOGAVYSQkS+1vhsTFhtznJMxsjRVwj8tO3s0fSnaXcovs9d4LwXhRbcDjzrAVRkk2d5/lSbjc/T4ZJ6oMKcGCxq02etJMoSBBQsEfRP/vULqKjoxJ96kb3Y43tU7gRzcVkXAyNqpXie8fD/FopoVi/uHIqkzotkOwztUYNt6C5LwV/W4ds5x3Zl7Jo4kqup2FOCs4oXSC3WxJI5FJ9WuPMtK1r',
      })
      should contain_sshkeys__key('second-test-key_at_sometestuser@some.fqdn').with({
        'key_name' => 'second-test-key',
        'user'     => 'sometestuser',
        'type'     => 'ssh-rsa',
        'key'      => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCqlo0PPGZ2XW1qBFuFgYmsGlT24I+v51tb7cRSAJeBouDPvfqBMBOX84ye4DsW3uRmFNXt/wdAr/QnEAlua5bSagVRC2t9X4lkcrFJSSfEA2J29Lh16pPzOK/HReo8R89wbEKfqrqZG/FNrjMB6YaAxBRJE0O9T6BDsMBCg6b8wb6DRPIKzuEkKkI9ywExVrVFOEANTsdS0oQq8exIlWHmnKwOf1R2Jl1FRgIHnJAfG29EoeY7Q+DlPZOBXqB+xamYj56h6FMb0ZLBOAirXm76bHbqJhzY5RbcW8HrxzvLBY1xfOlP4NMKWIxBNG1j2Je0WPU9gVDnq7/LoS0OuCtR',
      })
    end
  end

  context 'keys not defined as array or hash' do
    let(:params) {{
      :home => '/home/sometestuser',
      :keys => 'some wrong value',
    }}

    it do
      raise_error(Puppet::Error, /keys should be defined as array or hash/)
    end
  end

  context 'no keys defined' do
    let(:params) {{
      :home => '/home/sometestuser',
    }}

    it do
      should contain_user('sometestuser').with({
        'ensure'         => 'present',
        'home'           => '/home/sometestuser',
        'purge_ssh_keys' => true,
      })
      should have_ssh_authorized_keys_resource_count(0)
    end
  end

  context 'absent user' do
    let(:params) {{
      :ensure => 'absent',
    }}

    it do
      should contain_user('sometestuser').with({
        'ensure'         => 'absent',
      })
      should have_ssh_authorized_keys_resource_count(0)
    end
  end


end
