#
# sshkeys puppet module
# https://github.com/artem-sidorenko/puppet-sshkeys
#
# Copyright (C) 2016 Frank Wall github@moov.de
# Copyright (C) 2014-2016 Artem Sidorenko artem@2realities.com
#
# See the COPYRIGHT file at the top-level directory of this distribution.
#
class sshkeys (
  $users = undef,
){
  # hiera lookup
  $hiera_users = hiera_hash('sshkeys::users',undef)

  if $hiera_users == undef {
    $fin_users = $users
  } else {
    $fin_users = $hiera_users
  }

  if ($fin_users) {
    create_resources('sshkeys::user',$fin_users)
  }
}
