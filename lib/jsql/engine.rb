module Jsql
  class Engine < ::Rails::Engine
    begin
      isolate_namespace Jsql
    rescue NameError
      puts "znalazłem problem w engine.rb!"
    end

  end
end
