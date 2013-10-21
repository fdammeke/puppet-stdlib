module Puppet::Parser::Functions
  newfunction(:generate_md5, :type => :rvalue, :doc => <<-EOS
Converts a string to a salted-MD5 password hash, given an optional salt.
EOS
  ) do |arguments|
    require 'unix_crypt'

    raise(Puppet::ParseError, "generate_md5(): Wrong number of arguments " +
      "given (#{arguments.size} for 1 or 2)") if arguments.size < 1

    raise(Puppet::ParseError, "generate_md5(): Wrong number of arguments " +
      "given (#{arguments.size} for 1 or 2)") if arguments.size > 2

    password = arguments[0]
    salt = arguments[1] || nil

    unless password.is_a?(String)
      raise(Puppet::ParseError, 'generate_md5(): Requires a ' +
        "String argument, you passed: #{password.class}")
    end

    if salt.nil?
      return UnixCrypt::MD5.build(password)
    else
      return UnixCrypt::MD5.build(password, salt)
    end
  end
end

# vim: set ts=2 sw=2 et :
