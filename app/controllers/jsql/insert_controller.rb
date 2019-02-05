module Jsql
  class InsertController < JSQLController
    def create
      perform_method('insert')
    end
  end
end