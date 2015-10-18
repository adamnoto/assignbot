module Assignbot
  # assignable has many assigner, the default
  # assigner is named :default. one can design assigner from
  # params which is from JSON, or from XML. if unnamed,
  # then use :default as name
  class Assigner
    attr_reader :assignable
    attr_reader :name
    # all variables, based on target_variable
    attr_reader :variables

    def self.canonify_name(name)
      unless name.is_a?(String) || name.is_a?(Symbol)
        fail DslError, "Name must be either symbol or string, got: #{name}" 
      end
      name.to_s.downcase.tr(' ', '_').to_sym
    end

    def initialize(assignable, assigner_name)
      @assignable = assignable
      @name = assigner_name
      @variables = {}
    end

    def get_variable(target_variable)
      @variables[target_variable]
    end

    def add_variable(variable)
      @variables[variable.target_variable] = variable
    end
  end
end
