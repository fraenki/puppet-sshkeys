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
define sshkeys::user (
    $ensure           = present,
    $keys             = [],
    $home             = undef,
    $comment          = undef,
    $groups           = undef,
    $password_min_age = undef,
    $password_max_age = undef,
    $password         = undef,
    $expiry           = undef,
    $managehome       = undef,
    $shell            = undef,
    $system           = undef,
    $uid              = undef,
    $gid              = undef,
  ) {

  $user = $title

  if ( ! defined(User[$user]) ) {
    if ( !$home ) {
      fail( 'home should be defined to allow ssh key management' )
    }
    user { $user:
      ensure           => $ensure,
      purge_ssh_keys   => true,
      home             => $home,
      comment          => $comment,
      groups           => $groups,
      password_min_age => $password_min_age,
      password_max_age => $password_max_age,
      password         => $password,
      expiry           => $expiry,
      managehome       => $managehome,
      shell            => $shell,
      system           => $system,
      uid              => $uid,
      gid              => $gid,
    }
  } elsif ( !getparam(User[$user],'purge_ssh_keys') ) {
    notify{"No keys will be purged for user ${user} as purge_ssh_keys is disabled":}
  }

  #do it only if the user is present
  if ( $ensure == 'present' ) {
    if ( is_array($keys) ) {
      $fin_keys = sshkeys_convert_to_hash($keys,$user,$::fqdn)
    } elsif ( is_hash($keys) ) {
      $fin_keys = sshkeys_restruct_to_hash($keys,$user,$::fqdn)
    } else {
      fail ( 'keys should be defined as array or hash')
    }

    create_resources('sshkeys::key',$fin_keys)
  }

}
