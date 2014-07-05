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

#
# sshkeys_convert_to_hash (array, user, host)
#
module Puppet::Parser::Functions
  newfunction(:sshkeys_convert_to_hash, :type => :rvalue, :doc => <<-EOS
Converts the input array to the according sshkeys hash
  EOS
  ) do |args|

    raise(Puppet::ParseError, "sshkeys_convert_to_hash(): wrong number of arguments " +
      "given (#{args.size} for 1)") if args.size != 3

    arr = args[0]
    user = args[1]
    host = args[2]

    raise(Puppet::ParseError, "sshkeys_convert_to_hash(): first argument should be an array") if !arr.is_a?(Array)

    keys_hash = Hash[]

    arr.each { |x|
      keys_hash["#{x}_at_#{user}@#{host}"] = Hash[
        "key_name" => x,
	"user"     => user,
        ]
    }

    return keys_hash

  end
end
