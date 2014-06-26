#
# sshkeys puppet module
# https://github.com/artem-sidorenko/puppet-sshkeys
#
# Author Artem Sidorenko artem@2realities.com
#
# Copyright 2014 Artem Sidorenko and contributors
# the COPYRIGHT file at the top-level directory of this distribution
# and at https://github.com/artem-sidorenko/puppet-sshkeys/blob/master/COPYRIGHT
#
define sshkeys::key (
    $key_name = 'UNSET',
    $key = 'UNSET',
    $type = 'UNSET',
    $user = 'UNSET',
  ) {

  if ( $user == 'UNSET' or $key_name == 'UNSET' ) {
    fail( 'user and key_name should be defined')
  }

  if ( $key == 'UNSET' and $type == 'UNSET') {
    #hiera lookup in the key list if both key and type are not defined
    $keys_hash = hiera_hash('sshkeys::keys')
    $fin_key = $keys_hash[$key_name]['key']
    $fin_type = $keys_hash[$key_name]['type']
  } elsif ( $key != 'UNSET' and $type != 'UNSET' ) {
    $fin_key = $key
    $fin_type = $type
  } else {
    fail ( 'either key and type both should be defined or both should be absent')
  }

  #check if key is defined and fail if not
  if ( !$fin_key or !$fin_type) {
    fail ( "cannot find the key ${key_name} for ${user}@${::fqdn}" )
  }

  ssh_authorized_key { "${key_name}_at_${user}@${::fqdn}":
    ensure => present,
    user   => $user,
    key    => $fin_key,
    type   => $fin_type,
  }
}
