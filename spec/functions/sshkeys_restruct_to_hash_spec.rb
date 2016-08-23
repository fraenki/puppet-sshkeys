# rubocop:disable Metrics/LineLength
require 'spec_helper'

describe 'sshkeys_restruct_to_hash' do
  context 'correct input data' do
    it do
      should run.with_params(
        {
          'first_test_key' => {
            'key'  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzdGydf2tdZYCkBRGx/SnlVKW+9q3Mqtf9vCrs0SaSkwDK4Q36hS40IVgmri2mjKeWFr5p92OgYY1hjZk4LLUAbVV8ItmPLqvmfrkOEwDCzmkbrUVa4BTKePWG0hOGAVYSQkS+1vhsTFhtznJMxsjRVwj8tO3s0fSnaXcovs9d4LwXhRbcDjzrAVRkk2d5/lSbjc/T4ZJ6oMKcGCxq02etJMoSBBQsEfRP/vULqKjoxJ96kb3Y43tU7gRzcVkXAyNqpXie8fD/FopoVi/uHIqkzotkOwztUYNt6C5LwV/W4ds5x3Zl7Jo4kqup2FOCs4oXSC3WxJI5FJ9WuPMtK1r',
            'type' => 'ssh-rsa'
          },
          'second_test_key' => {
            'key'     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCqlo0PPGZ2XW1qBFuFgYmsGlT24I+v51tb7cRSAJeBouDPvfqBMBOX84ye4DsW3uRmFNXt/wdAr/QnEAlua5bSagVRC2t9X4lkcrFJSSfEA2J29Lh16pPzOK/HReo8R89wbEKfqrqZG/FNrjMB6YaAxBRJE0O9T6BDsMBCg6b8wb6DRPIKzuEkKkI9ywExVrVFOEANTsdS0oQq8exIlWHmnKwOf1R2Jl1FRgIHnJAfG29EoeY7Q+DlPZOBXqB+xamYj56h6FMb0ZLBOAirXm76bHbqJhzY5RbcW8HrxzvLBY1xfOlP4NMKWIxBNG1j2Je0WPU9gVDnq7/LoS0OuCtR',
            'options' => ['no-agent-forwarding'],
            'type'    => 'ssh-rsa'
          }
        },
        'sometestuser',
        'some.fqdn'
      ).and_return(
        'first_test_key_at_sometestuser@some.fqdn' => {
          'key_name' => 'first_test_key',
          'user' => 'sometestuser',
          'options' => nil,
          'type' => 'ssh-rsa',
          'key' => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzdGydf2tdZYCkBRGx/SnlVKW+9q3Mqtf9vCrs0SaSkwDK4Q36hS40IVgmri2mjKeWFr5p92OgYY1hjZk4LLUAbVV8ItmPLqvmfrkOEwDCzmkbrUVa4BTKePWG0hOGAVYSQkS+1vhsTFhtznJMxsjRVwj8tO3s0fSnaXcovs9d4LwXhRbcDjzrAVRkk2d5/lSbjc/T4ZJ6oMKcGCxq02etJMoSBBQsEfRP/vULqKjoxJ96kb3Y43tU7gRzcVkXAyNqpXie8fD/FopoVi/uHIqkzotkOwztUYNt6C5LwV/W4ds5x3Zl7Jo4kqup2FOCs4oXSC3WxJI5FJ9WuPMtK1r'
        },
        'second_test_key_at_sometestuser@some.fqdn' => {
          'key_name' => 'second_test_key',
          'user' => 'sometestuser',
          'options' => ['no-agent-forwarding'],
          'type' => 'ssh-rsa',
          'key' => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCqlo0PPGZ2XW1qBFuFgYmsGlT24I+v51tb7cRSAJeBouDPvfqBMBOX84ye4DsW3uRmFNXt/wdAr/QnEAlua5bSagVRC2t9X4lkcrFJSSfEA2J29Lh16pPzOK/HReo8R89wbEKfqrqZG/FNrjMB6YaAxBRJE0O9T6BDsMBCg6b8wb6DRPIKzuEkKkI9ywExVrVFOEANTsdS0oQq8exIlWHmnKwOf1R2Jl1FRgIHnJAfG29EoeY7Q+DlPZOBXqB+xamYj56h6FMb0ZLBOAirXm76bHbqJhzY5RbcW8HrxzvLBY1xfOlP4NMKWIxBNG1j2Je0WPU9gVDnq7/LoS0OuCtR'
        }
      )
    end
  end

  context 'wrong hash structure' do
    it do
      # be carefull with output here in rspec-puppet =<1.0.1 https://github.com/rodjek/rspec-puppet/issues/138
      should run.with_params(
        {
          'first_test_key' => {
            'key' => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzdGydf2tdZYCkBRGx/SnlVKW+9q3Mqtf9vCrs0SaSkwDK4Q36hS40IVgmri2mjKeWFr5p92OgYY1hjZk4LLUAbVV8ItmPLqvmfrkOEwDCzmkbrUVa4BTKePWG0hOGAVYSQkS+1vhsTFhtznJMxsjRVwj8tO3s0fSnaXcovs9d4LwXhRbcDjzrAVRkk2d5/lSbjc/T4ZJ6oMKcGCxq02etJMoSBBQsEfRP/vULqKjoxJ96kb3Y43tU7gRzcVkXAyNqpXie8fD/FopoVi/uHIqkzotkOwztUYNt6C5LwV/W4ds5x3Zl7Jo4kqup2FOCs4oXSC3WxJI5FJ9WuPMtK1r',
            'type' => 'ssh-rsa'
          },
          'second_test_key' => {
            'type' => 'ssh-rsa'
          }
        },
        'sometestuser',
        'some.fqdn'
      ).and_raise_error(/wrong structure of input hash/)

      # be carefull with output here in rspec-puppet =<1.0.1 https://github.com/rodjek/rspec-puppet/issues/138
      should run.with_params(
        {
          'first_test_key' => {
            'key' => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzdGydf2tdZYCkBRGx/SnlVKW+9q3Mqtf9vCrs0SaSkwDK4Q36hS40IVgmri2mjKeWFr5p92OgYY1hjZk4LLUAbVV8ItmPLqvmfrkOEwDCzmkbrUVa4BTKePWG0hOGAVYSQkS+1vhsTFhtznJMxsjRVwj8tO3s0fSnaXcovs9d4LwXhRbcDjzrAVRkk2d5/lSbjc/T4ZJ6oMKcGCxq02etJMoSBBQsEfRP/vULqKjoxJ96kb3Y43tU7gRzcVkXAyNqpXie8fD/FopoVi/uHIqkzotkOwztUYNt6C5LwV/W4ds5x3Zl7Jo4kqup2FOCs4oXSC3WxJI5FJ9WuPMtK1r',
            'type' => 'ssh-rsa'
          },
          'second_test_key' => {
            'key' => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCqlo0PPGZ2XW1qBFuFgYmsGlT24I+v51tb7cRSAJeBouDPvfqBMBOX84ye4DsW3uRmFNXt/wdAr/QnEAlua5bSagVRC2t9X4lkcrFJSSfEA2J29Lh16pPzOK/HReo8R89wbEKfqrqZG/FNrjMB6YaAxBRJE0O9T6BDsMBCg6b8wb6DRPIKzuEkKkI9ywExVrVFOEANTsdS0oQq8exIlWHmnKwOf1R2Jl1FRgIHnJAfG29EoeY7Q+DlPZOBXqB+xamYj56h6FMb0ZLBOAirXm76bHbqJhzY5RbcW8HrxzvLBY1xfOlP4NMKWIxBNG1j2Je0WPU9gVDnq7/LoS0OuCtR'
          }
        },
        'sometestuser',
        'some.fqdn'
      ).and_raise_error(/wrong structure of input hash/)

      # be carefull with output here in rspec-puppet =<1.0.1 https://github.com/rodjek/rspec-puppet/issues/138
      should run.with_params(
        {
          'first_test_key' => {
            'key' => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzdGydf2tdZYCkBRGx/SnlVKW+9q3Mqtf9vCrs0SaSkwDK4Q36hS40IVgmri2mjKeWFr5p92OgYY1hjZk4LLUAbVV8ItmPLqvmfrkOEwDCzmkbrUVa4BTKePWG0hOGAVYSQkS+1vhsTFhtznJMxsjRVwj8tO3s0fSnaXcovs9d4LwXhRbcDjzrAVRkk2d5/lSbjc/T4ZJ6oMKcGCxq02etJMoSBBQsEfRP/vULqKjoxJ96kb3Y43tU7gRzcVkXAyNqpXie8fD/FopoVi/uHIqkzotkOwztUYNt6C5LwV/W4ds5x3Zl7Jo4kqup2FOCs4oXSC3WxJI5FJ9WuPMtK1r',
            'type' => 'ssh-rsa'
          },
          'second_test_key' => 'broken value'
        },
        'sometestuser',
        'some.fqdn'
      ).and_raise_error(/wrong structure of input hash/)
    end
  end

  context 'wrong count or args' do
    it do
      # be carefull with output here in rspec-puppet =<1.0.1 https://github.com/rodjek/rspec-puppet/issues/138
      should run.with_params('sometestuser', 'some.fqdn').and_raise_error(/wrong number of arguments given/)
    end
  end

  context 'wrong type instead of hash' do
    it do
      # be carefull with output here in rspec-puppet =<1.0.1 https://github.com/rodjek/rspec-puppet/issues/138
      should run.with_params('test string', 'sometestuser', 'some.fqdn').and_raise_error(/first argument should be a hash/)
    end
  end
end
