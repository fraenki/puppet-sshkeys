#
# sshkeys puppet module
# https://github.com/artem-sidorenko/puppet-sshkeys
#
# Author Artem Sidorenko artem@2realities.com
#
# Copyright 2014 Artem Sidorenko and contributors.
# See the COPYRIGHT file at the top-level directory of this distribution
# and at https://github.com/artem-sidorenko/puppet-sshkeys/blob/master/COPYRIGHT
#
define sshkeys::key (
    $key_name = undef,
    $key      = undef,
    $type     = undef,
    $user     = undef,
  ) {

  if ( !$user or !$key_name ) {
    fail( 'user and key_name should be defined')
  }

  if ( !$key and !$type ) {
    #hiera lookup in the key list if both key and type are not defined
    $keys_hash = hiera('sshkeys::keys',undef)
    if ( !$keys_hash or !$keys_hash[$key_name] or !$keys_hash[$key_name]['key'] or !$keys_hash[$key_name]['type'] ) {
      fail ( "cannot find the key ${key_name} for ${user}@${::fqdn} via hiera in the sshkeys::keys namespace" )
    }
    $fin_key = $keys_hash[$key_name]['key']
    $fin_type = $keys_hash[$key_name]['type']
  } elsif ( $key and $type ) {
    $fin_key = $key
    $fin_type = $type
  } else {
    fail ( 'either key and type both should be defined or both should be absent')
  }

  ssh_authorized_key { "${key_name}_at_${user}@${::fqdn}":
    ensure => present,
    user   => $user,
    key    => $fin_key,
    type   => $fin_type,
  }
}
