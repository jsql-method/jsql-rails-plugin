module Jsql
  class Configuration
    attr_accessor :member_key, :api_key

    def initialize
      @member_key = nil
      @api_key = nil
    end
  end
end