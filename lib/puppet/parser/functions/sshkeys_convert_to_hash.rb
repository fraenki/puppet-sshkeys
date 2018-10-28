#
# sshkeys puppet module
# https://github.com/fraenki/puppet-sshkeys
#
# Copyright (C) 2016 Frank Wall github@moov.de
# Copyright (C) 2014-2016 Artem Sidorenko artem@2realities.com
#
# See the COPYRIGHT file at the top-level directory of this distribution.
#

#
# sshkeys_convert_to_hash (array, user, host)
#
module Puppet::Parser::Functions # rubocop:disable Style/Documentation
  newfunction(
    :sshkeys_convert_to_hash,
    type: :rvalue,
    doc: 'Converts the input array to the according sshkeys hash'
  ) do |args|
    raise(Puppet::ParseError, 'sshkeys_convert_to_hash(): wrong number of arguments ' \
      "given (#{args.size} for 1)") if args.size != 3

    arr = args[0]
    user = args[1]
    host = args[2]

    raise(Puppet::ParseError, 'sshkeys_convert_to_hash(): first argument should be an array') \
      unless arr.is_a?(Array)

    keys_hash = Hash[]

    arr.each do |x|
      keys_hash["#{x}_at_#{user}@#{host}"] = Hash[
        'key_name' => x,
        'user'     => user,
        ]
    end

    return keys_hash
  end
end
