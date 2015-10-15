# rubocop:disable Metrics/LineLength
require 'spec_helper'

describe 'sshkeys_convert_to_hash' do
  context 'correct input data' do
    it do
      should run.with_params(
        %w(first_test_key second_test_key),
        'sometestuser',
        'some.fqdn'
      ).and_return(
        'first_test_key_at_sometestuser@some.fqdn' => {
          'key_name' => 'first_test_key',
          'user'     => 'sometestuser'
        },
        'second_test_key_at_sometestuser@some.fqdn' => {
          'key_name' => 'second_test_key',
          'user'     => 'sometestuser'
        }
      )
    end
  end

  context 'wrong count or args' do
    it do
      # be carefull with output here in rspec-puppet =<1.0.1 https://github.com/rodjek/rspec-puppet/issues/138
      should run.with_params('sometestuser', 'some.fqdn').and_raise_error(/wrong number of arguments given/)
    end
  end

  context 'wrong type instead of array' do
    it do
      # be carefull with output here in rspec-puppet =<1.0.1 https://github.com/rodjek/rspec-puppet/issues/138
      should run.with_params('test string', 'sometestuser', 'some.fqdn').and_raise_error(/first argument should be an array/)
    end
  end
end
