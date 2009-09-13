# Include hook code here
require "active_record"
require 'password_strength_validator'
require File.dirname(__FILE__) + "/lib/string_ext.rb"

ActiveRecord::Base.send(:include, PasswordStrengthValidator)


