# This is an autogenerated function, ported from the original legacy version.
# It /should work/ as is, but will not have all the benefits of the modern
# function API. You should see the function docs to learn how to add function
# signatures for type safety and to document this function using puppet-strings.
#
# https://puppet.com/docs/puppet/latest/custom_functions_ruby.html
#
# ---- original file header ----
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
# ---- original file header ----
#
# @summary
#   Converts the input array to the according sshkeys hash
#
Puppet::Functions.create_function(:'sshkeys::sshkeys_convert_to_hash') do
  # @param args
  #   The original array of arguments. Port this to individually managed params
  #   to get the full benefit of the modern function API.
  #
  # @return [Data type]
  #   Describe what the function returns here
  #
  dispatch :default_impl do
    # Call the method named 'default_impl' when this is matched
    # Port this to match individual params for better type safety
    repeated_param 'Any', :args
  end


  def default_impl(*args)
    
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
