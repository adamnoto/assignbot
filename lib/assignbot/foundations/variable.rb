module Assignbot
  class Variable
    attr_reader :assigner
    
    # the variable to which the value will be copied to
    attr_accessor :target_variable
    attr_accessor :source_variable

    # receptor, receive value
    attr_accessor :receptor 

    def initialize(assigner)
      @assigner = assigner
    end
  end
end
