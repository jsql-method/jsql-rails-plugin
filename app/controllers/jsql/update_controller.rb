module Jsql
  class UpdateController < JSQLController
    def create
      perform_method('update')
    end
  end
end