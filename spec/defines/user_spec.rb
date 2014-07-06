require 'spec_helper'

describe 'sshkeys::user' do
  let(:title) { 'sometestuser' }
  let(:node) { 'some.fqdn' }

  context 'home undefined' do
    it do
      expect {
        should compile
      }.to raise_error(Puppet::Error, /home should be defined to allow ssh key management/)
    end
  end

  context 'user predefined without purge_ssh_keys' do
  #TBD
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

  context 'keys defined as hash without key data, hiera lookup sucessfully' do
  #TBD
  end

  context 'keys defined as hash with key data' do
  #TBD
  end

  context 'keys not defined as array or hash' do
  #TBD
  end

end
