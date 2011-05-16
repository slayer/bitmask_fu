require File.join(File.dirname(__FILE__), "lib", "bitmask_fu")

ActiveRecord::Base.instance_eval do
  include BitmaskFu
end
