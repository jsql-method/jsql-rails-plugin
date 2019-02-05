module Jsql
  class ExecuteController < JSQLController
    def create
      perform_method('commit')
    end

    def perform_method(method)
      manager = transaction_control
      manager.commit_transaction
    end
  end
end