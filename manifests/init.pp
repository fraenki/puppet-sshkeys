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
class sshkeys (
  $users = undef,
){

  #hiera lookup
  $hiera_users = hiera_hash('sshkeys::users',undef)

  if $hiera_users == undef {
    $fin_users = $users
  }else{
    $fin_users = $hiera_users
  }

  if ($fin_users) {
    create_resources('sshkeys::user',$fin_users)
  }

}
