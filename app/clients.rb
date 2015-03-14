module Clients

end
require_relative "clients/client"
Dir[File.dirname(__FILE__) + '/clients/*.rb'].each {|file| require file }
