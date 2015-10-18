module Assignbot
  # assignable represent the class, it has many assigner
  class Assignable
    # all instances of assigners, type: Hash
    attr_reader :assigners
    # the target class of it
    attr_reader :target_class

    def initialize(target_class)
      @target_class = target_class
      @assigners = {}
    end

    def add_assigner(assigner)
      assigner_name = Assigner.canonify_name(assigner.name)
      assigners[assigner_name] = assigner
      nil
    end

    def get_assigner(assigner_name)
      assigner = assigners[Assigner.canonify_name(assigner_name)]
      assigner
    end

    def add_variable(assigner_name,
                     target_variable,
                     source_variable,
                     receptor)

      # create one instance of Assigner unless defined
      assigner = get_assigner(assigner_name)
      if assigner.nil?
        assigner = Assigner.new(self, assigner_name)
        add_assigner(assigner)
      end

      variable = Variable.new(assigner)
      variable.target_variable = target_variable
      variable.source_variable = source_variable
      variable.receptor = receptor
      assigner.add_variable(variable)

      nil
    end
  end
end
