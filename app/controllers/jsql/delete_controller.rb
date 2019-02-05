module Jsql
  class DeleteController < JSQLController
    def create
      perform_method('delete')
    end
  end
end