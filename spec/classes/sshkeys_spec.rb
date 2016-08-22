# rubocop:disable Metrics/LineLength
require 'spec_helper'

describe 'sshkeys' do
  let(:node) { 'some.fqdn' }

  context 'e2e test with hiera data' do
    it do
      should compile.with_all_deps

      should contain_user('sometestuser')
        .with(
          ensure: 'present',
          home: '/home/sometestuser',
          purge_ssh_keys: true
        )
      should contain_ssh_authorized_key('first_test_key_at_sometestuser@some.fqdn')
        .with(
          ensure: 'present',
          user: 'sometestuser',
          key: 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzdGydf2tdZYCkBRGx/SnlVKW+9q3Mqtf9vCrs0SaSkwDK4Q36hS40IVgmri2mjKeWFr5p92OgYY1hjZk4LLUAbVV8ItmPLqvmfrkOEwDCzmkbrUVa4BTKePWG0hOGAVYSQkS+1vhsTFhtznJMxsjRVwj8tO3s0fSnaXcovs9d4LwXhRbcDjzrAVRkk2d5/lSbjc/T4ZJ6oMKcGCxq02etJMoSBBQsEfRP/vULqKjoxJ96kb3Y43tU7gRzcVkXAyNqpXie8fD/FopoVi/uHIqkzotkOwztUYNt6C5LwV/W4ds5x3Zl7Jo4kqup2FOCs4oXSC3WxJI5FJ9WuPMtK1r',
          type: 'ssh-rsa'
        )
      should contain_ssh_authorized_key('second_test_key_at_sometestuser@some.fqdn')
        .with(
          ensure: 'present',
          user: 'sometestuser',
          key: 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCqlo0PPGZ2XW1qBFuFgYmsGlT24I+v51tb7cRSAJeBouDPvfqBMBOX84ye4DsW3uRmFNXt/wdAr/QnEAlua5bSagVRC2t9X4lkcrFJSSfEA2J29Lh16pPzOK/HReo8R89wbEKfqrqZG/FNrjMB6YaAxBRJE0O9T6BDsMBCg6b8wb6DRPIKzuEkKkI9ywExVrVFOEANTsdS0oQq8exIlWHmnKwOf1R2Jl1FRgIHnJAfG29EoeY7Q+DlPZOBXqB+xamYj56h6FMb0ZLBOAirXm76bHbqJhzY5RbcW8HrxzvLBY1xfOlP4NMKWIxBNG1j2Je0WPU9gVDnq7/LoS0OuCtR',
          type: 'ssh-rsa'
        )

      should contain_user('sometestuser2')
        .with(
          ensure: 'present',
          home: '/home/sometestuser2',
          purge_ssh_keys: true
        )
      should contain_ssh_authorized_key('second_test_key_at_sometestuser2@some.fqdn')
        .with(
          ensure: 'present',
          user: 'sometestuser2',
          key: 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCqlo0PPGZ2XW1qBFuFgYmsGlT24I+v51tb7cRSAJeBouDPvfqBMBOX84ye4DsW3uRmFNXt/wdAr/QnEAlua5bSagVRC2t9X4lkcrFJSSfEA2J29Lh16pPzOK/HReo8R89wbEKfqrqZG/FNrjMB6YaAxBRJE0O9T6BDsMBCg6b8wb6DRPIKzuEkKkI9ywExVrVFOEANTsdS0oQq8exIlWHmnKwOf1R2Jl1FRgIHnJAfG29EoeY7Q+DlPZOBXqB+xamYj56h6FMb0ZLBOAirXm76bHbqJhzY5RbcW8HrxzvLBY1xfOlP4NMKWIxBNG1j2Je0WPU9gVDnq7/LoS0OuCtR',
          type: 'ssh-rsa'
        )
    end
  end

  context 'e2e test with direct parameters, without hiera data' do
    let(:node) { 'some.fqdn.without-hiera-data' }

    let(:params) do
      { users: {
        'sometestuser' => {
          'home' => '/home/sometestuser',
          'keys' => {
            'first_test_key' => {
              'key'  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzdGydf2tdZYCkBRGx/SnlVKW+9q3Mqtf9vCrs0SaSkwDK4Q36hS40IVgmri2mjKeWFr5p92OgYY1hjZk4LLUAbVV8ItmPLqvmfrkOEwDCzmkbrUVa4BTKePWG0hOGAVYSQkS+1vhsTFhtznJMxsjRVwj8tO3s0fSnaXcovs9d4LwXhRbcDjzrAVRkk2d5/lSbjc/T4ZJ6oMKcGCxq02etJMoSBBQsEfRP/vULqKjoxJ96kb3Y43tU7gRzcVkXAyNqpXie8fD/FopoVi/uHIqkzotkOwztUYNt6C5LwV/W4ds5x3Zl7Jo4kqup2FOCs4oXSC3WxJI5FJ9WuPMtK1r',
              'type' => 'ssh-rsa'
            }
          }
        },
        'sometestuser2' => {
          'home' => '/home/sometestuser2',
          'keys' => {
            'first_test_key' => {
              'key'  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzdGydf2tdZYCkBRGx/SnlVKW+9q3Mqtf9vCrs0SaSkwDK4Q36hS40IVgmri2mjKeWFr5p92OgYY1hjZk4LLUAbVV8ItmPLqvmfrkOEwDCzmkbrUVa4BTKePWG0hOGAVYSQkS+1vhsTFhtznJMxsjRVwj8tO3s0fSnaXcovs9d4LwXhRbcDjzrAVRkk2d5/lSbjc/T4ZJ6oMKcGCxq02etJMoSBBQsEfRP/vULqKjoxJ96kb3Y43tU7gRzcVkXAyNqpXie8fD/FopoVi/uHIqkzotkOwztUYNt6C5LwV/W4ds5x3Zl7Jo4kqup2FOCs4oXSC3WxJI5FJ9WuPMtK1r',
              'type' => 'ssh-rsa'
            },
            'second_test_key' => {
              'key'  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCqlo0PPGZ2XW1qBFuFgYmsGlT24I+v51tb7cRSAJeBouDPvfqBMBOX84ye4DsW3uRmFNXt/wdAr/QnEAlua5bSagVRC2t9X4lkcrFJSSfEA2J29Lh16pPzOK/HReo8R89wbEKfqrqZG/FNrjMB6YaAxBRJE0O9T6BDsMBCg6b8wb6DRPIKzuEkKkI9ywExVrVFOEANTsdS0oQq8exIlWHmnKwOf1R2Jl1FRgIHnJAfG29EoeY7Q+DlPZOBXqB+xamYj56h6FMb0ZLBOAirXm76bHbqJhzY5RbcW8HrxzvLBY1xfOlP4NMKWIxBNG1j2Je0WPU9gVDnq7/LoS0OuCtR',
              'type' => 'ssh-rsa'
            }
          }
        }
      } }
    end

    it do
      should compile.with_all_deps

      should contain_user('sometestuser')
        .with(
          ensure: 'present',
          home: '/home/sometestuser',
          purge_ssh_keys: true
        )
      should contain_ssh_authorized_key('first_test_key_at_sometestuser@some.fqdn.without-hiera-data')
        .with(
          ensure: 'present',
          user: 'sometestuser',
          key: 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzdGydf2tdZYCkBRGx/SnlVKW+9q3Mqtf9vCrs0SaSkwDK4Q36hS40IVgmri2mjKeWFr5p92OgYY1hjZk4LLUAbVV8ItmPLqvmfrkOEwDCzmkbrUVa4BTKePWG0hOGAVYSQkS+1vhsTFhtznJMxsjRVwj8tO3s0fSnaXcovs9d4LwXhRbcDjzrAVRkk2d5/lSbjc/T4ZJ6oMKcGCxq02etJMoSBBQsEfRP/vULqKjoxJ96kb3Y43tU7gRzcVkXAyNqpXie8fD/FopoVi/uHIqkzotkOwztUYNt6C5LwV/W4ds5x3Zl7Jo4kqup2FOCs4oXSC3WxJI5FJ9WuPMtK1r',
          type: 'ssh-rsa'
        )

      should contain_user('sometestuser2')
        .with(
          ensure: 'present',
          home: '/home/sometestuser2',
          purge_ssh_keys: true
        )
      should contain_ssh_authorized_key('first_test_key_at_sometestuser2@some.fqdn.without-hiera-data')
        .with(
          ensure: 'present',
          user: 'sometestuser2',
          key: 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzdGydf2tdZYCkBRGx/SnlVKW+9q3Mqtf9vCrs0SaSkwDK4Q36hS40IVgmri2mjKeWFr5p92OgYY1hjZk4LLUAbVV8ItmPLqvmfrkOEwDCzmkbrUVa4BTKePWG0hOGAVYSQkS+1vhsTFhtznJMxsjRVwj8tO3s0fSnaXcovs9d4LwXhRbcDjzrAVRkk2d5/lSbjc/T4ZJ6oMKcGCxq02etJMoSBBQsEfRP/vULqKjoxJ96kb3Y43tU7gRzcVkXAyNqpXie8fD/FopoVi/uHIqkzotkOwztUYNt6C5LwV/W4ds5x3Zl7Jo4kqup2FOCs4oXSC3WxJI5FJ9WuPMtK1r',
          type: 'ssh-rsa'
        )
      should contain_ssh_authorized_key('second_test_key_at_sometestuser2@some.fqdn.without-hiera-data')
        .with(
          ensure: 'present',
          user: 'sometestuser2',
          key: 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCqlo0PPGZ2XW1qBFuFgYmsGlT24I+v51tb7cRSAJeBouDPvfqBMBOX84ye4DsW3uRmFNXt/wdAr/QnEAlua5bSagVRC2t9X4lkcrFJSSfEA2J29Lh16pPzOK/HReo8R89wbEKfqrqZG/FNrjMB6YaAxBRJE0O9T6BDsMBCg6b8wb6DRPIKzuEkKkI9ywExVrVFOEANTsdS0oQq8exIlWHmnKwOf1R2Jl1FRgIHnJAfG29EoeY7Q+DlPZOBXqB+xamYj56h6FMb0ZLBOAirXm76bHbqJhzY5RbcW8HrxzvLBY1xfOlP4NMKWIxBNG1j2Je0WPU9gVDnq7/LoS0OuCtR',
          type: 'ssh-rsa'
        )
    end
  end
end
