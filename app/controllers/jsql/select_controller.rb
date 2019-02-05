module Jsql
  class SelectController < JSQLController
    def create
      perform_method('select')
    end
  end
end