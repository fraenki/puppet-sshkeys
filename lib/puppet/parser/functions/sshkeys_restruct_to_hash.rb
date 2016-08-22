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
# sshkeys_restruct_to_hash (hash,user,host)
#
module Puppet
  module Parser
    module Functions # rubocop:disable Style/Documentation
      newfunction(
        :sshkeys_restruct_to_hash,
        type: :rvalue,
        doc: 'Converts the input hash to the according sshkeys hash with uniq keys to have uniq defines'
      ) do |args|
        raise(Puppet::ParseError, 'sshkeys_restruct_to_hash(): wrong number of arguments ' \
          "given (#{args.size} for 1)") if args.size != 3

        input_hash = args[0]
        user = args[1]
        host = args[2]

        raise(Puppet::ParseError, 'sshkeys_restruct_to_hash(): first argument should be a hash') unless input_hash.is_a?(Hash) # rubocop:disable Metrics/LineLength

        keys_hash = Hash[]

        input_hash.each do |x, val|
          raise(Puppet::ParseError, 'sshkeys_restruct_to_hash(): wrong structure of input hash') if !val['key'] || !val['type'] # rubocop:disable Metrics/LineLength
          keys_hash["#{x}_at_#{user}@#{host}"] = Hash[
            'key_name' => x,
            'user'     => user,
            'key'      => val['key'],
            'type'     => val['type'],
            ]
        end

        return keys_hash
      end
    end
  end
end
