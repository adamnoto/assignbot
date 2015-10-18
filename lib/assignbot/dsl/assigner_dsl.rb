module Assignbot
  class AssignerDsl
    attr_reader :target_class

    def initialize(target_class)
      @target_class = target_class
      # assignable instance
      @assignable_ic = Core.get_assignable(target_class)
    end

    def set(target_variable, source_variable, receptor)
      @assignable_ic.add_variable(:default, 
                                  target_variable, 
                                  source_variable, 
                                  receptor)
    end

    def method_missing(name, *args, &block)
      params = args[0]
      fail DslError, "Put in hash as an argument!" unless params.is_a?(Hash)
      
      source_variable = params[:from] || params['from']
      set(name, source_variable, :"#{source_variable}=")
    end
  end
end
